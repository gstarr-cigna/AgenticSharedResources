#!/usr/bin/env bash
# install.sh — Bootstrap team agentic resources onto a local machine.
# Safe to re-run; all operations are idempotent.
#
# Usage:
#   ./install.sh                      # install core skills + everything else
#   ./install.sh --dry-run            # print what would happen, write nothing
#   ./install.sh --force              # overwrite existing MCP server entries
#   ./install.sh --extended           # also install all extended skills
#   ./install.sh --skill <name>       # install one extended skill by name

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_TARGET="${SKILLS_TARGET:-$HOME/agents/skills}"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
CURSOR_DIR="${CURSOR_DIR:-$HOME/.cursor}"

DRY_RUN=0
FORCE=0
EXTENDED=0
INSTALL_SKILL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run)  DRY_RUN=1;          shift ;;
    -f|--force)    FORCE=1;            shift ;;
    -e|--extended) EXTENDED=1;         shift ;;
    --skill)       INSTALL_SKILL="$2"; shift 2 ;;
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

# Returns 0 if $skill_dir/SKILL.md targets $client (or has no clients field).
skill_targets_client() {
  local skill_dir="$1" client="$2"
  local skill_md="$skill_dir/SKILL.md"
  [[ -f "$skill_md" ]] || return 0  # no SKILL.md → install everywhere

  python3 - "$skill_md" "$client" <<'EOF'
import sys, re

path, client = sys.argv[1], sys.argv[2]
with open(path) as f:
    content = f.read()

# Extract YAML frontmatter between --- delimiters
match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
if not match:
    sys.exit(0)  # no frontmatter → install everywhere

fm = match.group(1)
clients_match = re.search(r'^clients:\s*\[([^\]]*)\]', fm, re.MULTILINE)
if not clients_match:
    sys.exit(0)  # no clients field → install everywhere

clients = [c.strip() for c in clients_match.group(1).split(',')]
sys.exit(0 if client in clients else 1)
EOF
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

# Link a single skill directory into SKILLS_TARGET.
link_skill() {
  local skill_dir="$1"
  local skill_name; skill_name="$(basename "$skill_dir")"
  local target_link="$SKILLS_TARGET/$skill_name"

  if ! skill_targets_client "$skill_dir" "claude"; then
    info "Skipping '$skill_name': not targeting claude"
    return
  fi

  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry]   would link skill: $skill_name"
    return
  fi

  if [[ -L "$target_link" ]]; then
    local current; current="$(readlink "$target_link")"
    if [[ "$current" != "$skill_dir" ]]; then
      ln -sfn "$skill_dir" "$target_link"
      info "Updated skill symlink: $skill_name"
    fi
  elif [[ -d "$target_link" ]]; then
    warn "Skipping '$skill_name': a real directory already exists at $target_link"
  else
    ln -s "$skill_dir" "$target_link"
    success "Linked skill: $skill_name"
  fi
}

