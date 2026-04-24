# Phase 4 — Color Overhaul

**Context:** [plan.md](./plan.md) | [DESIGN.md](../../docs/DESIGN.md)  
**Depends on:** Phase 1 (design-tokens.css must exist)

## Overview

- **Priority:** P1
- **Status:** Pending
- **Effort:** ~4h
- Replace all hardcoded hex colors across every Vue component with `var(--md-*)` design token references. Remove old CSS variable definitions that duplicate the token file.

## Key Insights

**Color inventory from audit:**

| File | Old Colors | Notes |
|---|---|---|
| `App.vue` | `#000000`, `#ffffff`, `#f1f1f1`, `#333333` | Scrollbar styles |
| `Home.vue` | `--black`, `--white`, `--orange: #FF4500`, `--gray-light`, `--border`, + many hardcoded | Has CSS var block + hardcoded fallbacks |
| `MainView.vue` | `#EAEAEA`, `#F5F5F5`, `#FFF`, `#000`, `#999`, `#E0E0E0` + status dots | Has `MIROFISH` brand |
| `SimulationView.vue` | Same palette as MainView + status dots `#FF5722`, `#4CAF50`, `#F44336` | |
| `Process.vue` | `--orange: #FF6B35` (different!), `#1A936F`, `#C5283D`, `#FFE0D6` | Most complex — has its own CSS var block |
| `InteractionView.vue` | `#EAEAEA`, `#F5F5F5`, `#999`, `#E0E0E0` + status dots | |
| `ReportView.vue` | Similar to InteractionView | Assumed — verify with grep |
| `SimulationRunView.vue` | Similar to InteractionView | Assumed — verify with grep |

**Token Mapping:**

| Old Value | Token | Notes |
|---|---|---|
| `#FF4500`, `#FF6B35` (orange) | `var(--md-primary)` | Primary brand action color |
| `#000000`, `#000` (black) | `var(--md-on-surface)` | Main text |
| `#ffffff`, `#FFF` (white) | `var(--md-surface-container-lowest)` | Backgrounds |
| `#F5F5F5`, `#FAFAFA` (light gray bg) | `var(--md-surface-container-low)` | Subtle backgrounds |
| `#E5E5E5`, `#EAEAEA`, `#E0E0E0` (borders) | `var(--md-outline-variant)` | Ghost borders (15% opacity per DESIGN.md) |
| `#666666`, `#666` (secondary text) | `var(--md-on-surface-variant)` | Secondary/muted text |
| `#999`, `#CCC` (placeholder text) | `var(--md-outline)` | Tertiary/hint text |
| `#FF5722` (processing dot) | `var(--md-warning)` | Keep semantic meaning |
| `#4CAF50` (completed dot) | `var(--md-success)` | Keep semantic meaning |
| `#F44336`, `#C5283D` (error) | `var(--md-error)` | Keep semantic meaning |
| `#1A936F` (success dark) | `var(--md-success)` | |
| `#4355b9` / secondary | `var(--md-secondary)` | Use for grounding elements |

## Files to Modify

1. `frontend/src/App.vue`
2. `frontend/src/views/Home.vue`
3. `frontend/src/views/MainView.vue`
4. `frontend/src/views/SimulationView.vue`
5. `frontend/src/views/Process.vue`
6. `frontend/src/views/InteractionView.vue`
7. `frontend/src/views/ReportView.vue` (verify first)
8. `frontend/src/views/SimulationRunView.vue` (verify first)

## Implementation Steps

### 1. Full color audit before editing

```bash
grep -rn "#[0-9A-Fa-f]\{3,6\}" frontend/src/views/ frontend/src/App.vue 2>&1 | grep -v "node_modules"
```

### 2. App.vue — scrollbar colors

Replace:
```css
/* Before */
background-color: #000000;
background-color: #ffffff;
color: #f1f1f1;
color: #333333;

/* After */
background-color: var(--md-on-surface);
background-color: var(--md-surface);
color: var(--md-surface-container-low);
color: var(--md-on-surface-variant);
```

