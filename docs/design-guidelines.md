# Design Guidelines — Sardines MD3 Implementation

## Overview

The Sardines frontend implements **Material Design 3 (MD3)** within the context of the **"Digital Architect"** brand philosophy. All design decisions—colors, typography, spacing, elevation—are driven by CSS custom properties defined in `frontend/src/styles/design-tokens.css`.

This document explains how to use the token system and maintain design consistency.

---

## Design Tokens

All design values are centralized in `frontend/src/styles/design-tokens.css`. **Do not hardcode colors, fonts, or spacing in component styles.**

### Color System

#### Primary Brand Colors
```css
--md-primary: #00658d           /* Structural core, navigation, primary actions */
--md-primary-container: #00adef /* Lighter variant for hover states, CTAs */
--md-on-primary: #ffffff        /* Text on primary colors */
```

**Usage:**
```vue
<button style="background: var(--md-primary); color: var(--md-on-primary);">
  Primary Action
</button>
```

#### Secondary Colors
```css
--md-secondary: #4355b9              /* Navy deep-tech tone */
--md-secondary-container: #dde1ff    /* Light secondary variant */
--md-on-secondary: #ffffff           /* Text on secondary */
```

**Usage:** Secondary buttons, supporting information, grounded elements.

#### Tertiary Colors (Signal & Success)
```css
--md-tertiary: #496800              /* Lime/yellow logic */
--md-tertiary-container: #83b02a    /* High-visibility signals */
--md-on-tertiary: #ffffff           /* Text on tertiary */
```

**Usage:** System success states, validation feedback, high-priority signals.

#### Surface Hierarchy (5-Tier System)
```css
--md-surface: #fafcff                          /* Base background */
--md-surface-container-lowest: #ffffff         /* Highest contrast (cards) */
--md-surface-container-low: #f1f4f9            /* Subtle lift from base */
--md-surface-container: #e5e8f0                /* Mid-tier containment */
--md-surface-container-high: #dce0ea           /* More prominent */
--md-surface-container-highest: #d0d4e0        /* Deepest container */
--md-on-surface: #191c20                       /* Text on surfaces */
--md-on-surface-variant: #44474f               /* Secondary text */
```

**Usage Pattern:**
```vue
<!-- Outer section -->
<div style="background: var(--md-surface-container-low);">
  <!-- Inner card (creates depth) -->
  <div style="background: var(--md-surface-container-lowest);">
    Content
  </div>
</div>
```

**Design Principle:** Use tonal shifts to create hierarchy and nesting. **Never use 1px solid borders.**

#### Semantic States
```css
--md-error: #ba1a1a                 /* Error state, destructive actions */
--md-error-container: #ffdad6       /* Light error background */
--md-on-error: #ffffff              /* Text on error */

--md-success: #1a936f               /* Successful completion */
--md-success-container: #d4f5e9     /* Light success background */

--md-warning: #ff6b35               /* Warning/caution state */
--md-warning-container: #ffe0d6     /* Light warning background */
```

#### Outline (for focus, accessibility)
```css
--md-outline: #74777f                           /* Full-opacity outline */
--md-outline-variant: rgba(116, 119, 127, 0.15) /* Ghost border (15% opacity) */
```

**Usage:** Apply `--md-outline-variant` only when accessibility requires a visible border (e.g., focus rings). Do not use as a general divider.

---

## Typography

### Font Stacks

**Display & Headlines (Geometric Authority)**
```css
--font-display: 'Manrope', system-ui, sans-serif;
```

- Large, bold, tight letter-spacing
- Use for page titles, hero headings, section headers
- Conveys precision and architectural quality

**Body & Labels (Functional Clarity)**
```css
--font-body: 'Inter', 'Noto Sans SC', system-ui, sans-serif;
```

- Clean, legible, minimal personality
- Use for all reading content, UI labels, form text
- Fallback to Noto Sans SC for CJK characters

### Type Scale

