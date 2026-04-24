# Codebase Summary

## Project: Sardines

**Description:** Sardines is a social media opinion simulation system that predicts opinion dynamics and collective behavior on social media platforms.

**Previous Name:** MiroFish (rebranded to Sardines on 2026-04-24)

---

## Technology Stack

### Frontend
- **Framework:** Vue 3 (Composition API)
- **Build Tool:** Vite 7.2.4
- **Routing:** Vue Router 4.6.3
- **State Management:** Vue I18n 11.3.0 (localization)
- **HTTP Client:** Axios 1.14.0
- **Data Visualization:** D3 7.9.0
- **Typography:** Manrope (display), Inter (body), Noto Sans SC (CJK)
- **Design System:** Material Design 3 (MD3) with custom tokens via CSS variables
- **Styling:** CSS3 (custom properties, glassmorphism, gradients)

### Backend
- **Framework:** Flask (Python)
- **Language:** Python 3.x
- **Database:** PostgreSQL (via models and ORM patterns)
- **Key Services:**
  - Graph building and management
  - Simulation configuration and execution
  - Report generation
  - Ontology normalization
  - LLM integration (graph memory, entity extraction)
  - IPC-based simulation runner coordination

### Infrastructure
- **Containerization:** Docker, Docker Compose
- **Package Management:** npm (frontend), pip (backend)

---

## Project Structure

```
.
├── frontend/                          # Vue 3 SPA
│   ├── src/
│   │   ├── api/                       # API client modules
│   │   ├── assets/logo/               # Brand assets (sardines-logo.png)
│   │   ├── components/                # Vue components
│   │   │   ├── GraphPanel.vue
│   │   │   ├── HistoryDatabase.vue
│   │   │   ├── LanguageSwitcher.vue
│   │   │   ├── Step1GraphBuild.vue
│   │   │   ├── Step2EnvSetup.vue
│   │   │   ├── Step3Simulation.vue
│   │   │   ├── Step4Report.vue
│   │   │   └── Step5Interaction.vue
│   │   ├── i18n/                      # Internationalization setup
│   │   ├── router/                    # Vue Router configuration
│   │   ├── store/                     # State management (Pinia-like patterns)
│   │   ├── styles/                    # Global styles
│   │   │   └── design-tokens.css      # MD3 CSS tokens (NEW)
│   │   ├── views/                     # Page components
│   │   │   ├── Home.vue
│   │   │   ├── MainView.vue
│   │   │   ├── Process.vue
│   │   │   ├── SimulationView.vue
│   │   │   ├── SimulationRunView.vue
│   │   │   ├── ReportView.vue
│   │   │   └── InteractionView.vue
│   │   ├── App.vue                    # Root component
│   │   └── main.js                    # Entry point
│   ├── index.html                     # HTML template (title: "Sardines - Predict Everything")
│   ├── package.json                   # Frontend dependencies
│   └── vite.config.js                 # Vite configuration
│
├── backend/                           # Flask API server
│   ├── app/
│   │   ├── api/                       # Flask blueprints (routes)
│   │   │   ├── graph.py
│   │   │   ├── report.py
│   │   │   └── simulation.py
│   │   ├── models/                    # Data models
│   │   │   ├── project.py
│   │   │   └── task.py
│   │   ├── services/                  # Business logic
│   │   │   ├── graph_builder.py
│   │   │   ├── graph_provider/        # Multiple graph backends
│   │   │   ├── report_agent.py        # LLM-based report generation
│   │   │   ├── simulation_*.py        # Simulation orchestration
│   │   │   ├── text_processor.py
│   │   │   ├── zep_*.py               # Zep memory integration
│   │   │   └── ... (other services)
│   │   ├── utils/                     # Utilities
│   │   │   ├── llm_client.py
│   │   │   ├── locale.py
│   │   │   ├── logger.py
│   │   │   └── ... (other utils)
│   │   └── config.py                  # Configuration management
│   ├── scripts/                       # CLI tools
│   ├── tests/                         # Unit tests
│   ├── run.py                         # Flask app entry point
│   ├── requirements.txt               # Python dependencies
│   └── pyproject.toml                 # Project metadata
│
├── locales/                           # Multi-language support
│   ├── en.json                        # English strings
│   ├── vi.json                        # Vietnamese strings
│   ├── zh.json                        # Simplified Chinese strings
│   └── languages.json                 # Language metadata
│
├── docs/                              # Project documentation
│   ├── DESIGN.md                      # Design system (BK Global "Digital Architect")
│   ├── codebase-summary.md            # This file
│   ├── design-guidelines.md           # MD3 implementation guide
│   ├── project-overview-pdr.md        # Project overview & requirements
│   ├── code-standards.md              # Coding standards
│   ├── system-architecture.md         # System design & data flow
│   ├── development-roadmap.md         # Milestones and progress
│   └── project-changelog.md           # Detailed change history
│
├── docker-compose.yml                 # Container orchestration
├── Dockerfile                         # Backend image definition
├── package.json                       # Root-level scripts
├── README.md                          # Project README (English)
├── README-VI.md                       # Project README (Vietnamese)
├── README-ZH.md                       # Project README (Chinese)
└── ... (configuration, license)
```

