---
# cursor-hub: figma-leaf-assembler@1.0.0
# source: https://d-cursor-hub-cursor-hub-cursor-hub.router-dev-blue.digexp-dev.aws.cignacloud.com/packs/figma-leaf-assembler/1.0.0/
---

<!-- SOURCE: figma-leaf-builder/3.0.0/skills/figma-leaf-builder/references/component-mapping.md -->
<!-- This file provides hint patterns. Always verify against custom-elements.json at runtime. -->
<!-- Last verified against: leaf-web v2.x.x -->

# Leaf Component Mapping Strategy

This reference describes HOW to map Figma `data-name` patterns to Leaf components. It provides search suggestions and extraction strategies -- not definitive mappings. Every mapping MUST be verified against the installed package before use.

## Source of Truth

```
# v2.0.0+ (@cigna scope)
node_modules/@cigna/leaf-web/.storybook/custom-elements.json

# Pre-v2.0.0 (@esi scope - legacy)
node_modules/@esi/leaf-web/.storybook/custom-elements.json
```

This manifest contains all component definitions with tag names, attributes/properties, slots, and events. Parse it at runtime to confirm component availability, valid prop names and types, valid slot names, and event handler signatures before generating any code.

## Version History Note

v2.0.0 (October 2025) changed package scope from `@esi/` to `@cigna/`. Component APIs remain the same. v1.0.0 merged separate `@esi/leaf-wc` and `@esi/leaf-react` packages into a single `@esi/leaf-web` package. Check which scope is installed and reference accordingly.

---

## Component Recognition

Figma MCP output includes `data-name` attributes. Use the patterns below as starting points for searching `custom-elements.json` -- they are not authoritative. Always confirm the component exists in the installed package before use.

### Buttons

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Primary Button"               | LeafButton variants, look for variant="primary" |
| "Secondary Button"             | LeafButton variants, look for variant="secondary" |
| "Tertiary Button"              | LeafButton variants, look for variant="tertiary" |
| "Danger Button"                | LeafDangerButton |
| "Dropdown Button"              | LeafDropdownButton |
| "Split Button"                 | LeafSplitButton |
| Contains "Button" (generic)    | Check LeafButton, LeafDangerButton, LeafDropdownButton -- verify which variants exist |

### Layout

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Card", "Content Card"         | LeafCard, LeafContentCard |
| "Vertical Card"                | LeafVerticalCard |
| "Divider"                      | LeafDivider |
| "Grid"                         | LeafGrid + LeafGridItem (check slot structure) |
| "Section"                      | LeafSection |
| "Band"                         | LeafBand |

### Navigation

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Breadcrumbs"                  | LeafBreadcrumbs |
| "Tabs"                         | LeafTabs + LeafTab + LeafTabPanel (check composite structure) |
| "Primary Nav"                  | LeafPrimaryNav |
| "Tertiary Nav"                 | LeafTertiaryNav |

### Data Display

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Badge"                        | LeafBadge |
| "Tag"                          | LeafTag |
| "Avatar"                       | LeafAvatar |
| "Table"                        | LeafTableV2 (note: verify table API -- multiple table components may exist) |
| "Progress Meter"               | LeafProgressMeter |

### Feedback

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Alert", "Info Alert"          | LeafAlert -- look for status="info" |
| "Success Alert"                | LeafAlert -- look for status="success" |
| "Warning Alert"                | LeafAlert -- look for status="warning" |
| "Error Alert"                  | LeafAlert -- look for status="error" |
| "Modal"                        | LeafModal |
| "Tooltip"                      | LeafTooltip |
| Contains "Alert" (generic)     | LeafAlert with appropriate status prop -- verify valid status values |

### Forms

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Text Field", "Input"          | LeafField |
| "Text Area"                    | LeafTextarea |
| "Select", "Dropdown"           | LeafSelect |
| "Checkbox"                     | LeafCheckboxField |
| "Radio"                        | LeafRadioField |
| "Switch", "Toggle"             | LeafSwitch |
| Contains "Field" or "Input"    | LeafField, LeafTextarea, LeafSelect -- check which applies |

### Typography

| When Figma pattern contains... | Search custom-elements.json for... |
| ------------------------------ | ----------------------------------- |
| "Heading", "H1" through "H6"   | LeafHeading -- look for tagVariant prop |
| "Link"                         | LeafLink |

---

## Prop Extraction Strategy

Use this strategy to extract props from Figma structure. All extracted prop names and valid values MUST be verified against `custom-elements.json` before use.

### 1. Text Content -- Props

Extract text from child text nodes. Typical target props:

- `text` -- primary display text
- `label` -- form field labels, button labels
- `headerText` -- card or section headers

Always check `custom-elements.json` for the exact prop name -- do not assume.

### 2. Visual Variants -- Variant/Status/Size Props

Parse variant cues from `data-name` context (e.g., "Primary", "Success", "Large"):

- Color/emphasis cues -> `variant` prop (e.g., "primary", "secondary", "tertiary")
- Semantic state cues -> `status` prop (e.g., "info", "success", "warning", "error")
- Sizing cues -> `size` prop (e.g., "small", "medium", "large")

Verify the prop name and the exact string values against `custom-elements.json`. Do not guess enum values.

### 3. Nested Structures -- Slots

Map nested Figma structures to slot assignments. Common patterns:

- Header regions -> `header` slot
- Footer regions -> `footer` slot
- Content panels -> `panel` slot or default slot

Check the component's slot definitions in `custom-elements.json` -- slot names vary per component.

### 4. Icons/SVGs -- svg and iconPosition Props

When child nodes are SVGs or icon references:

- SVG content -> `svg` prop
- Icon placement cues -> `iconPosition` prop (e.g., "left", "right")

Verify both prop names and accepted values in `custom-elements.json`.

---

## Validation Checklist

Before finalizing any component implementation:

1. Confirm the component tag name exists in the installed package's `custom-elements.json`
2. Confirm every prop name matches an attribute or property definition in `custom-elements.json`
3. Confirm every prop value (especially enums like variant, status, size) is a valid option per the component's definition
4. Confirm all used slot names are declared as valid slots for the component
5. Confirm event handler names match the component's declared events and the target framework's conventions
6. Match import path and package scope to what is actually installed (check `package.json` for `@cigna/leaf-web` vs `@esi/leaf-web`)

---

## Import Generation

Generate imports based on the detected framework and the installed package scope. Match import style to existing code patterns in the project.

| Framework      | v2.0.0+ (@cigna)                                  | Pre-v2.0.0 (@esi)                               |
| -------------- | ------------------------------------------------- | ----------------------------------------------- |
| React          | `@cigna/leaf-web/lib/react`                       | `@esi/leaf-web/lib/react`                       |
| Angular        | `@cigna/leaf-web/lib/angular`                     | `@esi/leaf-web/lib/angular`                     |
| Web Components | `@cigna/leaf-web/lib/wc/components/{name}/{name}` | `@esi/leaf-web/lib/wc/components/{name}/{name}` |

Verify the exact import path for each component by checking the installed package's directory structure or `custom-elements.json` metadata before generating code.

---

## Assembler-Specific Patterns

### Styling Pattern Detection

Before generating any code, detect the project's actual styling pattern by scanning existing component files:

| Signal | Pattern |
|--------|---------|
| `className="bg-[var(--leaf-*)]"` in components | Tailwind + Leaf tokens |
| `import styles from '*.module.css'` | CSS Modules |
| `<leaf-*>` tags with no wrapper imports | Web Components direct |
| `import { Leaf* } from '@cigna/leaf-web/lib/react'` | React wrappers |

Generate output matching the detected pattern. Do not mix patterns within a single file.

### Evernorth Brand Reference

Primary brand: Evernorth. Key color identifiers when reading Figma fills:

| Hex | Token | Role |
|-----|-------|------|
| `#008f83` | `--leaf-color-bg-accent-brand-strong` | Teal primary (CTA backgrounds, brand accents) |
| `#035c67` | `--leaf-color-bg-accent-brand-xstrong` | Teal dark (hover states, link color) |
| `#3effc0` | `--leaf-color-hypermint` | Hypermint accent |
| `#110081` | `--leaf-color-navy` | Navy (dark backgrounds, headings) |
| `#0033ff` | `--leaf-color-action-blue` | Action blue (interactive default) |

When Figma fills resolve to these hex values, map to the corresponding token rather than hardcoding.

### MDLive Project -- Common Figma-to-Leaf Patterns

| Figma Section Pattern | Implementation Approach |
|-----------------------|------------------------|
| Hero section | Absolute-positioned layered images (`position: relative` container, `position: absolute` background image layer, content layer on top); use `--leaf-spacing-*` for padding, map CTA to `LeafButton variant="primary"` |
| Service cards | 2-column grid layout (`LeafGrid` + `LeafGridItem`); each card maps to `LeafContentCard` or `LeafVerticalCard`; verify slot names for image, heading, body, and CTA |
| FAQ accordion items | `LeafAccordion` + `LeafAccordionItem` composite; question text -> header slot, answer text -> default slot; verify accordion component name in `custom-elements.json` |
