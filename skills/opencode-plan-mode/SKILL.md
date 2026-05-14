---
name: opencode-plan-mode
description: Structured planning protocol for opencode and AI assistants without built-in plan mode. Use when about to make non-trivial code changes, when the user says "plan first", "think before coding", or when a task touches 3+ files. Bridges the gap where opencode has no equivalent of Claude Code's EnterPlanMode/ExitPlanMode. Creates a PLAN.md for user review before any code is written.
---

# opencode Plan Mode

Emulates plan-then-implement workflow via a `PLAN.md` file that the user reviews before code is written.

## When to invoke

- Task requires changes to 3+ files
- Multiple valid implementation approaches exist
- User says "plan first", "think before coding", "what's your approach"
- Architectural or irreversible decisions

## Protocol

### Phase 1: Explore (read-only)
- Read all relevant files
- Understand existing patterns
- Identify affected components
- Do NOT write any code yet

### Phase 2: Write PLAN.md

Create `PLAN.md` in project root:

```markdown
# Plan: [Task Title]

## Summary
One paragraph describing what will be done and why.

## Approach
Chosen approach and rationale. If alternatives exist, list them briefly.

## Files to change
- `path/to/file.ts` — what changes and why
- `path/to/other.ts` — what changes and why

## New files
- `path/to/new.ts` — purpose

## Steps
1. Step one (estimated: small/medium/large)
2. Step two
3. Step three

## Risks / trade-offs
- Any concerns the user should know about

## Out of scope
- What this plan does NOT do
```

### Phase 3: Wait for approval

After writing `PLAN.md`, tell the user:

> "I've written a plan to `PLAN.md`. Please review it and let me know if you'd like me to proceed, adjust anything, or take a different approach."

**Do not write any code until the user approves.**

### Phase 4: Implement

Once approved, implement per the plan. Delete `PLAN.md` when done.

## opencode integration

Add to your `AGENTS.md`:

```markdown
## Planning
For non-trivial tasks, write a PLAN.md and wait for approval before coding.
```
