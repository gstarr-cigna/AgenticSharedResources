---
name: opencode-schedule
description: Schedule reminders and recurring tasks for opencode and AI assistants without built-in cron/scheduling. Use when the user wants to be reminded of something later, set up a recurring check, poll for status, or schedule a future action. Bridges the gap where opencode has no equivalent of Claude Code's CronCreate tool.
---

# opencode Schedule

Schedules reminders and recurring tasks using the OS `cron` / `at` / `launchd` since opencode has no built-in scheduler.

## One-shot reminders

### macOS / Linux — using `at`
```bash
# Remind in 30 minutes
echo 'osascript -e "display notification \"Check the deploy\" with title \"Reminder\""' | at now + 30 minutes

# Remind at a specific time
echo 'osascript -e "display notification \"Stand-up time\" with title \"Reminder\""' | at 09:00
```

### Cross-platform — using a background sleep
```bash
# Run a command in 5 minutes (fires even if shell is closed if nohup'd)
(sleep 300 && osascript -e 'display notification "5 min check" with title "Reminder"') &
echo "Reminder set for 5 minutes from now (PID: $!)"
```

## Recurring tasks

### Using cron (macOS/Linux)
```bash
# Edit crontab
crontab -e

# Example entries:
# Every day at 9am — remind to check deploys
# 0 9 * * * osascript -e 'display notification "Check deploys" with title "Daily"'

# Every 15 minutes — run health check script
# */15 * * * * /path/to/project/scripts/health-check.sh >> /tmp/health.log 2>&1
```

### List/remove scheduled jobs
```bash
crontab -l          # list
crontab -r          # remove all
crontab -e          # edit (remove specific lines)
```

## Protocol

When the user asks to schedule something:

1. Clarify: one-shot or recurring?
2. Clarify: what should happen (notification, script, log entry)?
3. Choose the right mechanism:
   - One-shot, within the hour → `sleep` + background process
   - One-shot, specific time → `at`
   - Recurring → `cron`
4. Show the command, ask for confirmation, then run it
5. Confirm with: `crontab -l` or note the PID

## Polling for status

If the user wants to "check every N minutes until X":

```bash
# Poll every 60s until a condition is met
while true; do
  if your-check-command; then
    osascript -e 'display notification "Done!" with title "Poll"'
    break
  fi
  sleep 60
done &
echo "Polling started (PID: $!). Kill with: kill $!"
```
