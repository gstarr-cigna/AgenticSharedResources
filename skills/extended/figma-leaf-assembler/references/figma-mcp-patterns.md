---
# cursor-hub: figma-leaf-assembler@1.0.0
# source: https://d-cursor-hub-cursor-hub-cursor-hub.router-dev-blue.digexp-dev.aws.cignacloud.com/packs/figma-leaf-assembler/1.0.0/
---

<!-- SOURCE: figma-leaf-builder/3.0.0/skills/figma-leaf-builder/references/figma-mcp-patterns.md -->
<!-- This file documents Figma MCP tool patterns for the figma-leaf-assembler skill. -->
<!-- Tool surface may change as Figma updates their MCP server. -->

# Figma MCP Patterns

Reference for using Figma MCP tools within the figma-leaf-assembler skill.

## Design Extraction Tools

| Tool | Purpose | Key notes |
|------|---------|-----------|
| `get_design_context` | Primary extraction (code, tokens, CC snippets, Auto Layout) | Set `excludeScreenshot: true` for all passes; never set `disableCodeConnect` |
| `get_metadata` | Sparse XML: node IDs, names, positions. Cheap. | Always call FIRST before get_design_context |
| `get_variable_defs` | Design variable definitions | Tokens mode only; skip in Components mode |

## Bulk Extraction Mode

Default: `excludeScreenshot: true` on all extraction calls (screenshots = 60-80% of response). Call `get_screenshot` only during final validation.

| Asset Tier | Action | Examples |
|------------|--------|---------|
| Skip | Leaf system icons | SystemIconSwap, BaseSystemIconography/* |
| Embedded | Screenshots | Captured in get_design_context response |
| Download | Custom brand assets | hero-graphic.png, logo.svg, vectors |
| Never | Placeholders/chrome | Figma UI thumbnails, component previews |

## Rate Limit Strategy

- **MCP tools** (get_design_context, get_metadata): no published limit. 2s courtesy delay between calls; after 10 consecutive calls pause 10s.
- **CDN asset downloads** (image URLs): 429-prone. Max 5 concurrent, 1s between batches, exponential backoff on 429 (5s, 10s, 20s, 40s).

## Section-by-Section Extraction Protocol

1. `get_metadata` on canvas/page node -> tree structure
2. Identify sections at depth 2-4 (frame/section elements)
3. Filter: skip names starting `.`, bare RECTANGLE/ELLIPSE, hidden layers
4. Each section: `get_design_context` with `excludeScreenshot: true`; 2s delay between calls
5. On 429: backoff 5s, 10s, 20s, 40s (max 4 retries)
6. Log each section: name, nodeId, status (extracted/skipped/failed), reason

## Desktop-First Pattern

Extract desktop frames fully. For tablet/mobile: `get_metadata` ONLY to capture layout diffs. Content rarely changes between breakpoints -- only layout adapts. Saves ~40% of MCP calls.

## Known Truncation Triggers

| Trigger | Mitigation |
|---------|-----------|
| Canvas/page frame directly | `get_metadata` first; never `get_design_context` on canvas |
| >50 direct children | Split by child node IDs from metadata |
| Frame wider than ~1440px | Extract sections individually |
| Auto Layout >5 levels deep | Extract innermost sections separately |

## Malformed Token Syntax Fix

Apply to all token references in `get_design_context` response. Regex: match `var\(--var\(--(leaf-[^;]+);,[^)]+\)\)`, capture group 1, output `var(--\1)`. Apply recursively for double-nested. If value already matches `var(--leaf-*)` with no nesting, skip (passthrough guard).

| Input pattern | Output |
|---------------|--------|
| `var(--var(--leaf-color-text-primary);,#1a1a1a)` | `var(--leaf-color-text-primary)` |
| `var(--var(--var(--leaf-color-text-primary);,#000);,#000)` | `var(--leaf-color-text-primary)` |
| `var(--var(--leaf-spacing-04);,16px)` | `var(--leaf-spacing-04)` |
| `bg-[var(--var(--leaf-color-bg-brand);,#035c67)]` | `bg-[var(--leaf-color-bg-brand)]` |

## Font-Family Syntax Fix

Split colon-separated font strings: `'Montserrat:Medium'` -> `font-family: 'Montserrat'; font-weight: 500;`. Weight map: Light=300, Regular=400, Medium=500, SemiBold=600, Bold=700, ExtraBold=800.

## Content Text Extraction

Use `get_metadata` XML for text inventory (text nodes carry content in name attributes). Do NOT parse JSX from `get_design_context` for text. Cross-reference with `component_spec.json` section names.

## Variant State Warning

Before `get_design_context`: check `get_metadata` node names for `State=Hover` or `State=Active`. If found, extracted CSS may reflect hover/active as base state -- flag for manual review.

## Other Tools (summary)

| Tool | When to use |
|------|-------------|
| `get_code_connect_map` | After extraction -- check CC coverage (nodeId -> componentName, source, snippet) |
| `get_code_connect_suggestions` | When user opts in to set up Code Connect for unmapped components |
| `send_code_connect_mappings` / `add_code_connect_map` | Bulk or single CC save after user approval |
| `search_design_system` | Find components/variables across libraries; scope with `includeLibraryKeys` |
| `get_libraries` | Session start -- discover attached libraries, capture keys for scoped searches |
| `whoami` | First call -- verify MCP is connected and authenticated |

## URL Parsing

`figma.com/design/:fileKey/:fileName?node-id=1-2` -> fileKey=`:fileKey`, nodeId=`1:2` (convert `-` to `:`). Branch URLs: use `:branchKey` as fileKey. If `node-id` is missing, ask user to re-copy URL with a frame selected.

## Error Handling

| Error | Recovery |
|-------|----------|
| `whoami` fails | Restart MCP: Cmd+Shift+P -> MCP: Restart Server -> Figma |
| Auth error / access denied | Re-auth or check file sharing settings |
| Timeout / truncated response | Switch to section-by-section extraction protocol |
| Invalid nodeId | Request new URL with frame selected |
| CC tools return empty | Expected -- fall through to heuristic mapping |
| Rate limited (429) | Exponential backoff: 5s, 10s, 20s, 40s |

**Max retry rule:** 3 retries. After third failure, remove retry option.

## Leaf Library Map

Always call `get_libraries(fileKey)` first -- runtime keys take precedence over seed values below.

| Library | File Key | Key prefix |
|---------|----------|------------|
| Leaf Atomic Web | `NdxQVPvuVY8oRdKelBGXP5` | `lk-bab58ed18767...` |
| Leaf Molecular Web | (get_libraries) | `lk-cdce5dd13eac...` |
| Leaf Atomic Mobile | (get_libraries) | `lk-8c0b7aaf4a03...` |

Full keys: figma-leaf-builder v3.0.0 figma-mcp-patterns.md.
