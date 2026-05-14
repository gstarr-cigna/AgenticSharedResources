Toggle desktop notifications for Claude Code on this machine.

## Usage

- `/notifications off` — disable desktop notifications
- `/notifications on`  — re-enable desktop notifications
- `/notifications`     — show current status

## What to do

The opt-out flag file is `~/.claude-code-auth/disable-notifications`.
Its presence disables notifications; its absence enables them.

### If $ARGUMENTS is "off" or "disable"

Use the Bash tool to create the flag file:

```bash
touch ~/.claude-code-auth/disable-notifications
```

Then confirm: "Desktop notifications are now **disabled**. Run `/notifications on` to re-enable."

### If $ARGUMENTS is "on" or "enable"

Use the Bash tool to remove the flag file if it exists:

```bash
rm -f ~/.claude-code-auth/disable-notifications
```

Then confirm: "Desktop notifications are now **enabled**. Run `/notifications off` to disable."

### If $ARGUMENTS is empty or "status"

Use the Bash tool to check whether the flag file exists:

```bash
test -f ~/.claude-code-auth/disable-notifications && echo disabled || echo enabled
```

Report: "Desktop notifications are currently: **[enabled/disabled]**."

## Notes

- The change takes effect immediately — no restart needed.
- This only affects notifications on this machine for your account.
- On Windows, use the same command — it works the same way.
