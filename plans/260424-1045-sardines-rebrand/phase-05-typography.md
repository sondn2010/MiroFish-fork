# Phase 5 — Typography

**Context:** [plan.md](./plan.md) | [DESIGN.md](../../docs/DESIGN.md)  
**Depends on:** Phase 1 (Manrope font loaded, `--font-display` token defined)

## Overview

- **Priority:** P2
- **Status:** Pending
- **Effort:** ~1.5h
- Replace `'Space Grotesk'` with `'Manrope'` (via `var(--font-display)`) on all display/headline elements. Replace `'JetBrains Mono'` with `var(--font-body)` on body copy (keep monospace for code-specific elements only). Apply letter-spacing rules from DESIGN.md.

## Key Insights

**DESIGN.md typography rules:**
- **Manrope** → Display & Headlines: `display-lg`, `headline-lg` with `-2%` letter-spacing (`-0.02em`)
- **Inter** → Body & Labels: functional reading, already loaded
- **Extreme scale shifts** encouraged: large display headline + small uppercase label (`letter-spacing: 0.1em`)
- **Never use pill-shaped buttons** — keep `border-radius: var(--round-four)` (0.25rem)

**Current font assignments (from audit):**
```
'Space Grotesk', 'Noto Sans SC', system-ui, sans-serif  → main body/nav in all views
'JetBrains Mono', monospace                              → nav-brand text, step numbers
```

**After rebrand:**
```
var(--font-display) = 'Manrope', system-ui, sans-serif    → headlines, hero, nav-brand
var(--font-body) = 'Inter', 'Noto Sans SC', system-ui, sans-serif  → body copy, labels
```

**Noto Sans SC** stays in the body stack for CJK locale fallback.

## Files to Modify

All files that reference `'Space Grotesk'` or `'JetBrains Mono'`:
- `frontend/src/App.vue`
- `frontend/src/views/Home.vue`
- `frontend/src/views/MainView.vue`
- `frontend/src/views/SimulationView.vue`
- `frontend/src/views/Process.vue`
- `frontend/src/views/InteractionView.vue`
- (+ ReportView, SimulationRunView if they contain font references)

## Implementation Steps

### 1. Audit font references

```bash
grep -rn "Space Grotesk\|JetBrains Mono\|font-family" frontend/src/ 2>&1
```

### 2. Replace font-family rules

**Pattern A — Main body font (Space Grotesk → font-body):**
```css
/* Before */
font-family: 'Space Grotesk', 'Noto Sans SC', system-ui, sans-serif;

/* After */
font-family: var(--font-body);
```

**Pattern B — Brand/nav text (JetBrains Mono → font-display):**
```css
/* Before */
font-family: 'JetBrains Mono', 'Noto Sans SC', monospace;
/* or */
font-family: 'JetBrains Mono', monospace;

/* After */
font-family: var(--font-display);
```

**Pattern C — Monospace code elements (keep JetBrains Mono only if element is genuinely code):**
Only keep `'JetBrains Mono'` for elements that display actual code output (e.g., simulation log terminals, API response boxes). All other uses → `var(--font-display)` or `var(--font-body)`.

### 3. Apply DESIGN.md type scale to hero/headline elements in Home.vue

In the hero section, add:
```css
.hero-title {
  font: var(--type-display-lg);
  letter-spacing: var(--tracking-display); /* -0.02em */
}

.hero-subtitle,
.section-title {
  font: var(--type-headline-lg);
  letter-spacing: var(--tracking-display);
}
```

For uppercase label elements (tags, version badges):
```css
.version-tag,
.engine-badge,
.label {
  font: var(--type-label-md);
  text-transform: uppercase;
  letter-spacing: var(--tracking-label); /* 0.1em */
}
```

### 4. Nav brand text treatment

The `.nav-brand` / `.brand` elements currently use JetBrains Mono monospace. Update to Manrope for the "Digital Architect" editorial feel:
```css
.nav-brand {
  font-family: var(--font-display);
  font-weight: 800;
  letter-spacing: var(--tracking-display);
  text-transform: uppercase;
}
```

### 5. App.vue global font

Update the root `font-family` in App.vue:
```css
#app, body {
  font-family: var(--font-body);
}
```

### 6. Post-change layout check

Manrope has slightly different character metrics than Space Grotesk. After applying, check:
- Hero text doesn't overflow its container
- Nav bar brand text fits
- Card titles don't cause layout shift
- Long strings in CJK locales still render correctly (Noto Sans SC fallback active)

## Todo List

- [ ] Run font audit grep across all view files
- [ ] Update `App.vue` root font-family
- [ ] Update `Home.vue` — all `font-family` rules, apply type scale to hero/headlines
- [ ] Update `MainView.vue` — replace font references
- [ ] Update `SimulationView.vue` — replace font references
- [ ] Update `Process.vue` — replace font references
- [ ] Update `InteractionView.vue` — replace font references
- [ ] Verify code-output elements keep monospace where needed
- [ ] Start dev server, check hero layout at 1280px and 375px (mobile)
- [ ] Test zh locale — verify CJK fallback renders correctly

## Success Criteria

- `grep -rn "Space Grotesk" frontend/src/` returns 0 matches
- `grep -rn "JetBrains Mono" frontend/src/` returns 0 matches (or only genuine code elements)
- Hero headline uses Manrope at display scale with tight letter-spacing
- Nav brand uses Manrope 800 weight
- CJK characters still render (Noto Sans SC in fallback stack)
- No layout overflow on hero section

## Risk Assessment

- **Medium risk** — font metric change may shift hero layout
- **CJK safety:** Noto Sans SC is in `var(--font-body)` fallback stack; CJK glyphs will continue to render
- **Monospace code output:** If simulation logs rely on monospace alignment, removing JetBrains Mono from those elements will break column alignment — preserve `'JetBrains Mono', monospace` for genuinely code-displaying elements

## Next Steps

→ Phase 6 (Special Effects) can start after this phase  
→ Phase 7 (QA) runs last