install_skills() {
  # --skill <name>: install one extended skill on demand
  if [[ -n "$INSTALL_SKILL" ]]; then
    local skill_dir="$REPO_DIR/skills/extended/$INSTALL_SKILL"
    if [[ ! -d "$skill_dir" ]]; then
      err "Extended skill not found: $INSTALL_SKILL"
      err "Run: find skills/extended -maxdepth 2 -name 'SKILL.md' to browse available skills"
      exit 1
    fi
    [[ $DRY_RUN -eq 0 ]] && mkdir -p "$SKILLS_TARGET"
    link_skill "$skill_dir"
    return
  fi

  info "Installing core skills → $SKILLS_TARGET"
  [[ $DRY_RUN -eq 0 ]] && mkdir -p "$SKILLS_TARGET"

  local linked=0
  for skill_dir in "$REPO_DIR/skills/core"/*/; do
    [[ -d "$skill_dir" ]] || continue
    link_skill "$skill_dir"
    linked=$((linked + 1))
  done
  [[ $linked -eq 0 ]] && info "No core skills found"

  if [[ $EXTENDED -eq 1 ]]; then
    info "Installing extended skills → $SKILLS_TARGET"
    for skill_dir in "$REPO_DIR/skills/extended"/*/; do
      [[ -d "$skill_dir" ]] || continue
      link_skill "$skill_dir"
    done
  else
    local ext_count; ext_count=$(find "$REPO_DIR/skills/extended" -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' ')
    info "$ext_count extended skills available — use --extended to install all, or --skill <name> for one"
  fi

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

# ── Commands ─────────────────────────────────────────────────────────────────

install_commands() {
  local commands_src="$REPO_DIR/commands"
  [[ -d "$commands_src" ]] || return

  local any=0
  for f in "$commands_src"/*.md; do [[ -f "$f" ]] && any=1 && break; done
  [[ $any -eq 0 ]] && return

  info "Installing slash commands → $CLAUDE_DIR/commands"
  [[ $DRY_RUN -eq 0 ]] && mkdir -p "$CLAUDE_DIR/commands"

  for cmd in "$commands_src"/*.md; do
    [[ -f "$cmd" ]] || continue
    local name; name="$(basename "$cmd")"
    local target="$CLAUDE_DIR/commands/$name"

    if [[ $DRY_RUN -eq 1 ]]; then
      echo "[dry]   would link command: $name"
      continue
    fi

    if [[ -L "$target" ]]; then
      local current; current="$(readlink "$target")"
      if [[ "$current" != "$cmd" ]]; then
        ln -sfn "$cmd" "$target"
        info "Updated command symlink: $name"
      fi
    elif [[ -f "$target" ]]; then
      warn "Skipping command '$name': a real file already exists at $target"
    else
      ln -s "$cmd" "$target"
      success "Linked command: $name"
    fi
  done
}

# ── Git Hooks ────────────────────────────────────────────────────────────────

install_git_hooks() {
  local git_hooks_src="$REPO_DIR/hooks/git"
  [[ -d "$git_hooks_src" ]] || return

  local git_dir
  git_dir="$(git -C "$REPO_DIR" rev-parse --git-dir 2>/dev/null || true)"
  [[ -z "$git_dir" ]] && { info "Not a git repo — skipping git hook install."; return; }
  [[ "$git_dir" != /* ]] && git_dir="$REPO_DIR/$git_dir"

  local hooks_dst="$git_dir/hooks"

  info "Installing git hooks → $hooks_dst"
  [[ $DRY_RUN -eq 0 ]] && mkdir -p "$hooks_dst"

  for hook in "$git_hooks_src"/*; do
    [[ -f "$hook" ]] || continue
    local name; name="$(basename "$hook")"
    local target="$hooks_dst/$name"

    if [[ $DRY_RUN -eq 1 ]]; then
      echo "[dry]   would install git hook: $name"
      continue
    fi

    cp "$hook" "$target"
    chmod +x "$target"
    success "Installed git hook: $name"
  done
}

# ── INDEX.md ──────────────────────────────────────────────────────────────────

regenerate_index() {
  [[ $DRY_RUN -eq 1 ]] && { echo "[dry]   would regenerate INDEX.md"; return; }

  python3 - "$REPO_DIR" <<'EOF'
import os, re, sys

repo = sys.argv[1]
skills_dir = os.path.join(repo, "skills")
core_rows = []
ext_rows = []

for tier, subdir in [("core", os.path.join(skills_dir, "core")), ("extended", os.path.join(skills_dir, "extended"))]:
    if not os.path.isdir(subdir):
        continue
    for root, dirs, files in os.walk(subdir):
        dirs.sort()
        if "SKILL.md" not in files:
            continue
        rel = os.path.relpath(root, skills_dir)
        description = ""
        with open(os.path.join(root, "SKILL.md")) as f:
            content = f.read()
        body = re.sub(r'^---.*?---\s*', '', content, flags=re.DOTALL)
        for line in body.splitlines():
            line = line.strip()
            if not line or line.startswith('#') or line.startswith('<!--') or line.startswith('**'):
                continue
            description = line[:90]
            break
        row = (rel, f"skills/{rel}", description)
        if tier == "core":
            core_rows.append(row)
        else:
            ext_rows.append(row)

def make_table(rows):
    lines = ["| Skill | Path | Description |", "|-------|------|-------------|"]
    for name, path, desc in rows:
        lines.append(f"| `{name}` | `{path}` | {desc.replace('|', chr(92)+'|')} |")
    return "\n".join(lines)

new_section = (
    "### Core Skills\n\n"
    "Always installed. High-frequency skills for daily use.\n\n"
    + make_table(core_rows) + "\n\n"
    + "### Extended Skills\n\n"
    "On-demand. Install with `./install.sh --skill <name>` or all with `./install.sh --extended`.\n\n"
    + make_table(ext_rows) + "\n"
)

index_path = os.path.join(repo, "INDEX.md")
with open(index_path) as f:
    index = f.read()

updated = re.sub(
    r'(?:### Core Skills|\| Skill \| Path \| Description \|).*?(?=\nTo add a skill:)',
    new_section,
    index,
    flags=re.DOTALL
)

with open(index_path, "w") as f:
    f.write(updated)

print(f"[ok]    INDEX.md regenerated ({len(core_rows)} core, {len(ext_rows)} extended skills)")
EOF
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
  require python3

  [[ $DRY_RUN -eq 1 ]] && echo "=== DRY RUN — no files will be written ==="
  echo "=== AgenticSharedResources install ==="
  echo "Repo:   $REPO_DIR"
  echo "Skills: $SKILLS_TARGET"
  echo "Claude: $CLAUDE_DIR"
  [[ $FORCE -eq 1 ]] && echo "Force:  yes (MCP entries will be overwritten)"
  echo ""

  install_skills
  install_commands
  install_mcp
  install_claude_config
  install_cursor_config
  install_hooks
  install_git_hooks
  regenerate_index

  echo ""
  echo "=== Done ==="
}

main "$@"
