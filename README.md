# AgenticSharedResources

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
git clone <this-repo> ~/projects/AgenticSharedResources
cd ~/projects/AgenticSharedResources
./install.sh
```

See [docs/onboarding.md](docs/onboarding.md) for full setup.

## Related Resources

### [BreakthroughBehavioralInc/dev_scripts](https://github.com/BreakthroughBehavioralInc/dev_scripts)

Shared developer scripts for common repo and environment tasks. Source into your shell or run directly.

| Script | What it does |
|--------|-------------|
| `compare_branches.rb` | Finds commits present in one branch but not another, comparing by message (safe across cherry-picks). Useful for checking what hasn't been promoted to a QA branch yet. Requires `$PROJECTS_DIR` env var. |
| `compare_with_latest_release.sh` | Diffs a branch against the repo's latest GitHub release — shows full diff, new commits, and missing commits. Source into `~/.zshrc`; requires `jq` and `$NPM_TOKEN`. |
| `db_backup.sh` | Dumps and compresses `telehealth_development` MySQL database to `~/backups/mysql/`, keeping 15 days of rolling backups. Run as a cron job (e.g. `0 11 * * *`). |
| `find_duplicate_methods.rb` | Scans a Ruby codebase with Ripper and reports duplicate method definitions — within files by default, or across the whole project with `--across`. |
| `find_mismatching_commits.rb` | Detects bad cherry-picks: compares two branches by commit message and flags any commits whose line-change stats differ between branches. |
| `make_log_readable.rb` | Converts JSON-formatted Rails logs into human-readable output. Pipe or pass a saved log excerpt as an argument. |
| `qa_reset.sh` | Resets a QA branch to the latest GitHub release tag (with a confirmation prompt). Also creates a `-backup` branch before destructive resets. Source into `~/.zshrc`; requires `jq` and `$NPM_TOKEN`. |
