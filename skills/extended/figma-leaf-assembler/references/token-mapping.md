---
# cursor-hub: figma-leaf-assembler@1.0.0
# source: https://d-cursor-hub-cursor-hub-cursor-hub.router-dev-blue.digexp-dev.aws.cignacloud.com/packs/figma-leaf-assembler/1.0.0/
---

<!-- SOURCE: figma-leaf-builder/3.0.0/skills/figma-leaf-builder/references/token-mapping.md -->
<!-- This file provides category patterns. Always parse installed brand CSS at runtime for authoritative token names. -->
<!-- Last verified against: leaf-design-tokens v2.x.x + aicoe-newmdlive leaf-tokens.css v1.18.1 -->

# Leaf Token Mapping Reference

This reference describes the strategy for mapping Figma design values to Leaf tokens. Token tables here are category hints only -- they show the naming pattern for each category, not an exhaustive list of all available tokens. Always parse the installed brand CSS for authoritative token names.

## Source of Truth

```
# v2.0.0+ (@cigna scope)
node_modules/@cigna/leaf-design-tokens/lib/web/brands/{brand}/css/tokens_{brand}.css

# Pre-v2.0.0 (@esi scope - legacy)
node_modules/@esi/leaf-design-tokens/lib/web/brands/{brand}/css/tokens_{brand}.css
```

Check which scope is installed and reference accordingly. Do not assume token names -- verify against the installed package.

## Version History Note

v2.0.0 (October 2025) changed package scope from `@esi/` to `@cigna/`. Both are functionally equivalent -- the token names (`--leaf-*`) remain the same across versions.

---

## Token Categories

The patterns below describe naming conventions. Parse the installed brand CSS to discover all specific variants available for each category.

### Colors

Background colors follow the `--leaf-color-bg-*` pattern. Parse the brand CSS to discover specific variants available (e.g., default, subtle, brand, disabled, info, success, warning, error, knockout).

Border colors follow the `--leaf-color-border-*` pattern. Variants include states such as default, strong, focus, knockout, brand, and semantic states (info, success, warning, error).

Text and content colors follow the `--leaf-color-content-*` pattern. Variants include default, subtle, disabled, knockout, brand, link, and semantic states.

Interactive/button colors follow the `--leaf-color-button-{variant}-*` pattern, where `{variant}` is the button style (e.g., primary, secondary, tertiary). Each variant has bg, content, and border sub-tokens for interactive states.

**Figma context to token category mapping:**

| Figma Context | Leaf Token Pattern |
|---|---|
| Background | `--leaf-color-bg-*` |
| Text / Content | `--leaf-color-content-*` |
| Borders | `--leaf-color-border-*` |
| Interactive buttons | `--leaf-color-button-{variant}-*` |

### Spacing

Spacing tokens follow the `--leaf-spacing-{n}` pattern. The base unit is 8px. Parse the brand CSS to discover the full available scale.

Common scale values are multiples and partial multiples of 8 (e.g., 2, 4, 6, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96, 120, 160), but always verify against the installed package -- do not hardcode this list.

For non-standard spacing values (values with no direct token), compose with `calc()` using available tokens.

### Typography

Typography tokens follow the `--leaf-typography-{preset}-{property}` pattern.

Preset categories: display, headline, title, label, body, meta -- each may have size variants (e.g., `display-default`, `headline-large`, `headline-default`). Parse the brand CSS for the full preset list.

Properties: `font-family`, `font-size`, `font-weight`, `line-height`, `letter-spacing`.

### Border Radius

Border radius tokens follow the `--leaf-border-radius-{size}` pattern. Parse the brand CSS to discover available sizes (e.g., 2, 4, 8, 12, 16, full).

### Shadows

Shadow tokens follow the `--leaf-shadow-{size}` pattern. Parse the brand CSS to discover available sizes (e.g., small, default, large).

### Z-Index

Z-index tokens follow the `--leaf-z-index-{level}` pattern. Parse the brand CSS to discover available levels.

---

## Styling Adaptation

Detect the project's styling approach from existing component files and apply tokens using the matching convention.

### Tailwind

Use arbitrary value syntax to reference tokens inline:

```tsx
<div className="bg-[var(--leaf-color-bg-brand)] text-[var(--leaf-color-content-default)]" />
```

Match the arbitrary value patterns found in existing components in the codebase.

### CSS Modules

Generate a `.module.css` file that references tokens as custom property values:

```css
.container {
  background-color: var(--leaf-color-bg-default);
  color: var(--leaf-color-content-default);
  padding: var(--leaf-spacing-16);
}
```

### CSS-in-JS

Reference tokens as string values in style objects:

```ts
const styles = {
  backgroundColor: 'var(--leaf-color-bg-default)',
  color: 'var(--leaf-color-content-default)',
  padding: 'var(--leaf-spacing-16)',
};
```

### SCSS

Use tokens directly in `.scss` files. Tokens resolve via CSS custom properties at runtime, so no Sass variable import is needed:

```scss
.component {
  background: var(--leaf-color-bg-subtle);
  border: 1px solid var(--leaf-color-border-default);
}
```

---

## Validation Checklist

Before finalizing generated output:

1. Verify all referenced tokens exist in the installed brand CSS -- do not reference tokens by memory alone
2. Ensure no hardcoded hex color values remain in the output
3. Ensure all spacing uses `--leaf-spacing-*` tokens or `calc()` compositions of them
4. Confirm the styling format (Tailwind / CSS Modules / CSS-in-JS / SCSS) matches the conventions found in existing project files

---

## Evernorth Brand Reference

Source: `aicoe-newmdlive/frontend/src/styles/leaf-tokens.css` (leaf-design-tokens v1.18.1). All tokens use CSS custom properties with `--leaf-` prefix.

### Color Primitives

| Token | Value | Usage |
|-------|-------|-------|
| `--leaf-color-navy` | `#110081` | Dark backgrounds, strong headings |
| `--leaf-color-hypermint` | `#3effc0` | Accent highlights, inverse interactive |
| `--leaf-color-action-blue` | `#0033ff` | Interactive default state |
| `--leaf-color-bg-accent-brand-strong` | `#008f83` | Teal primary -- CTA backgrounds, brand fills |
| `--leaf-color-bg-accent-brand-xstrong` | `#035c67` | Teal dark -- hover states, link color |
| `--leaf-color-digital-gray` | `#333333` | Default body text |
| `--leaf-color-cool-gray` | `#f4f4f4` | Subtle backgrounds |
| `--leaf-color-digital-green` | `#488319` | Success state |
| `--leaf-color-digital-red` | `#ba0000` | Error state |

### Semantic Mapping

| Semantic Role | Token | Resolved Value |
|---------------|-------|----------------|
| Page background | `--leaf-color-bg-default` | `#ffffff` |
| Subtle background | `--leaf-color-bg-subtle` | `#f4f4f4` (cool-gray) |
| Dark/inverse background | `--leaf-color-bg-strong` | `#110081` (navy) |
| Body text | `--leaf-color-content-default` | `#333333` (digital-gray) |
| Strong text | `--leaf-color-content-strong` | `#000000` |
| Muted text | `--leaf-color-content-subtle` | `#6b6b6b` |
| Link color | `--leaf-color-content-link` | `#035c67` (teal-dark) |
| Default border | `--leaf-color-border-default` | `#d4d4d4` |
| Interactive default | `--leaf-color-interactive-default` | `#0033ff` (action-blue) |
| Interactive hover | `--leaf-color-interactive-hover` | `#0029cc` |

### Figma Hex-to-Token Quick Lookup (Evernorth)

When Figma fills resolve to these exact hex values, use the token rather than hardcoding:

| Hex | Token |
|-----|-------|
| `#110081` | `--leaf-color-navy` |
| `#3effc0` | `--leaf-color-hypermint` |
| `#0033ff` | `--leaf-color-action-blue` |
| `#008f83` | `--leaf-color-bg-accent-brand-strong` |
| `#035c67` | `--leaf-color-bg-accent-brand-xstrong` |
| `#333333` | `--leaf-color-digital-gray` |
| `#f4f4f4` | `--leaf-color-cool-gray` |
| `#ffffff` | `--leaf-color-white` |
| `#000000` | `--leaf-color-black` |
