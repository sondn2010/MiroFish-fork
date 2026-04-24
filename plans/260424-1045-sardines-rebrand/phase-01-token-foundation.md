# Phase 1 — Token Foundation

**Context:** [plan.md](./plan.md) | [DESIGN.md](../../docs/DESIGN.md) | [Brainstorm](../reports/brainstorm-260424-1045-sardines-rebrand.md)

## Overview

- **Priority:** P1 — must complete before phases 4, 5, 6
- **Status:** Pending
- **Effort:** ~1h
- Create centralized `frontend/src/styles/design-tokens.css` with all Material Design 3 brand + surface tokens defined in `docs/DESIGN.md`. Import it globally. Update `index.html` to load new fonts.

## Key Insights

- Current project has no shared CSS token file — all vars are scoped inside each `<style>` block per component
- DESIGN.md specifies MD3 surface tier system (`surface-container-lowest` → `surface-container-highest`)
- Manrope font not yet loaded — must add Google Fonts import
- Inter is already loaded (keep); Space Grotesk and JetBrains Mono will be removed in Phase 5
- Noto Sans SC must be retained for CJK locale fallback

## Requirements

- Single CSS file as the design token source of truth
- All brand colors, surface tiers, typography scale, gradients, and glass vars defined
- Imported before any component CSS (via `main.js`)
- No component changes in this phase — foundation only

## Files to Create

- `frontend/src/styles/design-tokens.css`

## Files to Modify

- `frontend/src/main.js` — add `import './styles/design-tokens.css'`
- `frontend/index.html` — add Manrope to Google Fonts URL, remove Space Grotesk

## Implementation Steps

### 1. Create `frontend/src/styles/design-tokens.css`

```css
/* ============================================================
   Sardines Design Tokens — BK Global "Digital Architect"
   Source: docs/DESIGN.md
   ============================================================ */

:root {
  /* --- Brand Colors --- */
  --md-primary: #00658d;
  --md-primary-container: #00adef;
  --md-on-primary: #ffffff;
  --md-secondary: #4355b9;
  --md-secondary-container: #dde1ff;
  --md-on-secondary: #ffffff;
  --md-tertiary: #496800;
  --md-tertiary-container: #83b02a;
  --md-on-tertiary: #ffffff;

  /* --- Surface Tiers (MD3) --- */
  --md-surface: #fafcff;
  --md-surface-container-lowest: #ffffff;
  --md-surface-container-low: #f1f4f9;
  --md-surface-container: #e5e8f0;
  --md-surface-container-high: #dce0ea;
  --md-surface-container-highest: #d0d4e0;
  --md-on-surface: #191c20;
  --md-on-surface-variant: #44474f;
  --md-outline: #74777f;
  --md-outline-variant: rgba(116, 119, 127, 0.15); /* Ghost border — 15% opacity */

  /* --- Semantic States --- */
  --md-error: #ba1a1a;
  --md-error-container: #ffdad6;
  --md-on-error: #ffffff;
  --md-success: #1a936f;
  --md-success-container: #d4f5e9;
  --md-warning: #ff6b35;
  --md-warning-container: #ffe0d6;

  /* --- Typography Stacks --- */
  --font-display: 'Manrope', system-ui, sans-serif;
  --font-body: 'Inter', 'Noto Sans SC', system-ui, sans-serif;

  /* --- Type Scale --- */
  --type-display-lg: 700 3.5rem/1.1 var(--font-display);
  --type-display-md: 700 2.8rem/1.15 var(--font-display);
  --type-headline-lg: 600 2rem/1.2 var(--font-display);
  --type-headline-md: 600 1.5rem/1.25 var(--font-display);
  --type-body-lg: 400 1rem/1.6 var(--font-body);
  --type-body-md: 400 0.875rem/1.5 var(--font-body);
  --type-label-md: 500 0.75rem/1 var(--font-body);

  /* --- Letter Spacing --- */
  --tracking-display: -0.02em;   /* tight — headlines */
  --tracking-label: 0.1em;       /* wide — uppercase labels */

  /* --- Gradients --- */
  --gradient-cta: linear-gradient(135deg, #00658d, #00adef);
  --gradient-hero: linear-gradient(135deg, #00658d, #00adef);

  /* --- Glassmorphism --- */
  --glass-bg: rgba(250, 252, 255, 0.72);
  --glass-blur: blur(20px);

  /* --- Spacing (8px grid) --- */
  --space-1: 0.5rem;   /* 8px */
  --space-2: 1rem;     /* 16px */
  --space-3: 1.5rem;   /* 24px */
  --space-4: 2rem;     /* 32px */
  --space-6: 3rem;     /* 48px */
  --space-8: 4rem;     /* 64px */

  /* --- Border Radius --- */
  --round-four: 0.25rem;   /* ROUND_FOUR — buttons, cards, chips */
  --round-md: 0.5rem;
  --round-lg: 1rem;

  /* --- Shadows (ambient only — no hard drop shadows) --- */
  --shadow-float: 0 8px 32px rgba(25, 28, 32, 0.06);
  --shadow-card: 0 2px 16px rgba(25, 28, 32, 0.04);
}
```

### 2. Update `frontend/src/main.js`

Add import at top of file (before app mount):
```js
import './styles/design-tokens.css'
```

### 3. Update `frontend/index.html` Google Fonts

Replace the current fonts URL. Current loads: Inter, JetBrains Mono, Noto Sans SC, Space Grotesk.

New URL should load: **Manrope** (add), Inter (keep), Noto Sans SC (keep), remove Space Grotesk & JetBrains Mono.

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Manrope:wght@400;500;600;700;800&family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
```

## Todo List

- [ ] Create `frontend/src/styles/` directory
- [ ] Write `frontend/src/styles/design-tokens.css` with all tokens above
- [ ] Add import to `frontend/src/main.js`
- [ ] Update Google Fonts link in `frontend/index.html`
- [ ] Run `cd frontend && npm run build` to verify no CSS parse errors

## Success Criteria

- `design-tokens.css` file exists and all `:root` vars are parseable
- `npm run build` passes without errors
- No visible UI change yet (tokens defined but components still use old vars)

## Risk Assessment

- **Low risk** — creating a new file and updating imports; no component code changes
- If `frontend/src/styles/` directory doesn't exist, create it first

## Next Steps

→ Phase 2 (Logo & Favicon) can run in parallel  
→ Phase 3 (Brand Rename) can run in parallel  
→ Phase 4 depends on this phase completing first
