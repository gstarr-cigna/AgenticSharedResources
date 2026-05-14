# Template: Incident Triage

Given the following alert or error report, produce a structured triage note:

```
SEVERITY: [P0 | P1 | P2 | P3]
SUMMARY: <one sentence description of what is broken>
IMPACT: <who/what is affected and to what degree>
LIKELY CAUSE: <hypothesis based on available signals>
IMMEDIATE ACTIONS:
  1. <first action>
  2. <second action>
FOLLOW-UP:
  - <investigation or fix to schedule post-stabilization>
```

Severity guide:
- **P0**: production down or data loss in progress
- **P1**: major feature broken for all or most users
- **P2**: degraded experience, workaround exists
- **P3**: minor issue, low user impact
