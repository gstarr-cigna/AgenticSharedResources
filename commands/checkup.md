Validate the enterprise Claude Code installation and produce a diagnostic report.

This checks file integrity, configuration, permissions, auth state, and
proxy connectivity — everything needed to diagnose setup issues.

## What to do

Detect the platform and run the appropriate checkup script:

### macOS / Linux

```bash
bash ~/.claude-code-auth/bin/checkup.sh
```

### Windows

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude-code-auth\bin\checkup.ps1"
```

If the script is not found, tell the user to re-run the installer first.

Show the full output to the user. If there are any FAIL or WARN items,
briefly explain what each one means and suggest how to fix it.

## Notes

- Also available as `claude-checkup` from any terminal (no Claude Code needed).
  This is useful when Claude Code itself is not working.
- No tokens or API keys are included in the output. Proxy URLs are redacted
  if they contain credentials, so the report is generally safe to share.
  Review the output before posting to a support ticket.
