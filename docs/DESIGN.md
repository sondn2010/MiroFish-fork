# Design System Document

## 1. Overview & Creative North Star: "The Digital Architect"
This design system is built to reflect the precision, structural integrity, and innovation of BK Global’s software construction expertise. We are moving away from the "standard tech startup" aesthetic—no generic rounded buttons or heavy drop shadows. Instead, we embrace a **"Digital Architect"** North Star.

The system is defined by high-end editorial layouts that mirror the blueprints of complex software systems. We utilize intentional asymmetry, interlocking patterns derived from the BK Global logo, and a sophisticated layering of tech-focused surfaces. This is an "Architectural Tech" style: rigid enough to feel secure, but fluid enough to represent high-velocity development.

## 2. Colors & Surface Logic
The color palette balances a deep professional foundation with vibrant, high-energy accents. We use color not just for decoration, but to define "zones" of information.

### The Palette
*   **Primary (`#00658d`)**: The structural core. Used for navigation and primary actions.
*   **Secondary (`#4355b9`)**: The navy deep-tech tone, used for grounding elements.
*   **Tertiary (`#496800`)**: The lime/yellow logic. Used sparingly for high-visibility signals and "system success" states.
*   **Surface Tiers**: We use the full range from `surface-container-lowest` to `surface-container-highest` to build modularity.

### The "No-Line" Rule
To maintain a high-end editorial feel, **1px solid borders are strictly prohibited for sectioning.** Boundaries must be defined solely through background color shifts. For example, a `surface-container-low` content block should sit on a `surface` background. The shift in tone provides a cleaner, more sophisticated separation than a hard line.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers. Use `surface-container` tiers to create "nested" depth. An inner module within a card should use a slightly higher or lower tier than its parent to define its importance, mimicking a physical architectural model where layers overlap and interlock.

### The "Glass & Gradient" Rule
To move beyond a flat "out-of-the-box" look, we employ Glassmorphism for floating elements. 
*   **Floating Navigation/Modals**: Use semi-transparent surface colors with a `backdrop-blur` effect (e.g., 20px).
*   **Signature Textures**: CTAs and Hero backgrounds should utilize a subtle linear gradient transitioning from `primary` (`#00658d`) to `primary-container` (`#00adef`) at a 135-degree angle. This provides a "visual soul" that flat colors cannot achieve.

## 3. Typography: Editorial Authority
The type system pairs the geometric precision of **Manrope** with the functional clarity of **Inter**.

*   **Display & Headlines (Manrope)**: These are the "Architectural" elements. Use `display-lg` and `headline-lg` with tight letter-spacing (-2%) to create a bold, authoritative voice. 
*   **Body & Labels (Inter)**: Use Inter for all functional reading. It is clean, legible, and disappears into the design, allowing the content to take center stage.
*   **Hierarchy**: Use extreme scale shifts. A very large `display-md` headline paired with a small, uppercase `label-md` (tracked out +10%) creates an editorial look that feels custom and premium.

## 4. Elevation & Depth: Tonal Layering
Traditional structural lines are replaced by **Tonal Layering**.

*   **The Layering Principle**: Depth is achieved by stacking surface-container tiers. For instance, place a `surface-container-lowest` card on a `surface-container-low` section. This creates a soft, natural lift.
*   **Ambient Shadows**: When a floating effect is required (e.g., for a dropdown), use extra-diffused shadows. Set blur values high (24px+) and opacity low (4%-8%). The shadow color should be a tinted version of `on-surface` to mimic natural light.
*   **The "Ghost Border" Fallback**: If a border is required for accessibility, it must be a "Ghost Border"—use the `outline-variant` token at 15% opacity. Never use 100% opaque, high-contrast borders.
*   **High-Tech Patterns**: Integrate interlocking circular patterns (derived from the logo) as subtle watermarks on `surface-container-high` backgrounds to reinforce the "Construction" theme.

## 5. Components

### Buttons
*   **Primary**: Gradient fill (`primary` to `primary-container`) with `on-primary` text. `ROUND_FOUR` (0.25rem) corner radius.
*   **Secondary**: `surface-container-highest` background with `primary` text. No border.
*   **Tertiary**: Text-only with a heavy weight; use `label-md` style in all caps for an architectural label feel.

### Cards & Lists
*   **Constraint**: No divider lines. Separate list items using vertical white space from the spacing scale or subtle alternating background shifts (e.g., `surface` to `surface-container-lowest`).
*   **Cards**: Use `surface-container-low` with a `ROUND_FOUR` radius. Content should feel "inset" into the layout.

### Input Fields
*   **Style**: Use a "Filled" style with `surface-container-highest`. 
*   **Active State**: Indicate focus with a 2px `primary` bottom-border only, rather than a full box stroke, to maintain the architectural "blueprint" aesthetic.

### Chips
*   **Logic**: Use `tertiary-container` (`#83b02a`) for "Active" or "System Go" states. Use `secondary-fixed` for neutral filters. Shapes should be strictly `ROUND_FOUR`, never fully rounded (pill-shaped).

## 6. Do's and Don'ts

### Do
*   **DO** use whitespace as a structural tool. Let the layout breathe.
*   **DO** use the logo's interlocking curves as oversized, cropped background elements at 5% opacity.
*   **DO** align all elements to a strict 8px grid to reinforce the "construction" nature.

### Don't
*   **DON'T** use 1px solid black or grey borders to separate sections.
*   **DON'T** use pill-shaped (fully rounded) buttons; they conflict with the "Architectural" brand pillars.
*   **DON'T** use standard "drop shadows." Only use tonal shifts and diffused ambient light.
*   **DON'T** clutter the UI with icons. Use typography and color shifts to lead the eye first.