---

## Key Features

### 1. Opinion Simulation Engine
- Multi-graph support (local Graphiti or Zep Cloud)
- Configurable agent-based simulation
- Opinion dynamics modeling
- Social media behavior prediction

### 2. Multi-Language Support
- English, Vietnamese, Simplified Chinese
- Locale-aware UI and content
- Dynamic language switching

### 3. Visual Analysis
- Graph visualization (D3)
- Interactive simulation controls
- Real-time report generation

### 4. LLM Integration
- Claude API for report generation
- Memory integration via Zep
- Entity extraction and normalization
- Ontology generation

### 5. Design System (MD3 + "Digital Architect")
- Glassmorphism headers
- Gradient CTAs
- Token-based theming
- No-line design (color separation only)
- Consistent typography (Manrope + Inter)
- 8px grid alignment

---

## Recent Changes (Sardines Rebrand)

**Completed: 2026-04-24**

### Frontend
- Brand rename: MiroFish → Sardines
- New logo: `frontend/src/assets/logo/sardines-logo.png`
- Updated title in `frontend/index.html`: "Sardines - Predict Everything"
- Implemented MD3 design tokens in `frontend/src/styles/design-tokens.css`
- Updated all views to use token-based styling (glassmorphism, gradients, surface tiers)
- Applied consistent MD3 typography and color system

### Localization
- Updated all locale files (en.json, vi.json, zh.json) with Sardines branding

### Verification
- Vite build passes without errors
- All components refactored to use design tokens
- No hardcoded colors or fonts in component styles

---

## Dependencies Overview

### Frontend (npm)
| Package | Version | Purpose |
|---------|---------|---------|
| vue | ^3.5.24 | UI framework |
| vite | ^7.2.4 | Build tooling |
| vue-router | ^4.6.3 | Client-side routing |
| vue-i18n | ^11.3.0 | Internationalization |
| axios | ^1.14.0 | HTTP client |
| d3 | ^7.9.0 | Data visualization |

### Backend (pip)
Key dependencies managed via `requirements.txt`:
- Flask (web framework)
- PostgreSQL driver (psycopg2)
- Zep Python client (memory + retrieval)
- LLM clients (Anthropic Claude, etc.)
- Graph libraries (NetworkX for graph analysis)

---

## Development Workflow

1. **Frontend Development:** `npm run dev` (Vite dev server with HMR)
2. **Backend Development:** Python Flask with auto-reload
3. **Docker:** Full stack via `docker-compose up`
4. **Building:** `npm run build` (frontend), Flask production wsgi
5. **Localization:** Edit locale JSON files; reload browser for i18n updates

---

## Design System Implementation

The codebase follows the **"Digital Architect"** design philosophy (see `docs/DESIGN.md`):

- **Colors:** Primary (#00658d), Secondary (#4355b9), Tertiary (#496800)
- **Surfaces:** 5-tier container system (lowest → highest) for depth
- **Typography:** Manrope (display/headlines), Inter (body)
- **Elevation:** Tonal layering + ambient shadows (no hard borders)
- **Components:** Gradient buttons, surface-based cards, glass navigation

All color, typography, and spacing values are defined as CSS custom properties in `frontend/src/styles/design-tokens.css` for maintainability.

---

## Known Limitations & TODOs

- Backend database schema not fully documented (see models/)
- Simulation runner IPC protocol could use formalization
- LLM prompt engineering parameters scattered across service files

---

## Contact & Attribution

- **Project:** Sardines (Social Media Opinion Simulation)
- **Brand by:** BK Global
- **Design System:** "Digital Architect" (proprietary)
- **Maintained by:** (Project team contact info in AGENTS.md)

For detailed design guidelines, see `docs/DESIGN.md` and `docs/design-guidelines.md`.
For architectural details, see `docs/system-architecture.md`.
