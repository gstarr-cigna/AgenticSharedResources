# Onboarding

## Prerequisites

- `python3` in PATH (used by `install.sh` for JSON merging)
- `git`
- Claude Code or Cursor installed

## Install

```bash
git clone <repo-url> ~/projects/team-agents
cd ~/projects/team-agents
./install.sh
```

That's it. The script:

1. Symlinks each skill in `skills/` into `~/agents/skills/` (skipping `_template`)
2. Registers MCP servers from `mcp/servers.json` into `~/.claude/settings.json`
3. Merges base Claude permissions from `config/claude/settings.json`
4. Copies any hooks from `hooks/` into `~/.claude/hooks/`

## Update

When the repo is updated, pull and re-run:

```bash
./update.sh
```

`update.sh` pulls the latest changes and re-runs `install.sh`.

## Environment Variables Required by MCP Servers

| Variable | Used By | Where to Set |
|----------|---------|--------------|
| *(add rows as servers are added)* | | |

## Adding a Skill

See `skills/_template/SKILL.md` and [CONTRIBUTING.md](CONTRIBUTING.md).
