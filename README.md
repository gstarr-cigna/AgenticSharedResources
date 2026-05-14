# team-agents

Shared agentic resources for the team — skills, MCP server configs, prompts, hooks, and agent settings.

## What's here

| Directory | Purpose |
|-----------|---------|
| `skills/` | Agent slash-command skills (Claude Code, Cursor, etc.) |
| `mcp/` | MCP server registry and per-server configs |
| `config/` | Base agent settings per tool |
| `prompts/` | Reusable system prompts and prompt fragments |
| `hooks/` | Shared lifecycle hooks |
| `docs/` | Onboarding and contribution guides |

## Quickstart

```bash
git clone <this-repo> ~/projects/team-agents
cd ~/projects/team-agents
./install.sh
```

See [docs/onboarding.md](docs/onboarding.md) for full setup.
