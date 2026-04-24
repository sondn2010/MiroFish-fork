# Phase 2 — Logo & Favicon

**Context:** [plan.md](./plan.md) | [DESIGN.md](../../docs/DESIGN.md)

## Overview

- **Priority:** P1
- **Status:** Pending
- **Effort:** ~30m
- Replace all logo image assets with the new Sardines logo (`docs/Logo.png`) and update all component references.

## Key Insights

- Source logo: `docs/Logo.png` — 4-color pinwheel (cyan, yellow, lime, royal blue). PNG only, no SVG.
- Current logo files: `frontend/src/assets/logo/MiroFish_logo_compressed.jpeg` + `MiroFish_logo_left.jpeg`
- Current favicon: `frontend/public/icon.png`
- Home.vue references `MiroFish_logo_left.jpeg` for hero display
- Other views (MainView, SimulationView, Process, etc.) do NOT display a logo image — only the nav brand text
- Risk: The new PNG has 4 colors at small favicon sizes (32×32) — may need to test readability

## Files to Modify

- `frontend/src/assets/logo/` — add `sardines-logo.png`
- `frontend/public/icon.png` — replace with new logo
- `frontend/src/views/Home.vue` — update logo `<img>` src path

## Implementation Steps

### 1. Copy logo to assets

```bash
cp docs/Logo.png frontend/src/assets/logo/sardines-logo.png
```

### 2. Replace favicon

```bash
cp docs/Logo.png frontend/public/icon.png
```

> Note: The source PNG is the same file used for both. The browser will downscale to 32×32. If the result looks muddy, use ImageMagick to resize: `magick docs/Logo.png -resize 64x64 frontend/public/icon.png`

### 3. Update Home.vue logo reference

Find in `frontend/src/views/Home.vue`:
```html
<img src="@/assets/logo/MiroFish_logo_left.jpeg" ...>
```
or the compressed variant. Replace `src` with:
```html
<img src="@/assets/logo/sardines-logo.png" ...>
```

Also update any `import` statement at the top of the `<script>` block if the logo is imported as a JS module.

### 4. (Optional) Remove old logo files

Once new files are in place and build passes, delete:
- `frontend/src/assets/logo/MiroFish_logo_compressed.jpeg`
- `frontend/src/assets/logo/MiroFish_logo_left.jpeg`

## Todo List

- [ ] Copy `docs/Logo.png` → `frontend/src/assets/logo/sardines-logo.png`
- [ ] Copy `docs/Logo.png` → `frontend/public/icon.png` (overwrite)
- [ ] Update `Home.vue` logo `<img>` src to `@/assets/logo/sardines-logo.png`
- [ ] Search all other views for logo references: `grep -r "MiroFish_logo\|logo_left\|logo_compressed" frontend/src/`
- [ ] Run `npm run build` — verify no broken asset imports
- [ ] Test favicon in browser (check at small sizes)
- [ ] Delete old JPEG logo files if build passes

## Success Criteria

- New logo renders in Home.vue hero section
- Browser tab shows new favicon
- No 404 errors for missing assets in build
- Old JPEG files removed

## Risk Assessment

- **Low risk** — asset swap only, no logic changes
- **Favicon clarity (medium):** 4-color abstract mark at 32×32 may look muddy → use ImageMagick resize if needed
- **CJK fallback:** No impact from logo change on fonts

## Next Steps

→ Can run in parallel with Phase 1 and Phase 3  
→ Phase 4 (color overhaul) starts after Phase 1 completes
