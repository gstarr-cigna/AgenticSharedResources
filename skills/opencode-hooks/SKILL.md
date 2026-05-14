---
name: opencode-hooks
description: Emulate pre/post action hooks for opencode and AI assistants without a built-in hooks system. Use when the user wants automated behaviors like "always run tests after edits", "lint before committing", "format after saving", or any "whenever X do Y" pattern. Bridges the gap where opencode has no equivalent of Claude Code's hooks in settings.json.
---

# opencode Hooks

Emulates Claude Code's hooks system using shell scripts and project-level conventions.

## Approach

Since opencode has no settings.json hooks, implement hook behaviors via:
1. **Shell scripts** — run explicitly after relevant actions
2. **git hooks** — for commit/push lifecycle events
3. **AGENTS.md instructions** — teach the AI to run hooks manually

## Common hook patterns

### Post-edit: lint + format
After editing any source file, run:
```bash
# Add to .opencode-hooks/post-edit.sh
#!/bin/bash
npm run lint --fix 2>/dev/null || eslint --fix "$1" 2>/dev/null
prettier --write "$1" 2>/dev/null
```

### Post-edit: typecheck
```bash
# .opencode-hooks/typecheck.sh
#!/bin/bash
npx tsc --noEmit
```

### Pre-commit: run tests
```bash
# .git/hooks/pre-commit
#!/bin/bash
npm test -- --passWithNoTests
```

## Setup workflow

When a user wants a hook behavior:

1. Create `.opencode-hooks/` directory in project root
2. Write the appropriate script (see patterns above)
3. Make it executable: `chmod +x .opencode-hooks/<script>.sh`
4. Add to `AGENTS.md` so opencode knows to run it:

```markdown
## Hooks
After editing source files, run `.opencode-hooks/post-edit.sh <filepath>`.
After completing a feature, run `.opencode-hooks/typecheck.sh`.
```

## AGENTS.md template for hooks

```markdown
## Automated checks (hooks)

Run these after the indicated actions:

| Trigger | Command |
|---------|---------|
| After editing any .ts/.tsx file | `npx tsc --noEmit` |
| After editing any file | `npm run lint` |
| Before committing | `npm test` |

Always report the result. If a check fails, fix it before proceeding.
```

## git hooks (persistent, editor-agnostic)

For behaviors that must always run (regardless of which AI tool is used), use git hooks:

```bash
# Setup pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
npm run lint && npm test
EOF
chmod +x .git/hooks/pre-commit
```

To share git hooks with the team, use `husky` or store in `.githooks/` and configure:
```bash
git config core.hooksPath .githooks
```
