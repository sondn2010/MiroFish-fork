# Phase 6 — Special Effects

**Context:** [plan.md](./plan.md) | [DESIGN.md](../../docs/DESIGN.md)  
**Depends on:** Phase 1 (tokens), Phase 4 (colors), Phase 5 (typography)

## Overview

- **Priority:** P2
- **Status:** Pending
- **Effort:** ~3h
- Apply the "Digital Architect" signature effects from DESIGN.md: glassmorphism navigation, hero CTA gradient, logo watermark pattern, ambient shadow system, and ROUND_FOUR component shapes. This phase is the highest-risk and highest-visual-impact step.

## Key Insights

**DESIGN.md effects to implement:**
1. **Glass Nav**: `backdrop-filter: blur(20px)` + semi-transparent `var(--glass-bg)` on navbar
2. **Hero/CTA Gradient**: `linear-gradient(135deg, #00658d, #00adef)` on primary buttons and hero backgrounds
3. **Logo Watermark**: Sardines logo at 5% opacity as `background-image` on `surface-container-high` sections
4. **Ambient Shadows**: `blur: 24px+, opacity: 4-8%` — no hard drop shadows
5. **ROUND_FOUR**: All buttons, cards, chips use `border-radius: var(--round-four)` (0.25rem)
6. **Chips**: `tertiary-container` (`#83b02a`) for active states; ROUND_FOUR shape (never pill)

**Current state:**
- Navbar: opaque solid black background
- Buttons: rounded but not standardized
- Shadows: likely hard `box-shadow` values present

## Files to Modify

- `frontend/src/views/Home.vue` — nav glass, hero gradient, logo watermark, button radii
- `frontend/src/views/MainView.vue` — nav glass, button/card radii
- `frontend/src/views/SimulationView.vue` — nav glass, status chips
- `frontend/src/views/Process.vue` — nav glass, button radii, card shadows
- `frontend/src/views/InteractionView.vue` — nav glass, button radii

## Implementation Steps

### 1. Glassmorphism Navigation

In every view that has a nav/header element, update:

```css
.nav, .navbar, .header, .app-header {
  background: var(--glass-bg);           /* rgba(250,252,255,0.72) */
  backdrop-filter: var(--glass-blur);    /* blur(20px) */
  -webkit-backdrop-filter: var(--glass-blur);
  border-bottom: none;                   /* remove any 1px border */
  /* Add subtle ambient shadow instead */
  box-shadow: 0 2px 24px rgba(25, 28, 32, 0.04);
}
```

> Important: glassmorphism requires a non-white background beneath it to be visible. The hero section / page background must have some color/texture for glass to show.

### 2. Hero CTA Gradient

In Home.vue, apply gradient to the primary CTA button and hero background accent:

```css
/* Primary button */
.btn-primary, .cta-button, [class*="primary-btn"] {
  background: var(--gradient-cta);
  color: var(--md-on-primary);
  border: none;
  border-radius: var(--round-four);
  /* Remove any old box-shadow or hard border */
}

/* Hero background accent strip */
.hero-section::before, .hero-bg {
  background: var(--gradient-hero);
  opacity: 0.08; /* subtle wash behind content */
}
```

### 3. Logo Watermark Pattern

Per DESIGN.md: "Use the logo's interlocking curves as oversized, cropped background elements at 5% opacity."

Apply to sections with `surface-container-high` background:

```css
.hero-section, .feature-section, [class*="surface-high"] {
  position: relative;
}

.hero-section::after {
  content: '';
  position: absolute;
  top: -10%;
  right: -10%;
  width: 60%;
  aspect-ratio: 1;
  background-image: url('@/assets/logo/sardines-logo.png');
  background-size: contain;
  background-repeat: no-repeat;
  opacity: 0.05;
  pointer-events: none;
  z-index: 0;
}

/* Ensure hero content stays above watermark */
.hero-content {
  position: relative;
  z-index: 1;
}
```

### 4. Ambient Shadow System

