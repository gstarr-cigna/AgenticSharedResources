# MCP Servers

`servers.json` is the team registry of shared MCP servers. `install.sh` reads it and merges entries into `~/.claude/settings.json` (and equivalent for other tools).

## Adding a Server

1. Add an entry to `servers.json` under `mcpServers`.
2. For servers that need a local binary or config file, add a subdirectory under `servers/<name>/` with a `README.md` explaining setup.
3. Run `./install.sh` to register.

## Format

```json
{
  "mcpServers": {
    "<server-name>": {
      "command": "<binary or npx>",
      "args": ["<arg1>", "<arg2>"],
      "env": {
        "SOME_VAR": "value"
      }
    }
  }
}
```

For SSE/HTTP transports use `"type": "sse"` and `"url"` instead of `command`/`args`.

## Secrets

Never commit API keys or tokens into `servers.json`. Use env var references (`"${MY_API_KEY}"`) and document required vars in the server's `servers/<name>/README.md`.
