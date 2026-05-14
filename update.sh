#!/usr/bin/env bash
# update.sh — Pull latest changes and re-apply the install.
# Run this instead of git pull to keep local resources in sync.
# Accepts the same flags as install.sh (--dry-run, --force).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STASHED=0

# Pop the stash on any exit (success, failure, or signal) if we stashed.
cleanup() {
  if [[ "$STASHED" -eq 1 ]]; then
    echo "[info]  Restoring stashed changes."
    git -C "$REPO_DIR" stash pop \
      || echo "[warn]  Could not auto-restore stash — run: git -C $REPO_DIR stash pop"
  fi
}
trap cleanup EXIT

echo "=== team-agents update ==="

# Verify we're on a real branch, not a detached HEAD.
current_branch="$(git -C "$REPO_DIR" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "UNKNOWN")"
if [[ "$current_branch" == "HEAD" || "$current_branch" == "UNKNOWN" ]]; then
  echo "[warn]  Detached HEAD or unknown branch — skipping git pull."
  echo "        Run 'git -C $REPO_DIR checkout <branch>' then re-run this script."
else
  # Stash uncommitted changes so the pull can proceed cleanly.
  if ! git -C "$REPO_DIR" diff --quiet || ! git -C "$REPO_DIR" diff --cached --quiet; then
    echo "[warn]  Uncommitted changes detected. Stashing before pull."
    git -C "$REPO_DIR" stash push -m "update.sh auto-stash $(date +%Y%m%dT%H%M%S)"
    STASHED=1
  fi

  if ! git -C "$REPO_DIR" pull --ff-only 2>&1; then
    echo "[error] Fast-forward pull failed. Your branch may have diverged."
    echo "        Resolve manually, then re-run ./update.sh"
    exit 1
  fi
fi

echo ""
echo "Re-running install to sync new resources..."
echo ""

# Pass any flags (--dry-run, --force) through to install.sh
"$REPO_DIR/install.sh" "$@"

echo ""
echo "=== Update complete ==="