Find all existing `box-shadow` rules and replace hard shadows:

```bash
grep -rn "box-shadow" frontend/src/views/ frontend/src/App.vue
```

Replace:
```css
/* Old (hard drop shadow) */
box-shadow: 0 2px 8px rgba(0,0,0,0.3);

/* New (ambient light) */
box-shadow: var(--shadow-card);  /* 0 2px 16px rgba(25,28,32,0.04) */

/* For floating elements (dropdowns, modals) */
box-shadow: var(--shadow-float); /* 0 8px 32px rgba(25,28,32,0.06) */
```

### 5. ROUND_FOUR Standardization

Audit all `border-radius` values and standardize:

```css
/* Buttons */
button, .btn {
  border-radius: var(--round-four); /* 0.25rem */
}

/* Cards */
.card, [class*="-card"] {
  border-radius: var(--round-four);
}

/* Chips/Tags */
.chip, .tag, [class*="-tag"] {
  border-radius: var(--round-four); /* NOT 50% or 9999px — pill shape forbidden */
}

/* Inputs */
input, textarea, select {
  border-radius: var(--round-four);
}
```

> DO NOT use `border-radius: 50%` or `border-radius: 9999px` for chips/buttons — DESIGN.md explicitly forbids pill shapes.

### 6. Chip Active State

Active/selected chips use `tertiary-container`:
```css
.chip.active, .tag.active, .filter.active {
  background: var(--md-tertiary-container); /* #83b02a */
  color: var(--md-on-tertiary);
  border-radius: var(--round-four);
}
```

### 7. Input Field "Filled" Style

Per DESIGN.md: inputs use "Filled" style with `surface-container-highest`, focus indicated by 2px primary bottom-border:
```css
input, textarea {
  background: var(--md-surface-container-highest);
  border: none;
  border-bottom: 2px solid transparent;
  border-radius: var(--round-four) var(--round-four) 0 0;
  padding: var(--space-1) var(--space-2);
}

input:focus, textarea:focus {
  outline: none;
  border-bottom-color: var(--md-primary);
}
```

## Todo List

- [ ] Audit all views for nav/header selectors — apply glass effect
- [ ] Verify page background has sufficient color for glass to read
- [ ] Apply gradient to primary CTA buttons in Home.vue
- [ ] Add logo watermark `::after` pseudo-element to hero section
- [ ] Audit all `box-shadow` rules — replace with ambient tokens
- [ ] Audit all `border-radius` — standardize to `var(--round-four)`, remove pill shapes
- [ ] Update active chip/tag styles to use `tertiary-container`
- [ ] Update input fields to "Filled" style
- [ ] Visual test: glassmorphism nav readability over hero background
- [ ] Visual test: logo watermark — ensure 5% opacity is subtle enough
- [ ] Mobile test: glass nav at 375px width

## Success Criteria

- Nav bar has glass blur effect visible over hero background
- Primary CTA button shows `#00658d → #00adef` gradient
- Logo watermark visible at 5% opacity on hero/section backgrounds
- All buttons/cards/chips use `0.25rem` border radius (no pills)
- No hard drop shadows — only ambient `0 8px 32px rgba(..., 0.06)` style
- Active chips use `#83b02a` background

## Risk Assessment

- **High risk** — visual changes affect all components; glass effect requires non-trivial CSS
- **Glass nav on white bg:** Glass is invisible over white — hero must have a colored/gradient background beneath the nav. If it doesn't, glass has no effect visually. Mitigation: add a subtle `surface-container-low` page background or keep nav semi-solid.
- **Watermark z-index:** The `::after` absolute element must not intercept clicks — always set `pointer-events: none`
- **Safari `-webkit-backdrop-filter`:** Required for Safari support — always add alongside `backdrop-filter`
- **Pill shape audit:** Process.vue uses `border-radius: 50%` for status dots (legitimate circles) — don't change those, only change UI chips/buttons

## Next Steps

→ Phase 7 (QA) after this phase
