---
name: opencode-agents-md
description: Create and maintain AGENTS.md files for opencode projects. AGENTS.md is opencode's equivalent of Cursor rules and skills — it injects persistent instructions into every session. Use when setting up a new project for opencode, when the user wants opencode to follow project conventions, or when bridging Cursor rules/skills into an opencode-compatible format.
---

# opencode AGENTS.md

`AGENTS.md` is opencode's primary mechanism for persistent AI instructions — equivalent to Cursor's `.cursor/rules/` and skills combined.

## File locations (in priority order)

| Location | Scope |
|---|---|
| `~/.config/opencode/AGENTS.md` | Global — all projects |
| `AGENTS.md` (project root) | Project-wide |
| `<subdir>/AGENTS.md` | Directory-scoped (when working in that dir) |

## Structure template

```markdown
# [Project Name] — AI Instructions

## Project overview
[1-2 sentences: what this project is, main tech stack]

## Code conventions
- Language/framework versions
- Style rules (e.g., "use named exports", "prefer functional components")
- File naming conventions

## Architecture
- Where business logic lives
- Where API calls are made
- Key patterns to follow (e.g., "use the repository pattern")

## Automated checks (hooks)
After editing source files, run: `npm run lint`
Before committing: `npm test`

## Task tracking
Current tasks are in TODO.md. Check it at session start, update as you work.

## Planning
For changes touching 3+ files, write PLAN.md first and wait for approval.

## Out of bounds
- Never modify [protected files/dirs]
- Never commit to main directly
```

## What to include

**Include:**
- Tech stack and versions (so the AI doesn't guess)
- File structure conventions
- Which commands to run after edits
- What to check before committing
- Anything the AI consistently gets wrong

**Exclude:**
- Things any good developer already knows
- Obvious things (don't add `console.log`)
- Information that changes frequently

## Converting Cursor rules to AGENTS.md

If you have `.cursor/rules/*.md` files:
1. Read each rule file
2. Extract the persistent guidance (not tool-specific stuff)
3. Consolidate into `AGENTS.md` sections

## Syncing the bridge skills

To get all opencode bridge skills working in a project, add this to `AGENTS.md`:

```markdown
## Session conventions

**Task tracking**: Maintain TODO.md. At session start, read it. Update as tasks complete.

**Planning**: For non-trivial changes (3+ files), write PLAN.md and wait for user approval before coding.

**Hooks**: After editing source files, run `npm run lint`. After editing .ts files, run `npx tsc --noEmit`. Report failures.

**Experiments**: Use `git worktree add .worktrees/<name> -b experiment/<name>` for risky changes.
```
