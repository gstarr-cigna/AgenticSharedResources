# AgenticSharedResources INDEX

This file is the machine-readable entry point for agents and LLMs. Read this first to understand what is available and where to find it. All paths are relative to the repo root.

## Skills

Agent slash-command skills. Each skill is a directory containing a `SKILL.md` that describes what it does, when to invoke it, inputs, outputs, and step-by-step instructions.

| Skill | Path | Description |
|-------|------|-------------|
| *(none yet — add rows as skills are added)* | | |

To add a skill: copy `skills/_template/` to `skills/<name>/`, fill in `SKILL.md`, run `./install.sh`.

## MCP Servers

Shared MCP server definitions. Active entries (not prefixed with `_`) in `mcp/servers.json` are registered into `~/.claude/settings.json` by `install.sh`.

- Registry: `mcp/servers.json`
- Per-server setup docs: `mcp/servers/<name>/README.md`

## Prompts

Reusable prompt content.

| Type | Path | Contents |
|------|------|----------|
| Persona | `prompts/personas/senior-engineer.md` | Role-based system prompt for senior engineer behavior |
| Template | `prompts/templates/code-review.md` | Structured code review output format |
| Template | `prompts/templates/incident-triage.md` | Structured incident triage output format |

To use a prompt: read the file and include its content in your system prompt or message.

## Config

Base agent settings, merged (not replaced) into local config by `install.sh`.

| File | Applied to |
|------|-----------|
| `config/claude/settings.json` | `~/.claude/settings.json` |
| `config/cursor/settings.json` | `~/.cursor/settings.json` |

## Hooks

Lifecycle hook scripts. Placed in `hooks/`, named by lifecycle prefix (see `hooks/README.md`). `install.sh` copies them to `~/.claude/hooks/` and registers them in `~/.claude/settings.json`.

## How to Install

```bash
./install.sh              # first-time setup
./install.sh --dry-run    # preview changes without writing
./update.sh               # pull latest + re-install
./update.sh --force       # pull latest + overwrite existing MCP entries
```

## How to Discover Resources Programmatically

- **All skills**: `find skills/ -name "SKILL.md" -not -path "*/_template/*"`
- **All prompts**: `find prompts/ -name "*.md"`
- **MCP registry**: `cat mcp/servers.json`
- **This index**: `cat INDEX.md`
