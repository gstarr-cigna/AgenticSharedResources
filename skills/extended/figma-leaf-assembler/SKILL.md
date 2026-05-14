---
# cursor-hub: figma-leaf-assembler@1.0.0
# source: https://d-cursor-hub-cursor-hub-cursor-hub.router-dev-blue.digexp-dev.aws.cignacloud.com/packs/figma-leaf-assembler/1.0.0/
name: figma-leaf-assembler
description: >
  Assemble multi-page Figma designs into Leaf Design System code, section by
  section. Handles large designs with intelligent rate limit management.
  Works standalone or as a frontend agent skill in autonomous pipelines.
  TRIGGERS: 'assemble figma design', 'figma to leaf components',
  'process multi-page figma', 'extract figma sections', user provides a
  Figma URL with a large or multi-page design.
---

# Figma Leaf Assembler

Assemble multi-page Figma designs into production-ready Leaf Design System code. Extracts section by section via Figma MCP to avoid rate limits and token size issues. Detects your project's styling approach and matches output automatically.

## MCP Server Requirement

This skill requires the **Figma MCP** server. All Figma tool calls go through it. If unavailable, write failure state (see Phase 0) and stop.

## Autonomous Operation

This skill runs without interactive gates. All decisions use sensible defaults. For interactive single-frame work, use `figma-leaf-builder` instead.

---

## Phase 0 -- MCP Verification

Call `whoami` on Figma MCP. If it responds with a valid user object, proceed.

If it fails (3 retries, then stop):
- If `status.json` exists in workspace: write `{"status": "blocked", "message": "Figma MCP connection failed. Check that the Figma MCP server is running and authenticated (run npx figma-developer-mcp --stdio to verify)."}`
- If `speckit-integration.md` is loaded: send mailbox message type `mcp_unavailable` to `team_lead`
- Stop. Do not proceed without MCP.

---

## Phase 0.5 -- Project Context Read

Before Figma extraction, understand the target project:

### Step 1: Figma URL

Find the Figma URL from (in priority order):
1. The user's message or prompt
2. `specs/functional_spec.md` under "## Design Reference"
3. `specs/frontend/component_spec.json` under `figma_reference`

Extract `fileKey` and `nodeId` per `references/figma-mcp-patterns.md` URL parsing rules. If `node-id` is missing from the URL, use the file's root page.

### Step 2: Spec Context (if available)

If `specs/frontend/component_spec.json` exists, read it and extract:
- `ui_library` (tailwindcss, leaf-web, etc.)
- `design_system.brand` (evernorth, cigna, etc.)
- `pages[].name` and `pages[].sections[].name` (authoritative section naming)
- `shared_components[].name` (Header, Footer, etc.)

### Step 3: Detect Styling Pattern

Read 2-3 existing component files (e.g., `frontend/src/components/*.tsx` or `src/components/*.tsx`). Detect which pattern is in use:

| Pattern | How to Detect | Output Style |
|---------|---------------|-------------|
| Tailwind + tokens | `className="..."` with `--leaf-*` or `leaf-` prefixed classes | Tailwind classes using leaf preset |
| Web Components | `<leaf-button>`, `<leaf-card>` tags | Leaf WC tags with attribute binding |
| React wrappers | `import { LeafButton } from '@cigna/leaf-web/lib/react'` | React component imports |
| No existing code | Empty or new project | Default to Tailwind + `--leaf-*` tokens |

**Match the detected pattern. Do NOT assume React wrappers.**

### Step 4: Brownfield Detection

If `.ai-memory/figma-assembler-run-log.md` exists, read it. Switch to incremental mode: only extract sections listed as `skipped` or `failed`.

---

## Phase 1 -- Canvas Discovery

Call `get_metadata(fileKey, nodeId)` to get the page structure as XML.

### Identify Pages and Breakpoints

Parse the XML for top-level `<section>` and `<frame>` elements. Group frames by page:

