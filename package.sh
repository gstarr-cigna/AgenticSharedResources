#!/usr/bin/env bash
# package.sh — Prepare contributions before committing.
#
# What it does:
#   1. Injects missing clients frontmatter into SKILL.md files
#   2. Validates that every directory under skills/ contains a SKILL.md
#   3. Regenerates INDEX.md from the current skills/ and commands/ state
#   4. Stages all changes so they're included in the next commit
#
# Run manually before pushing, or automatically via the git pre-commit hook
# (installed by install.sh).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }

# ── 1. Inject missing frontmatter ─────────────────────────────────────────────

inject_frontmatter() {
  info "Checking skill frontmatter..."
  local injected=0

  while IFS= read -r -d '' skill_md; do
    local has_fm
    has_fm=$(python3 - "$skill_md" <<'EOF'
import sys, re
with open(sys.argv[1]) as f:
    content = f.read()
print("yes" if re.match(r'^---\s*\n.*?\n---', content, re.DOTALL) else "no")
EOF
    )
    if [[ "$has_fm" == "no" ]]; then
      python3 - "$skill_md" <<'EOF'
import sys
path = sys.argv[1]
with open(path) as f:
    content = f.read()
with open(path, "w") as f:
    f.write("---\nclients: [claude]\n---\n\n" + content)
EOF
      success "Injected frontmatter: $(realpath --relative-to="$REPO_DIR" "$skill_md")"
      injected=$((injected + 1))
    fi
  done < <(find skills -name "SKILL.md" -not -path "*/_template/*" -print0 2>/dev/null)

  [[ $injected -eq 0 ]] && info "All SKILL.md files have frontmatter"
}

# ── 2. Validate structure ──────────────────────────────────────────────────────

validate_structure() {
  info "Validating structure..."
  local issues=0

  for dir in skills/*/; do
    [[ -d "$dir" ]] || continue
    local name; name="$(basename "$dir")"
    [[ "$name" == "_template" ]] && continue

    # Check if any SKILL.md exists anywhere in this subtree
    local found
    found=$(find "$dir" -name "SKILL.md" | head -1)
    if [[ -z "$found" ]]; then
      warn "No SKILL.md found in: $dir (directory will be ignored by install.sh)"
      issues=$((issues + 1))
    fi
  done

  [[ $issues -eq 0 ]] && info "Structure valid"
  return 0  # Warn but don't block the commit
}

# ── 3. Regenerate INDEX.md ─────────────────────────────────────────────────────

regenerate_index() {
  info "Regenerating INDEX.md..."
  python3 - <<'EOF'
import os, re

skills_dir = "skills"
rows = []

for root, dirs, files in os.walk(skills_dir):
    dirs.sort()
    if "SKILL.md" not in files:
        continue
    rel = os.path.relpath(root, skills_dir)
    if rel == "_template":
        continue
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
    rows.append((rel, f"skills/{rel}", description))

table = ["| Skill | Path | Description |", "|-------|------|-------------|"]
for name, path, desc in rows:
    table.append(f"| `{name}` | `{path}` | {desc.replace('|', chr(92)+'|')} |")

with open("INDEX.md") as f:
    index = f.read()

updated = re.sub(
    r'(\| Skill \| Path \| Description \|.*?)(\nTo add a skill:)',
    "\n".join(table) + r'\2',
    index,
    flags=re.DOTALL
)

with open("INDEX.md", "w") as f:
    f.write(updated)

print(f"[ok]    INDEX.md regenerated ({len(rows)} skills)")
EOF
}

# ── 4. Stage changes ───────────────────────────────────────────────────────────

stage_changes() {
  local changed
  changed=$(git diff --name-only -- skills/ commands/ INDEX.md 2>/dev/null || true)
  # Also pick up untracked files in skills/ and commands/
  local untracked
  untracked=$(git ls-files --others --exclude-standard -- skills/ commands/ 2>/dev/null || true)

  local all="${changed}${untracked}"
  if [[ -n "$all" ]]; then
    git add skills/ commands/ INDEX.md 2>/dev/null || true
    info "Staged: $(echo "$all" | wc -l | tr -d ' ') file(s)"
    echo ""
    echo "Review staged changes with: git diff --staged"
  else
    info "Nothing new to stage"
  fi
}

# ── Main ───────────────────────────────────────────────────────────────────────

echo "=== package ==="
inject_frontmatter
validate_structure
regenerate_index
stage_changes
echo ""
echo "=== Done ==="
