# Project Changelog

All notable changes to the Sardines project are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/) conventions.

---

## [Unreleased]

### Planned
- Backend API documentation (OpenAPI/Swagger)
- Enhanced simulation configuration UI
- Advanced filtering and export options for reports

---

## [v0.2.0] — 2026-04-24 - Sardines Rebrand & MD3 Design System

### Added
- **Brand Identity:** Full rebrand from MiroFish to Sardines
  - New logo asset: `frontend/src/assets/logo/sardines-logo.png`
  - Updated product title: "Sardines - Predict Everything"
  - New meta description in HTML head

- **Design System (MD3):**
  - Centralized design tokens: `frontend/src/styles/design-tokens.css`
  - Material Design 3 color system with 5-tier surface hierarchy
  - Typography scale with Manrope (display) and Inter (body)
  - Spacing system based on 8px grid
  - Glassmorphism effects for floating elements
  - Gradient CTAs (135° linear-gradient from primary to primary-container)
  - Ambient shadow system (no hard borders)

- **Component Refinements:**
  - All frontend views refactored to use design tokens
  - Glassmorphism headers in navigation
  - Gradient button CTAs
  - Surface-tier based card nesting (no border dividers)
  - Updated input field focus states (bottom-border only)
  - Consistent typography hierarchy

- **Documentation:**
  - `docs/codebase-summary.md` — Project structure and technology stack overview
  - `docs/design-guidelines.md` — Comprehensive MD3 token system guide
  - Enhanced `docs/DESIGN.md` with token system details

### Changed
- Updated `frontend/index.html` title and meta tags
- Updated `frontend/package.json` metadata (name: "frontend")
- Refactored all Vue component styles to use CSS custom properties
- Localization strings updated to reflect "Sardines" brand (en.json, vi.json, zh.json)
- All hardcoded colors and fonts replaced with token variables

### Verified
- `vite build` passes with zero errors
- All components render correctly with new design tokens
- Brand consistency across all views and language variants

---

## [v0.1.0] — 2026-03-20 - Initial MiroFish Release

### Added
- **Frontend (Vue 3 SPA):**
  - Multi-step simulation workflow (5-step process)
  - Graph visualization and interaction panels (D3-based)
  - Real-time simulation controls
  - Report generation and display
  - Simulation interaction interface
  - Language switcher (EN, VI, ZH)

- **Backend (Flask API):**
  - Graph building and management services
  - Simulation orchestration with IPC coordination
  - Report generation with LLM integration (Claude)
  - Ontology normalization and entity extraction
  - Zep memory and knowledge graph integration
  - Multiple graph provider backends (Graphiti, Zep Cloud)

- **Infrastructure:**
  - Docker and Docker Compose support
  - Environment-based configuration
  - Internationalization (i18n) for 3 languages

- **Initial Features:**
  - Project creation and management
  - Social media opinion simulation
  - Graph-based entity relationship modeling
  - Multi-language UI and content localization
  - Export and report capabilities

### Notes
- Original branding: "MiroFish" (Social Media Opinion Simulation System)
- Base tech stack: Vue 3, Vite, Flask, PostgreSQL
- Initial logo assets in `static/image/`

---

## Version History Summary

| Version | Date | Focus | Status |
|---------|------|-------|--------|
| v0.2.0 | 2026-04-24 | Sardines rebrand + MD3 design system | Released |
| v0.1.0 | 2026-03-20 | Initial MiroFish release | Superseded |

---

## Breaking Changes

### v0.2.0 → Future Versions
- Logo asset path changed: `MiroFish_logo_*.jpeg` → `sardines-logo.png`
- No API breaking changes (backend routes remain compatible)
- Frontend styling now exclusively token-based (legacy hardcoded values removed)

---

## Migration Notes

### For Frontend Developers
1. All new components must use CSS custom properties from `frontend/src/styles/design-tokens.css`
2. No hardcoded colors, fonts, or spacing values in component styles
3. Refer to `docs/design-guidelines.md` for token usage patterns

### For Content Creators
1. Update references from "MiroFish" to "Sardines" in documentation and marketing
2. Use new logo from `frontend/src/assets/logo/sardines-logo.png`
3. Update meta descriptions and page titles to use "Sardines - Predict Everything"

---

## Known Issues & Limitations

### Design System
- CSS custom properties not supported in IE11 (edge case, not targeted)
- Glass morphism effects require modern browsers (Chromium 88+, Safari 15.1+, Firefox 103+)

### Simulation Engine
- Backend database schema documentation pending
- Simulation runner IPC protocol not formally specified

### Backend
- LLM prompt engineering parameters scattered across service files (consolidation pending)

---

## Contributors & Attribution

- **Brand:** BK Global
- **Design System:** "Digital Architect" proprietary design philosophy
- **Product:** Sardines Team

---

## How to Report Issues

For bugs, feature requests, or documentation updates:
1. Check existing issues in the project repository
2. Provide clear reproduction steps
3. Include relevant logs and screenshots
4. Reference the affected version number

---

## License

See LICENSE file in the project root.

---

**Last Updated:** 2026-04-24