```css
/* Display */
--type-display-lg: 700 3.5rem/1.1 var(--font-display);   /* 56px, bold */
--type-display-md: 700 2.8rem/1.15 var(--font-display);  /* 44px, bold */

/* Headlines */
--type-headline-lg: 600 2rem/1.2 var(--font-display);    /* 32px, semi-bold */
--type-headline-md: 600 1.5rem/1.25 var(--font-display); /* 24px, semi-bold */

/* Body */
--type-body-lg: 400 1rem/1.6 var(--font-body);           /* 16px, regular */
--type-body-md: 400 0.875rem/1.5 var(--font-body);       /* 14px, regular */

/* Labels (UI, buttons) */
--type-label-md: 500 0.75rem/1 var(--font-body);         /* 12px, medium */
```

**Usage:**
```vue
<h1 style="font: var(--type-display-md);">Page Title</h1>
<h2 style="font: var(--type-headline-lg);">Section</h2>
<p style="font: var(--type-body-lg);">Body text content.</p>
<label style="font: var(--type-label-md);">LABEL TEXT</label>
```

### Letter Spacing

```css
--tracking-display: -0.02em;  /* Tight for display */
--tracking-label: 0.1em;      /* Tracked out for uppercase labels */
```

Apply tracking to emphasize hierarchy:
```vue
<label style="letter-spacing: var(--tracking-label);">
  STEP 1: CONFIGURE
</label>
```

---

## Spacing & Grid

**8px Base Grid**
```css
--space-1: 0.5rem;  /* 8px */
--space-2: 1rem;    /* 16px */
--space-3: 1.5rem;  /* 24px */
--space-4: 2rem;    /* 32px */
--space-6: 3rem;    /* 48px */
--space-8: 4rem;    /* 64px */
```

**Usage:**
```vue
<div style="padding: var(--space-3); margin-bottom: var(--space-4);">
  Content
</div>
```

**Grid Principle:** All elements must align to 8px. Never use arbitrary pixel values.

---

## Border Radius

```css
--round-four: 0.25rem;  /* 4px, subtle, card corners */
--round-md: 0.5rem;     /* 8px, moderate */
--round-lg: 1rem;       /* 16px, larger panels */
```

**Do Not Use:** Fully rounded pills (100% border-radius). Use `--round-four` for a professional, architectural feel.

---

## Elevation & Shadows

### Glassmorphism (Floating Elements)

Use for floating navigation, modals, and floating panels:

```css
--glass-bg: rgba(250, 252, 255, 0.72);  /* Semi-transparent surface */
--glass-blur: blur(20px);                /* Blur effect */
```

**Component Example:**
```vue
<div style="
  background: var(--glass-bg);
  backdrop-filter: var(--glass-blur);
  border-radius: var(--round-lg);
">
  Floating Panel
</div>
```

### Ambient Shadows (Depth without Borders)

Replace traditional drop-shadows with subtle ambient light:

```css
--shadow-float: 0 8px 32px rgba(25, 28, 32, 0.06);   /* Floating elements */
--shadow-card: 0 2px 16px rgba(25, 28, 32, 0.04);    /* Cards */
```

**Usage:**
```vue
<div style="box-shadow: var(--shadow-card);">
  Card
</div>

<div style="box-shadow: var(--shadow-float);">
  Floating Panel
</div>
```

**Principle:** Shadows are diffuse and low-opacity (4–6%), mimicking soft natural light. Never use sharp, high-contrast shadows.

---

## Gradients

Used for CTAs and hero backgrounds to provide visual soul:

```css
--gradient-cta: linear-gradient(135deg, #00658d, #00adef);   /* Button CTAs */
--gradient-hero: linear-gradient(135deg, #00658d, #00adef);  /* Hero sections */
```

**Usage:**
```vue
<button style="background: var(--gradient-cta);">
  Call to Action
</button>
```

**Angle:** Always 135 degrees (diagonal, top-left to bottom-right). Maintains consistent brand feel.

---

## Component Patterns

### Buttons

**Primary Button (Gradient CTA)**
```vue
<button style="
  background: var(--gradient-cta);
  color: var(--md-on-primary);
  padding: var(--space-2) var(--space-4);
  border-radius: var(--round-four);
  border: none;
  font: var(--type-label-md);
  cursor: pointer;
">
  Action
</button>
```

**Secondary Button (Flat)**
```vue
<button style="
  background: var(--md-surface-container-highest);
  color: var(--md-primary);
  padding: var(--space-2) var(--space-4);
  border-radius: var(--round-four);
  border: none;
  font: var(--type-label-md);
">
  Secondary
</button>
```

