# Template: Code Review

Review the following diff. For each issue found, output a structured comment:

```
FILE: <path>
LINE: <line or range>
SEVERITY: [critical | major | minor | nit]
CATEGORY: [correctness | security | performance | style | test-coverage]
COMMENT: <one-paragraph explanation of the issue and suggested fix>
```

Severity guide:
- **critical**: will cause data loss, security breach, or production outage
- **major**: likely bug or missing error handling that could surface in normal use
- **minor**: degrades maintainability or correctness in edge cases
- **nit**: style, naming, or trivial improvement

After listing all issues, output a one-paragraph summary and an overall verdict: `approve`, `approve-with-nits`, `request-changes`.
