# Phase 3 — Brand Rename

**Context:** [plan.md](./plan.md)

## Overview

- **Priority:** P1
- **Status:** Pending
- **Effort:** ~1.5h
- Rename "MiroFish" → "Sardines" across all text surfaces: locale files, package.json, HTML meta, and all Vue view nav-brand elements.

## Key Insights

- Only **3 locale files** exist: `en.json`, `vi.json`, `zh.json` (not 8 as originally estimated)
- Brand strings in locale files (from `en.json` audit):
  - `meta.title`: `"MiroFish - Predict Everything"` → `"Sardines - Predict Everything"`
  - `meta.description`: `"MiroFish - Social Media Opinion Simulation System"` → `"Sardines - Social Media Opinion Simulation System"`
  - `home.heroDescBrand`: `"MiroFish"` → `"Sardines"`
  - `home.engineBadge`: `"Engine: MiroFish-V1.0"` → `"Engine: Sardines-V1.0"`
  - `home.roundsConfigDesc`: contains `"MiroFish"` in description text → replace inline
  - `report.reportAgentDesc`: contains `"MiroFish's"` → replace with `"Sardines'"`
- **Nav brand text**: All Vue views display `"MIROFISH"` in a `.nav-brand` or `.brand` element — must update to `"SARDINES"`
- **Coordination warning**: Translation plan (260423-1508) also modifies `vi.json` — run this phase AFTER translation plan completes, or ensure brand keys are re-applied last

## Files to Modify

- `locales/en.json` — all "MiroFish" occurrences
- `locales/vi.json` — all "MiroFish" occurrences
- `locales/zh.json` — all "MiroFish" / "MiroFish" occurrences
- `package.json` (root) — `name`, `description`
- `frontend/index.html` — `<title>` tag
- `frontend/src/views/Home.vue` — nav brand text, GitHub link
- `frontend/src/views/MainView.vue` — nav brand text
- `frontend/src/views/SimulationView.vue` — nav brand text
- `frontend/src/views/Process.vue` — nav brand text
- `frontend/src/views/InteractionView.vue` — nav brand text
- Check also: `frontend/src/views/ReportView.vue`, `SimulationRunView.vue`

## Implementation Steps

### 1. Locale files — en.json

Search all occurrences of "MiroFish" in `locales/en.json` and replace:

| Key | Old | New |
|---|---|---|
| `meta.title` | `MiroFish - Predict Everything` | `Sardines - Predict Everything` |
| `meta.description` | `MiroFish - Social Media Opinion Simulation System` | `Sardines - Social Media Opinion Simulation System` |
| `home.heroDescBrand` | `MiroFish` | `Sardines` |
| `home.engineBadge` | `Engine: MiroFish-V1.0` | `Engine: Sardines-V1.0` |
| `home.roundsConfigDesc` | `...MiroFish auto-plans...` | `...Sardines auto-plans...` |
| `report.reportAgentDesc` | `...MiroFish's complete memory` | `...Sardines' complete memory` |

Use Grep to find any additional occurrences: `grep -n "MiroFish" locales/en.json`

### 2. Locale files — vi.json and zh.json

Apply same pattern. For `zh.json` the brand name "MiroFish" may appear as-is (English) or in Chinese context. Search:
```bash
grep -n "MiroFish" locales/zh.json
grep -n "MiroFish" locales/vi.json
```

### 3. Root package.json

```json
{
  "name": "sardines",
  "description": "Sardines - Social Media Opinion Simulation System"
}
```

### 4. frontend/index.html — title tag

```html
<title>Sardines - Predict Everything</title>
```

### 5. Vue view nav brand text

In each file, find the element rendering brand name. Typical pattern:
```html
<div class="nav-brand">MIROFISH</div>
<!-- or -->
<span class="brand">MIROFISH</span>
```

Replace with:
```html
<div class="nav-brand">SARDINES</div>
```

Files to update: `Home.vue`, `MainView.vue`, `SimulationView.vue`, `Process.vue`, `InteractionView.vue` — plus any remaining views found via grep.

Verify all views: `grep -rn "MIROFISH\|MiroFish" frontend/src/views/`

### 6. Home.vue GitHub link

```html
<!-- Current -->
<a href="https://github.com/666ghj/MiroFish" ...>

<!-- Update to project repo if available, or remove the link -->
<a href="https://github.com/your-org/sardines" ...>
```

> If the correct GitHub URL is unknown, remove the link or point to the org root.

## Todo List

- [ ] `grep -rn "MiroFish" locales/` — full audit before editing
- [ ] Update `locales/en.json` — all 6 occurrences
- [ ] Update `locales/vi.json` — all occurrences
- [ ] Update `locales/zh.json` — all occurrences
- [ ] Update `package.json` — name + description
- [ ] Update `frontend/index.html` — title tag
- [ ] Update nav brand in: Home.vue, MainView.vue, SimulationView.vue, Process.vue, InteractionView.vue
- [ ] Check ReportView.vue + SimulationRunView.vue for brand text
- [ ] Update GitHub link in Home.vue
- [ ] Final verify: `grep -rn "MiroFish\|MIROFISH" frontend/src/ locales/` → 0 results

## Success Criteria

- `grep -rn "MiroFish\|MIROFISH" frontend/src/ locales/` returns 0 matches
- All locale meta.title keys read "Sardines - ..."
- All nav-brand elements display "SARDINES"
- `npm run build` passes

## Risk Assessment

- **Low risk** — text-only changes, no logic impact
- **Coordination risk (medium):** Translation plan also edits vi.json — if run in wrong order, brand keys revert. Mitigation: run translation plan first, then this phase.

## Next Steps

→ Can run in parallel with Phase 1 and Phase 2  
→ Phase 4 starts after Phase 1 completes