**Tertiary Button (Text Only)**
```vue
<button style="
  background: transparent;
  color: var(--md-primary);
  font: var(--type-label-md);
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: var(--tracking-label);
  border: none;
  cursor: pointer;
">
  Tertiary
</button>
```

### Cards & Containers

**Nested Card Pattern**
```vue
<div style="background: var(--md-surface-container-low); padding: var(--space-4);">
  <div style="
    background: var(--md-surface-container-lowest);
    padding: var(--space-3);
    border-radius: var(--round-lg);
    box-shadow: var(--shadow-card);
  ">
    <h2 style="font: var(--type-headline-md); margin-bottom: var(--space-2);">
      Section Title
    </h2>
    <p style="font: var(--type-body-md);">Content</p>
  </div>
</div>
```

**Principle:** Create depth through layering surface tiers, not borders.

### Input Fields

```vue
<input style="
  background: var(--md-surface-container-highest);
  border: none;
  border-bottom: 2px solid var(--md-primary);
  padding: var(--space-2);
  font: var(--type-body-md);
  color: var(--md-on-surface);
" placeholder="Enter text" />
```

**Active State:** 2px bottom-border in primary color (blueprint aesthetic).
**No full box stroke:** Maintain clean, minimal appearance.

### Chips & Tags

**Active Chip (Success State)**
```vue
<span style="
  background: var(--md-tertiary-container);
  color: var(--md-on-tertiary);
  padding: var(--space-1) var(--space-2);
  border-radius: var(--round-four);
  font: var(--type-label-md);
">
  Active
</span>
```

**Neutral Chip (Filter)**
```vue
<span style="
  background: var(--md-surface-container-high);
  color: var(--md-on-surface);
  padding: var(--space-1) var(--space-2);
  border-radius: var(--round-four);
  font: var(--type-label-md);
">
  Filter
</span>
```

---

## Do's and Don'ts

### Do
- **DO** use CSS custom properties for all color, font, and spacing values.
- **DO** align all elements to 8px grid.
- **DO** use the logo's interlocking curves as subtle 5% opacity watermarks on high containers.
- **DO** layer surface tiers to create depth and hierarchy.
- **DO** use extreme typography scale shifts (e.g., display-md headline with label-md subtext).
- **DO** maintain tight letter-spacing on Manrope headings (-2%).

### Don't
- **DON'T** hardcode colors or fonts in component styles.
- **DON'T** use 1px solid borders for section separation.
- **DON'T** use pill-shaped (fully rounded) buttons; use `--round-four` (4px).
- **DON'T** use sharp, high-contrast drop shadows; use the ambient shadow tokens.
- **DON'T** create custom color values outside the token system.
- **DON'T** clutter the UI with decorative icons; use typography and color shifts to guide the eye.

---

## Accessibility

### Focus States
```vue
<button style="outline: 2px solid var(--md-outline); outline-offset: 2px;">
  Accessible Focus
</button>
```

### Color Contrast
- Primary text on surfaces: `--md-on-surface` (#191c20) on `--md-surface` (meets WCAG AA)
- All semantic colors tested for minimum 4.5:1 contrast ratio on light backgrounds

### Motion & Animations
- Prefer `prefers-reduced-motion` media query to respect user preferences
- Animations should be subtle (200–400ms duration)

---

## Migration Guide: From Hardcoded to Tokens

**Before:**
```vue
<div style="background: #f1f4f9; color: #191c20; padding: 16px;">
  Content
</div>
```

**After:**
```vue
<div style="
  background: var(--md-surface-container-low);
  color: var(--md-on-surface);
  padding: var(--space-2);
">
  Content
</div>
```

All frontend views have been refactored to use tokens. Maintain this practice for all new components.

---

## Reference

- **Token Source:** `frontend/src/styles/design-tokens.css`
- **Design Philosophy:** `docs/DESIGN.md` ("Digital Architect")
- **Brand Colors:** Primary #00658d, Secondary #4355b9, Tertiary #496800
- **Typography:** Manrope (display), Inter (body)

For questions or updates to the design system, consult the design leadership and update `docs/DESIGN.md` and this document accordingly.
