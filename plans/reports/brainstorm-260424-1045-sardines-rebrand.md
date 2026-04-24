---
name: Sardines Rebrand Brainstorm Report
description: Brainstorm analysis for full rebrand of MiroFish → Sardines with BK Global design system
type: project
---

# Sardines Rebrand Brainstorm Report

**Date:** 2026-04-24  
**Scope:** Full design-system overhaul + brand rename MiroFish → Sardines

---

## Problem Statement

Rebrand the MiroFish frontend project to "Sardines" using:
- New logo: `docs/Logo.png` (4-color pinwheel: cyan #00B1E9, yellow #D1DD00, lime #69B42D, royal blue #334A99)
- Design system: `docs/DESIGN.md` (BK Global "Digital Architect" system — Material Design 3 tokens)
- Approach: Full design-system overhaul (centralized CSS tokens, not inline-per-component)
- Constraint: No file modularization (rebrand only, keep Home.vue monolithic)

---

## Current State

| Asset | Current | New |
|---|---|---|
| Brand name | MiroFish | Sardines |
| Primary color | #FF4500 (orange) | #00658d |
| Secondary color | #000000 (black) | #4355b9 |
| Tertiary/accent | — | #496800 |
| Headline font | Space Grotesk | Manrope |
| Body font | Inter | Inter (keep) |
| Code font | JetBrains Mono | Remove (or keep for code blocks) |
| Logo files | MiroFish_logo_*.jpeg | Logo.png (new) |
| Favicon | icon.png (old) | Logo.png (cropped) |

---

## Chosen Approach: Centralized Design Token File

Create `frontend/src/styles/design-tokens.css` with all MD3 surface + brand tokens. Import globally in `main.js`. Update all component `<style>` blocks to reference `var(--token)` instead of hardcoded hex.

**Why over in-place replacement:**  
Matches DESIGN.md intent; creates a real design system foundation; single source of truth.

---

## Files to Modify

- `frontend/index.html` — fonts (add Manrope, remove Space Grotesk), title, meta, favicon ref
- `frontend/src/main.js` — import design-tokens.css
- `package.json` — name "mirofish" → "sardines", description
- `frontend/src/views/Home.vue` — nav brand text, logo imports, CSS vars → token refs
- `frontend/src/App.vue` — global styles update
- `frontend/src/views/Step1.vue` through `Step5.vue` — color/font audit
- `locales/en.json`, `zh.json`, `vi.json`, `es.json`, `fr.json`, `pt.json`, `ru.json`, `de.json` — meta.title, meta.description, brand refs

## Files to Create

- `frontend/src/styles/design-tokens.css` — centralized MD3 design tokens

## Assets to Replace

- `frontend/public/icon.png` — new logo favicon
- `frontend/src/assets/logo/` — add sardines-logo.png (rename from Logo.png)

---

## Implementation Phases

| # | Phase | Risk |
|---|---|---|
| 1 | Token foundation — create design-tokens.css, update index.html fonts | Low |
| 2 | Logo & favicon — replace assets, update references | Low |
| 3 | Brand rename — 8 locale files + package.json + index.html + Home.vue nav | Low |
| 4 | Color overhaul — update all component styles to use tokens | Medium |
| 5 | Typography — apply Manrope to all headline/display elements | Medium |
| 6 | Special effects — glassmorphism nav, hero gradient, logo watermark, border audit | High |
| 7 | QA — visual inspection across all views + locales | Medium |

---

## Key Risks

1. **Font layout shift**: Manrope has different metrics than Space Grotesk — hero spacing needs re-check
2. **Border audit**: `--border: #E5E5E5` used throughout; removing all per DESIGN.md "no-line rule" requires visual QA
3. **Favicon clarity**: 4-color abstract logo at 32×32px may look muddy — test at small sizes
4. **CJK font stack**: Noto Sans SC has no Manrope equivalent; verify fallback chain for CJK locales
5. **Step components 1–5**: Not fully audited — likely carry old orange/black palette

---

## DESIGN.md Special Rules to Enforce

- No 1px solid borders — background-tier shifts only
- Ghost borders for accessibility: `outline-variant` at 15% opacity
- Hero/CTA gradient: `linear-gradient(135deg, #00658d, #00adef)`
- Glassmorphism nav: `backdrop-filter: blur(20px)`
- Logo watermark: Logo.png at 5% opacity on `surface-container-high` backgrounds
- 8px grid alignment
- Buttons: ROUND_FOUR (0.25rem) radius, NO pill-shape
- Cards: `surface-container-low` background, ROUND_FOUR radius
- Inputs: "Filled" style with `surface-container-highest`, 2px primary bottom-border on focus
