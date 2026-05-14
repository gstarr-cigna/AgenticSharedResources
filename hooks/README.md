# Hooks

This directory contains two kinds of hooks.

## Git Hooks (`hooks/git/`)

Installed into `.git/hooks/` by `install.sh`. Keep the repo consistent on every commit.

| Hook | What it does |
|------|-------------|
| `pre-commit` | Runs `package.sh` — injects missing frontmatter, regenerates INDEX.md, stages results |

Add new git hooks here; `install.sh` installs everything in `hooks/git/` automatically.

## Claude Code Lifecycle Hooks (`hooks/*.sh`)

Shell scripts placed here are copied to `~/.claude/hooks/` by `install.sh`, made executable, and **automatically registered** in `~/.claude/settings.json` under the correct lifecycle key.

## Naming Convention

The lifecycle is inferred from the filename prefix:

| Filename prefix | Registered as |
|-----------------|---------------|
| `pre-tool-use-*.sh` | `PreToolUse` |
| `post-tool-use-*.sh` | `PostToolUse` |
| `notification-*.sh` | `Notification` |
| `stop-*.sh` | `Stop` |

Files that don't match a prefix are copied but **not** registered (a warning is printed).

## Example

```
hooks/
  pre-tool-use-log-bash.sh     → registered under PreToolUse
  post-tool-use-audit.sh       → registered under PostToolUse
```

## Guidelines

- Hooks must be fast and idempotent — they run on every matching agent action.
- Write errors to stderr; write status output to stdout.
- Exit non-zero to signal failure to the agent.
- Never hard-code absolute paths — use `$HOME` and environment variables.
- Document any required env vars in `docs/onboarding.md`.
