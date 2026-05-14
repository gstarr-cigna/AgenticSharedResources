---
name: opencode-task-tracker
description: Persistent task tracking via TODO.md for opencode and any AI coding assistant that lacks built-in todo/task management. Use when the user asks to track tasks, create a todo list, manage progress on a multi-step task, or when working on complex tasks in opencode. Bridges the gap where opencode has no equivalent of Claude Code's TaskCreate/TaskUpdate/TaskList tools.
---

# opencode Task Tracker

Manages tasks via a `TODO.md` file in the project root — readable by any tool, editor, or AI assistant including opencode.

## When to use

- Multi-step tasks (3+ steps)
- User asks to track progress
- Complex refactors or feature implementations
- Any session where losing track of state is a risk

## Task file location

Always use `TODO.md` in the **project root** (current working directory).

## Format

```markdown
# Tasks

## In Progress
- [ ] ~Task description~ *(started: YYYY-MM-DD)*

## Pending
- [ ] Task description
- [ ] Another task

## Completed
- [x] Done task *(done: YYYY-MM-DD)*
```

## Workflow

1. **Create** `TODO.md` if it doesn't exist — use the format above
2. **Start a task** — move it to "In Progress", add started date
3. **Complete a task** — move to "Completed", mark `[x]`, add done date
4. **Only one task in_progress at a time**
5. **After each task** — re-read `TODO.md` to pick the next pending task

## Rules

- Keep task descriptions imperative and actionable ("Add login endpoint", not "login endpoint")
- Never mark complete unless fully done (tests pass, no partial work)
- If blocked, add a note: `- [ ] Task *(blocked: reason)*`
- If a task spawns subtasks, indent them with two spaces under the parent

## Syncing with opencode

opencode reads `TODO.md` as part of the project context if referenced in `AGENTS.md`. Add this to your project's `AGENTS.md`:

```markdown
## Task tracking
Current tasks are in TODO.md. Check it at the start of each session and update it as you complete work.
```
