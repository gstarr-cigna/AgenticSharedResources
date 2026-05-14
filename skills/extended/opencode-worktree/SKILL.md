---
name: opencode-worktree
description: Git worktree isolation for opencode and AI assistants without built-in worktree support. Use when the user wants to experiment safely, work on a feature in isolation, run parallel experiments, or try a risky refactor without affecting the main branch. Bridges the gap where opencode has no equivalent of Claude Code's EnterWorktree/ExitWorktree tools.
---

# opencode Worktree

Provides isolated git worktree workflows for safe experimentation.

## When to use

- Risky refactor that might not work out
- Parallel feature development
- "Try this approach without breaking main"
- A/B testing two implementations

## Create a worktree

```bash
# Create worktree on a new branch
git worktree add .worktrees/<name> -b <branch-name>

# Example
git worktree add .worktrees/auth-refactor -b feat/auth-refactor
```

Then switch opencode (or your shell) to work in `.worktrees/<name>/`.

## List active worktrees

```bash
git worktree list
```

## Remove a worktree

```bash
# When done (discard)
git worktree remove .worktrees/<name>
git branch -D <branch-name>

# When keeping the branch
git worktree remove .worktrees/<name>
# branch still exists, can be checked out normally
```

## Merge worktree changes back

```bash
# From main branch
git merge feat/auth-refactor
# or
git cherry-pick <commit-hash>
```

## Workflow protocol

When the user asks to "try something in isolation" or "experiment safely":

1. Ask for a name: `What should we call this experiment?`
2. Run: `git worktree add .worktrees/<name> -b experiment/<name>`
3. Tell the user which directory to switch opencode to
4. Do the work
5. When done, ask: keep or discard?
   - Keep: `git worktree remove .worktrees/<name>` (branch survives)
   - Discard: `git worktree remove .worktrees/<name> && git branch -D experiment/<name>`

## .gitignore

Add to `.gitignore` to avoid committing worktrees:
```
.worktrees/
```
