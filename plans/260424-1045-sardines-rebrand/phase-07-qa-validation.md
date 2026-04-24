# Phase 7 — QA & Validation

**Context:** [plan.md](./plan.md)  
**Depends on:** All phases 1–6 complete

## Overview

- **Priority:** P2
- **Status:** Pending
- **Effort:** ~1.5h
- Visual and functional validation of the complete rebrand across all views, locales, and screen sizes. Ensure build passes, no regressions, and the design matches `docs/DESIGN.md` intent.

## Checklist

### Build Validation

- [ ] `cd frontend && npm run build` — exits 0, no CSS/JS errors
- [ ] No broken asset imports (logo paths, font URLs)
- [ ] No console errors on page load (`npm run dev` → open browser DevTools)

### Brand Rename Verification

```bash
# Must return 0 matches
grep -rn "MiroFish\|MIROFISH" frontend/src/ locales/
grep -rn "mirofish" package.json
```

- [ ] All nav-brand elements display "SARDINES"
- [ ] Page title shows "Sardines - Predict Everything"
- [ ] Browser tab favicon shows new logo

### Color Token Verification

```bash
# Should return 0 old hex brand colors (orange, old black accents)
grep -rn "#FF4500\|#FF6B35\|#000000" frontend/src/views/ frontend/src/App.vue
```

- [ ] Primary actions/CTAs use teal (`#00658d`) gradient
- [ ] No orange (#FF4500 / #FF6B35) visible in UI
- [ ] Status colors (error red, success green, warning) still work correctly
- [ ] Section separations are background-tier shifts, not borders

### Typography Verification

```bash
grep -rn "Space Grotesk\|JetBrains Mono" frontend/src/
```

- [ ] Returns 0 matches (or only genuine code-output elements)
- [ ] Hero title renders in Manrope, bold, tight letter-spacing
- [ ] Nav brand "SARDINES" renders in Manrope 800 weight
- [ ] Body copy renders in Inter
- [ ] CJK characters in zh locale still render correctly (Noto Sans SC fallback)

### Design Rules Compliance (DESIGN.md)

- [ ] **No 1px solid borders** separating sections (background shifts only)
- [ ] **Ghost borders** (`outline-variant` at 15% opacity) used for accessibility borders if needed
- [ ] **No pill-shaped buttons/chips** — all radii are `0.25rem` max
- [ ] **No hard drop shadows** — only diffused ambient shadows
- [ ] Primary buttons have gradient fill (`linear-gradient(135deg, #00658d, #00adef)`)

### Per-View Visual Checklist

For each view, open in browser and verify:

| View | Nav Glass | Brand Text | Colors | Fonts | Logo/Favicon |
|---|---|---|---|---|---|
| Home (landing) | ✓ glass | SARDINES | teal primary | Manrope headline | Logo in hero |
| MainView | ✓ glass | SARDINES | teal | Manrope/Inter | — |
| SimulationView | ✓ glass | SARDINES | teal | Manrope/Inter | — |
| Process | ✓ glass | SARDINES | teal | Manrope/Inter | — |
| InteractionView | ✓ glass | SARDINES | teal | Manrope/Inter | — |

### Locale Tests

- [ ] Switch to **zh** (Chinese): CJK text renders, brand shows "Sardines" in title
- [ ] Switch to **vi** (Vietnamese): Vietnamese diacritics render, brand shows "Sardines"
- [ ] Switch to **en** (English): All brand strings are "Sardines"
- [ ] `meta.title` in browser tab updates when locale switches (if dynamic)

### Responsive / Screen Size Tests

- [ ] **1280px desktop**: Hero section no overflow, nav fits
- [ ] **768px tablet**: Nav doesn't wrap awkwardly
- [ ] **375px mobile**: Hero text readable, nav collapses correctly
- [ ] **Favicon at 32×32**: Legible (open in separate tab, check browser tab)

### Special Effects Tests

- [ ] **Glass nav**: Scroll down on Home — blur visible over hero content
- [ ] **Logo watermark**: Visible at 5% opacity in hero background (subtle)
- [ ] **CTA button gradient**: Hover state doesn't break gradient
- [ ] **Input fields**: Focus shows 2px primary bottom-border (no full box stroke)

## Known Acceptable Gaps (pre-approved exceptions)

- **JetBrains Mono** in genuine terminal/log output elements — kept intentionally
- **Status dot circles** with `border-radius: 50%` — legitimate circles, not UI chips
- **Noto Sans SC** font not replaced for CJK — intentional for CJK locale support
- **GitHub link** in Home.vue — may point to placeholder URL until repo is renamed

## Unresolved Questions (if any remain after QA)

1. Is there a correct GitHub repository URL for "Sardines"? The link in Home.vue currently points to the old MiroFish repo.
2. Should `frontend/public/icon.png` be a resized version of Logo.png for sharper small-size favicon, or is direct copy acceptable?
3. Any additional locale files planned beyond en/vi/zh that would need the brand rename treatment?

## Done Criteria

All checkboxes above checked AND:
- `npm run build` exits 0
- All grep checks return 0 unwanted matches
- No visible orange, black-dominant, or Space Grotesk/JetBrains Mono UI elements
- Brand "Sardines" visible everywhere "MiroFish" was before
