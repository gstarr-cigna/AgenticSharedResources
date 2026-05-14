---
# cursor-hub: figma-leaf-assembler@1.0.0
# source: https://d-cursor-hub-cursor-hub-cursor-hub.router-dev-blue.digexp-dev.aws.cignacloud.com/packs/figma-leaf-assembler/1.0.0/
---

# SpecKit Integration Reference

> **OPTIONAL** -- Load only when running inside a SpecKit agent pipeline.
> The core assembler skill works standalone without this reference.

## Reading Task Context

On startup:
1. Check `mailbox/frontend/inbox/` for `msg_*.json` from `team_lead`
2. Read `specs/frontend/component_spec.json` for:

| Field | Path in JSON |
|-------|-------------|
| UI library | `.ui_library` |
| Brand | `.design_system.brand` |
| Page components | `.pages[].name`, `.pages[].sections[].name` |
| Shared components | `.shared_components[].name` |
| Figma URL | `.figma_reference` |

3. If `.figma_reference` is absent, read `specs/functional_spec.md` -- find `## Design Reference` section

## Output Conventions

- Write components to `frontend/src/components/` (one file per page, shared in same dir)
- File naming: PascalCase matching `component_spec.json` names (`HomePage.tsx`, `Header.tsx`)
- Before writing: read 2--3 existing component files to detect styling pattern (Tailwind, CSS modules, etc.)

## Status Protocol

### Success
`status.json`:
```json
{"status": "complete", "message": "Figma extraction complete. N sections extracted, M skipped."}
```
`mailbox/team_lead/inbox/msg_{timestamp}_frontend_status.json`:
```json
{"id": "msg_...", "from": "frontend", "to": "team_lead", "type": "status_update",
 "subject": "Frontend build complete", "body": "All page components generated from Figma design.",
 "requires_response": false, "timestamp": "ISO8601"}
```

### MCP Failure
`status.json`:
```json
{"status": "blocked", "message": "Figma MCP connection failed for frontend. Check that the Figma MCP server is running and authenticated."}
```
Mailbox message: same format, `"type": "mcp_unavailable"`

### Partial Failure
`status.json`:
```json
{"status": "complete", "message": "Partial extraction: N of M sections. See .ai-memory/figma-assembler-run-log.md for skipped sections."}
```
Use `"complete"` (not `"partial"`) -- the team lead's Phase 6 loop checks for `"complete"` to advance.

## Memory Protocol (.ai-memory/)

### figma-assembler-manifest.md
Write after successful completion. Format matches `class_map.md` conventions:
```markdown
# Figma Assembler Manifest
## Files
- frontend/src/components/HomePage.tsx -- Home page component with Hero, Services, Trust sections
  - **Signed**: frontend @ {ISO8601}
- frontend/src/components/Header.tsx -- Shared header with responsive nav
  - **Signed**: frontend @ {ISO8601}
## Design Decisions
- Styling: Tailwind + --leaf-* CSS custom properties (detected from existing components)
  - **Signed**: frontend @ {ISO8601}
- Figma source: {fileKey} node {nodeId}
  - **Signed**: frontend @ {ISO8601}
```

### figma-assembler-run-log.md
Write during extraction. One row per section:
```markdown
# Assembler Run Log
| Section | Node ID | Status | Calls | Reason |
|---------|---------|--------|-------|--------|
| Hero | 3355:17400 | extracted | 1 | OK |
| Footer | 3355:17618 | skipped | 3 | 429 after 3 retries |
```

## Brownfield Detection

Before generating any files:
1. Check `.ai-memory/` for a prior `figma-assembler-run-log.md`
2. If found: incremental mode -- only extract sections listed as `skipped` or `failed`
3. Check `.ai-memory/` for `*_manifest.md` files to understand what was already built
4. Read existing component files before writing to avoid overwriting working implementations

## Section Name Mapping

Figma layer names won't match spec names exactly. Rules:
- Use the `component_spec.json` name for the output file
- Put the Figma layer name in a `// TODO: mapped from Figma layer "{figmaName}"` comment
- Log mismatches in the run log -- do not fail on name mismatch

Example mapping:
| Figma Layer | Spec Name |
|-------------|-----------|
| "Hero" | HeroSection |
| "section" | ServicesOverview |
| "Page-Top" | PageHeader |