- **Breakpoint detection:** Desktop = width ~1440, Tablet = width ~768, Mobile = width ~375
- **Filter out:** Nodes with names starting `.`, bare `RECTANGLE`/`ELLIPSE` at top level, hidden layers, background asset frames

### Map to Spec Names

If `component_spec.json` was loaded in Phase 0.5, cross-reference Figma layer names with spec section names. Log mismatches but use spec names for output files.

### Section Inventory

For each page's desktop frame, list all direct child sections with their node IDs. This is the extraction work queue.

---

## Phase 2 -- Section-by-Section Extraction

Process one page at a time. Within each page, extract one section at a time.

### Desktop Extraction (full)

For each section in the work queue:

1. Call `get_design_context(fileKey, sectionNodeId, excludeScreenshot: true)`
2. Wait 2 seconds (courtesy delay)
3. On 429: exponential backoff (5s, 10s, 20s, 40s) -- max 4 retries, then skip
4. After 10 consecutive calls: pause 10 seconds

### Per-Section Processing

1. **Clean tokens:** Apply malformed syntax fix per `references/figma-mcp-patterns.md`
2. **Clean fonts:** Fix colon notation (`'Montserrat:Medium'` -> `font-family: 'Montserrat'; font-weight: 500`)
3. **Code Connect:** If CC snippets returned, use them directly (highest fidelity)
4. **Heuristic mapping:** For non-CC elements, map via `references/component-mapping.md`
5. **Text content:** Extract from `get_metadata` XML text nodes (not JSX parsing)
6. **Log:** Record section name, node ID, status, call count in run log

### Tablet/Mobile (metadata only)

For responsive variants: call `get_metadata` only (not `get_design_context`). Extract layout differences: column count, spacing changes, visibility toggles. Content is shared with desktop -- only layout adapts.

---

## Phase 3 -- Component Assembly

Compose sections into full page components:

1. **Shared components first:** Extract Header and Footer once, reuse across pages
2. **Page components:** One file per page, composing sections in order
3. **Naming:** Use `component_spec.json` names if available, else PascalCase from Figma layer names
4. **Responsive:** Apply Tailwind responsive prefixes or CSS media queries based on tablet/mobile metadata diffs
5. **Remove `data-node-id` attributes** from final output (MCP debugging artifacts)
6. **Remove `CodeConnectSnippet` wrappers** -- use the inner component directly

---

## Phase 4 -- Asset Download

Follow the tiered strategy in `references/figma-mcp-patterns.md`:

1. **Skip:** Leaf system icons (`SystemIconSwap`, `BaseSystemIconography/*`)
2. **Download:** Genuine custom brand assets only (hero images, logos, background vectors)
3. **Strategy:** Max 5 concurrent, 1s between batches, exponential backoff on 429
4. **Fallback:** If downloads fail after retries, write URLs to a manifest file for manual download
5. **Save to:** Project's public/images/ or assets/ directory

---

## Phase 5 -- Code Output

Write generated component files to the appropriate directory (`frontend/src/components/` or detected equivalent).

### Validation Checklist

| Check | Criteria |
|-------|---------|
| Layout | Auto Layout -> flexbox/grid preserved; gap, padding correct |
| Typography | Leaf typography tokens used, no hardcoded px |
| Colors | `var(--leaf-*)` tokens or Tailwind leaf-* classes; zero hardcoded hex |
| Imports | Match detected project pattern (WC tags, React wrappers, or Tailwind) |
| Assets | MCP asset URLs downloaded; no placeholders |
| Text | All visible Figma text transcribed; no lorem ipsum |

### SpecKit Protocol (only when speckit-integration.md is loaded)

Write terminal state to `status.json` and `.ai-memory/` per `references/speckit-integration.md`.

---

## References

- `references/component-mapping.md` -- Figma pattern -> Leaf component mapping
- `references/token-mapping.md` -- Figma values -> Leaf token patterns
- `references/figma-mcp-patterns.md` -- MCP tools, rate limits, token fixes, extraction protocol
- `references/speckit-integration.md` -- (Optional) SpecKit agent platform integration
