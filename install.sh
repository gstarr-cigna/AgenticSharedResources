#!/usr/bin/env bash
# install.sh — Bootstrap team agentic resources onto a local machine.
# Safe to re-run; all operations are idempotent.
#
# Usage:
#   ./install.sh              # normal install
#   ./install.sh --dry-run    # print what would happen, write nothing
#   ./install.sh --force      # overwrite existing MCP server entries

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_TARGET="${SKILLS_TARGET:-$HOME/agents/skills}"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
CURSOR_DIR="${CURSOR_DIR:-$HOME/.cursor}"

DRY_RUN=0
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run) DRY_RUN=1; shift ;;
    -f|--force)   FORCE=1;   shift ;;
    *) echo "[error] Unknown option: $1"; exit 1 ;;
  esac
done

# ── Helpers ──────────────────────────────────────────────────────────────────

info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }
err()     { echo "[error] $*" >&2; }

require() {
  command -v "$1" &>/dev/null || { err "Required tool not found: $1"; exit 1; }
}

backup_file() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  local bak="${file}.bak.$(date +%s)"
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry]   would backup: $(basename "$file") → $(basename "$bak")"
  else
    cp "$file" "$bak"
    info "Backed up: $file → $bak"
  fi
}

# Deep-merge $patch into $target. Dicts are merged recursively; scalars and
# arrays from $patch win on conflict. Backs up $target before writing.
json_deep_merge() {
  local target="$1" patch="$2"
  backup_file "$target"
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry]   would deep-merge $(basename "$patch") → $(basename "$target")"
    return
  fi
  python3 - "$target" "$patch" <<'EOF'
import json, sys

def deep_merge(base, patch):
    for k, v in patch.items():
        if k in base and isinstance(base[k], dict) and isinstance(v, dict):
            deep_merge(base[k], v)
        else:
            base[k] = v

target_path, patch_path = sys.argv[1], sys.argv[2]
with open(target_path) as f: base = json.load(f)
with open(patch_path)  as f: patch = json.load(f)
deep_merge(base, patch)
with open(target_path, "w") as f: json.dump(base, f, indent=2)
EOF
}

ensure_json_file() {
  local path="$1"
  [[ $DRY_RUN -eq 1 ]] && return
  mkdir -p "$(dirname "$path")"
  [[ -f "$path" ]] || echo '{}' > "$path"
}

# ── Skills ───────────────────────────────────────────────────────────────────

