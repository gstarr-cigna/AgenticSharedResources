# Contributing

## Adding a Skill

1. Copy `skills/_template/` to `skills/<your-skill-name>/`
2. Fill in `SKILL.md` — be specific about trigger conditions and steps
3. Test it locally: run `./install.sh` and invoke the skill in your agent
4. Open a PR with a short description of what the skill does and when you'd reach for it

## Adding an MCP Server

1. Add the server entry to `mcp/servers.json` under `mcpServers`
2. If the server needs local setup (binary install, env vars), add `mcp/servers/<name>/README.md`
3. Never commit credentials — use env var references (`"${MY_VAR}"`)
4. Document required env vars in `docs/onboarding.md`

## Adding a Prompt

- **Personas** (`prompts/personas/`): role-based system prompts that define agent behavior
- **Templates** (`prompts/templates/`): reusable prompt fragments for specific tasks

Keep prompts focused and versioned via git — don't edit in place without a clear reason.

## Updating Config

Config files in `config/` are merged (not replaced) by `install.sh`. Only add keys that should apply to all team members. Machine-specific overrides belong in `~/.zshrc.local` or local settings files.

## Adding a New Client

When the team adopts a new agent client (Cursor, OpenCode, etc.) and wants skills to install there:

1. Add the client name to the valid values comment in `skills/_template/SKILL.md`
2. Add an `install_skills_<client>()` function in `install.sh` that reads `SKILL.md` frontmatter via `skill_targets_client` and installs to the client's expected path
3. Call the new function from `main()` in `install.sh`
4. Update `config/` with a `<client>/settings.json` if the client has mergeable config
5. Document the client's skills path in `docs/onboarding.md`

Existing skills with `clients: [claude]` will be ignored by the new installer unless contributors opt in by adding the new client name to their frontmatter. Skills with no `clients` field install everywhere by default.

## PR Standards

- One logical change per PR
- Update `docs/onboarding.md` if you add env var requirements
- Test `./install.sh` fresh on a clean machine (or note that you haven't)