Also update the global `font-family` to `var(--font-body)`.

### 3. Home.vue — remove old CSS var block, replace with tokens

The `:root` or `.home` block currently defines:
```css
--black: #000000;
--white: #FFFFFF;
--orange: #FF4500;
--gray-light: #F5F5F5;
--gray-text: #666666;
--border: #E5E5E5;
```

**Delete this entire block.** Then replace usages throughout the file:

```css
/* Old → New (in every rule that uses these) */
var(--black)   → var(--md-on-surface)
var(--white)   → var(--md-surface-container-lowest)
var(--orange)  → var(--md-primary)
var(--gray-light) → var(--md-surface-container-low)
var(--gray-text) → var(--md-on-surface-variant)
var(--border)  → var(--md-outline-variant)
```

Then replace all remaining hardcoded hex values using the mapping table above.

### 4. Process.vue — its own CSS var block

Process.vue has `--orange: #FF6B35` (different shade). Delete its local var block and apply the same token mapping as Home.vue.

Special colors in Process.vue:
```css
/* Old */
#FF6B35 → var(--md-primary)
#1A936F → var(--md-success)
#C5283D → var(--md-error)
#FFE0D6 → var(--md-warning-container)
```

### 5. All other views (MainView, SimulationView, InteractionView, etc.)

Each has the same pattern of inline hex colors. Apply mapping table. Key substitutions:
```css
#EAEAEA, #E0E0E0 → var(--md-outline-variant)
#F5F5F5          → var(--md-surface-container-low)
#000, #000000    → var(--md-on-surface)
#FFF, #ffffff    → var(--md-surface-container-lowest)
#999             → var(--md-outline)
#666             → var(--md-on-surface-variant)
#FF5722          → var(--md-warning)
#4CAF50          → var(--md-success)
#F44336          → var(--md-error)
```

### 6. DESIGN.md "No-Line" Rule enforcement

Per DESIGN.md: **1px solid borders are strictly prohibited.**

Find all 1px solid borders:
```bash
grep -rn "border.*1px.*solid" frontend/src/views/ frontend/src/App.vue
```

For each match:
- If it's a section separator → **remove the border entirely**, ensure adjacent elements use different surface-tier backgrounds
- If it's required for accessibility → replace with: `border: 1px solid var(--md-outline-variant)` (ghost border at 15% opacity)
- Exception: `border-left: 3px solid` accent rules → replace color with `var(--md-primary)`, keep the structural rule

## Todo List

- [ ] Run full hex audit grep across all view files
- [ ] Update `App.vue` scrollbar + font colors
- [ ] Update `Home.vue` — delete local CSS var block, replace all hex values
- [ ] Update `MainView.vue` — replace all hex values
- [ ] Update `SimulationView.vue` — replace all hex values
- [ ] Update `Process.vue` — delete local CSS var block, replace all hex values
- [ ] Update `InteractionView.vue` — replace all hex values
- [ ] Check `ReportView.vue` + `SimulationRunView.vue` — apply same pattern
- [ ] Audit and fix all `border: 1px solid` rules per No-Line Rule
- [ ] Run `npm run build` — verify no CSS errors
- [ ] Start dev server and visually inspect each view

## Success Criteria

- `grep -rn "#[0-9A-Fa-f]\{6\}" frontend/src/views/ frontend/src/App.vue` returns 0 branding hex values (semantic state colors like success/error may remain if not tokenized)
- All section borders removed or converted to ghost borders
- `npm run build` passes
- Colors visually match `docs/DESIGN.md` palette

## Risk Assessment

- **Medium risk** — large surface area, many files
- **Background shift vs border:** Removing borders requires ensuring adjacent elements have different `surface-container` tier backgrounds, otherwise sections lose visual separation — do a visual pass per view
- **Process.vue most complex** (~300+ lines of CSS with its own var system) — tackle last after patterns are established

## Next Steps

→ Phase 5 (Typography) can start in parallel after Phase 1 complete  
→ Phase 6 (Special Effects) starts after this phase