install_skills() {
  info "Installing skills → $SKILLS_TARGET"
  [[ $DRY_RUN -eq 0 ]] && mkdir -p "$SKILLS_TARGET"

  local linked=0
  for skill_dir in "$REPO_DIR/skills"/*/; do
    [[ -d "$skill_dir" ]] || continue
    local skill_name; skill_name="$(basename "$skill_dir")"
    [[ "$skill_name" == _template ]] && continue

    local target_link="$SKILLS_TARGET/$skill_name"

    if [[ $DRY_RUN -eq 1 ]]; then
      echo "[dry]   would link skill: $skill_name"
      linked=$((linked + 1))
      continue
    fi

    if [[ -L "$target_link" ]]; then
      local current; current="$(readlink "$target_link")"
      if [[ "$current" != "$skill_dir" ]]; then
        ln -sfn "$skill_dir" "$target_link"
        info "Updated skill symlink: $skill_name"
        linked=$((linked + 1))
      fi
    elif [[ -d "$target_link" ]]; then
      warn "Skipping skill '$skill_name': a real directory already exists at $target_link"
    else
      ln -s "$skill_dir" "$target_link"
      success "Linked skill: $skill_name"
      linked=$((linked + 1))
    fi
  done

  [[ $linked -eq 0 ]] && info "No skills to install (add directories under skills/)"
}

# ── MCP Servers ───────────────────────────────────────────────────────────────

install_mcp() {
  local registry="$REPO_DIR/mcp/servers.json"
  [[ -f "$registry" ]] || { info "No MCP registry found, skipping."; return; }

  info "Registering MCP servers in Claude settings"
  local settings="$CLAUDE_DIR/settings.json"
  ensure_json_file "$settings"

  python3 - "$settings" "$registry" "$FORCE" "$DRY_RUN" <<'EOF'
import json, sys, os

settings_path, registry_path = sys.argv[1], sys.argv[2]
force  = sys.argv[3] == "1"
dry_run = sys.argv[4] == "1"

if dry_run and not os.path.exists(settings_path):
    settings = {}
else:
    with open(settings_path) as f: settings = json.load(f)

with open(registry_path) as f: registry = json.load(f)

# Skip entries whose names start with "_" (examples/disabled)
mcp_servers = {k: v for k, v in registry.get("mcpServers", {}).items()
               if not k.startswith("_")}
if not mcp_servers:
    print("[info]  No active MCP servers in registry (entries starting with _ are skipped)")
    sys.exit(0)

existing = settings.setdefault("mcpServers", {})
added, updated, skipped = [], [], []

for name, cfg in mcp_servers.items():
    if name in existing:
        if force:
            existing[name] = cfg
            updated.append(name)
        else:
            skipped.append(name)
    else:
        existing[name] = cfg
        added.append(name)

if not dry_run:
    with open(settings_path, "w") as f:
        json.dump(settings, f, indent=2)

pfx = "[dry]   would register" if dry_run else "[ok]    Registered"
upx = "[dry]   would update"   if dry_run else "[ok]    Updated"
if added:   print(f"{pfx} MCP servers: {', '.join(added)}")
if updated: print(f"{upx} MCP servers: {', '.join(updated)}")
if skipped: print(f"[warn]  Already registered (skipped): {', '.join(skipped)}")
if skipped: print(f"        Re-run with --force to overwrite.")
EOF
}

# ── Claude Config ─────────────────────────────────────────────────────────────

install_claude_config() {
  local src="$REPO_DIR/config/claude/settings.json"
  [[ -f "$src" ]] || return

  info "Merging Claude config"
  local dst="$CLAUDE_DIR/settings.json"
  ensure_json_file "$dst"
  json_deep_merge "$dst" "$src"
  [[ $DRY_RUN -eq 0 ]] && success "Claude settings merged"
}

# ── Cursor Config ─────────────────────────────────────────────────────────────

install_cursor_config() {
  local src="$REPO_DIR/config/cursor/settings.json"
  [[ -f "$src" ]] || return

  info "Merging Cursor config"
  local dst="$CURSOR_DIR/settings.json"
  ensure_json_file "$dst"
  json_deep_merge "$dst" "$src"
  [[ $DRY_RUN -eq 0 ]] && success "Cursor settings merged"
}

# ── Hooks ─────────────────────────────────────────────────────────────────────
#
# Naming convention → lifecycle mapping:
#   pre-tool-use-*.sh  → PreToolUse
#   post-tool-use-*.sh → PostToolUse
#   notification-*.sh  → Notification
#   stop-*.sh          → Stop

lifecycle_key() {
  case "$1" in
    pre-tool-use*)  echo "PreToolUse"  ;;
    post-tool-use*) echo "PostToolUse" ;;
    notification*)  echo "Notification" ;;
    stop*)          echo "Stop" ;;
    *)              echo "" ;;
  esac
}

install_hooks() {
  local hooks_src="$REPO_DIR/hooks"
  [[ -d "$hooks_src" ]] || return

  # Check if any .sh files exist
  local any=0
  for f in "$hooks_src"/*.sh; do [[ -f "$f" ]] && any=1 && break; done
  [[ $any -eq 0 ]] && return

  info "Installing hooks"
  local hooks_dst="$CLAUDE_DIR/hooks"
  local settings="$CLAUDE_DIR/settings.json"

  if [[ $DRY_RUN -eq 0 ]]; then
    mkdir -p "$hooks_dst"
    ensure_json_file "$settings"
  fi

  for hook in "$hooks_src"/*.sh; do
    [[ -f "$hook" ]] || continue
    local name; name="$(basename "$hook")"
    local lifecycle; lifecycle="$(lifecycle_key "$name")"
    local dst_hook="$hooks_dst/$name"

    if [[ -z "$lifecycle" ]]; then
      warn "Hook '$name' has no recognized lifecycle prefix — skipped (see hooks/README.md)"
      continue
    fi

    if [[ $DRY_RUN -eq 1 ]]; then
      echo "[dry]   would install hook: $name → $dst_hook"
      echo "[dry]   would register hook in settings.json[$lifecycle]"
      continue
    fi

    cp "$hook" "$dst_hook"
    chmod +x "$dst_hook"
    success "Installed hook: $name"

    # Register in settings.json (idempotent — skip if already present)
    backup_file "$settings"
    python3 - "$settings" "$lifecycle" "$dst_hook" <<'PYEOF'
import json, sys

settings_path, lifecycle, hook_path = sys.argv[1], sys.argv[2], sys.argv[3]

with open(settings_path) as f: s = json.load(f)

# Check if this hook is already registered under this lifecycle
for block in s.get("hooks", {}).get(lifecycle, []):
    for h in block.get("hooks", []):
        if h.get("command") == hook_path:
            print(f"[info]  Hook already registered: {hook_path}")
            sys.exit(0)

hook_entry = {"type": "command", "command": hook_path}
s.setdefault("hooks", {}).setdefault(lifecycle, []).append({
    "matcher": "",
    "hooks": [hook_entry]
})

with open(settings_path, "w") as f: json.dump(s, f, indent=2)
print(f"[ok]    Registered hook in settings.json[{lifecycle}]")
PYEOF
  done
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
  require python3

  [[ $DRY_RUN -eq 1 ]] && echo "=== DRY RUN — no files will be written ==="
  echo "=== team-agents install ==="
  echo "Repo:   $REPO_DIR"
  echo "Skills: $SKILLS_TARGET"
  echo "Claude: $CLAUDE_DIR"
  [[ $FORCE -eq 1 ]] && echo "Force:  yes (MCP entries will be overwritten)"
  echo ""

  install_skills
  install_mcp
  install_claude_config
  install_cursor_config
  install_hooks

  echo ""
  echo "=== Done ==="
}

main "$@"
