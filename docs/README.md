# Sardines Project Documentation

Welcome to the Sardines project documentation. This directory contains comprehensive guides for developers, designers, and project stakeholders.

## Quick Start

**New to the project?** Start here:
1. Read [Project Overview & Requirements](./project-overview-pdr.md) — understand the vision, features, and success criteria
2. Review [Codebase Summary](./codebase-summary.md) — get familiar with the tech stack and project structure
3. Check [System Architecture](./system-architecture.md) — understand how components interact

## Documentation Index

### For Product Managers & Stakeholders
- **[Project Overview & PDR](./project-overview-pdr.md)** — Vision, features, requirements, and success metrics
- **[Development Roadmap](./development-roadmap.md)** — Milestones, phases, and progress tracking
- **[Project Changelog](./project-changelog.md)** — Release history and change documentation

### For Frontend Developers
- **[Codebase Summary](./codebase-summary.md)** — Project structure, technology stack, and directory organization
- **[Design Guidelines](./design-guidelines.md)** — Material Design 3 tokens, component patterns, and best practices
- **[Design Philosophy](./DESIGN.md)** — "Digital Architect" brand philosophy and design principles

### For Backend Developers
- **[System Architecture](./system-architecture.md)** — Layered architecture, API design, data models, and data flow
- **[Code Standards](./code-standards.md)** — Coding conventions, file organization, patterns, and best practices

### For All Developers
- **[Code Standards](./code-standards.md)** — File naming, code style, testing, git conventions, and tools
- **[System Architecture](./system-architecture.md)** — Complete technical design and integration points

---

## Key Concepts

### Technology Stack
- **Frontend:** Vue 3 + Vite + D3.js
- **Backend:** Flask + Python
- **Database:** PostgreSQL
- **Infrastructure:** Docker + Docker Compose
- **Design System:** Material Design 3 (MD3) with custom tokens

### Project Definition
Sardines is a social media opinion simulation system that predicts opinion dynamics through agent-based modeling and LLM analysis. Users build knowledge graphs, configure simulations, and generate data-driven reports about collective behavior.

### Brand Identity
- **Product Name:** Sardines (rebranded from MiroFish on 2026-04-24)
- **Tagline:** "Predict Everything"
- **Logo:** `frontend/src/assets/logo/sardines-logo.png`
- **Design Philosophy:** "Digital Architect" (proprietary, BK Global)

### Design System Highlights
- **Colors:** Primary #00658d, Secondary #4355b9, Tertiary #496800
- **Typography:** Manrope (display), Inter (body)
- **Spacing:** 8px base grid
- **Elevation:** Tonal layering (no hard borders), glassmorphism for floating elements
- **Components:** Gradient CTAs, surface-tier cards, no-line design

---

## Directory Structure

```
docs/
├── README.md                    # This file — navigation hub
├── DESIGN.md                    # Design philosophy ("Digital Architect")
├── codebase-summary.md          # Technology stack & project structure
├── design-guidelines.md         # MD3 token system & component patterns
├── project-overview-pdr.md      # Vision, requirements & success criteria
├── code-standards.md            # Coding conventions & best practices
├── system-architecture.md       # Technical architecture & data flow
├── development-roadmap.md       # Milestones, phases & progress
└── project-changelog.md         # Release history & changes
```

---

## How to Use This Documentation

### Reading Documentation
1. **Identify your role** (frontend dev, backend dev, product manager, etc.)
2. **Start with the relevant guide** (see index above)
3. **Follow cross-references** to related topics
4. **Refer to examples** for practical implementation patterns

### Keeping Documentation Current
- Update relevant doc when implementing features
- Keep version numbers consistent across documents
- Update changelog with every release
- Review roadmap monthly and update progress
- Link new documentation to existing docs for discoverability

### Contributing to Documentation
1. Read [Code Standards](./code-standards.md) for documentation guidelines
2. Write clear, concise documentation grounded in actual code
3. Include practical examples where helpful
4. Cross-reference related documents
5. Verify all code examples are executable
6. Submit documentation updates with code changes

---

## Key Files Referenced

| File | Purpose | Key Content |
|------|---------|-------------|
| `frontend/src/styles/design-tokens.css` | Design tokens (source of truth) | All colors, fonts, spacing, shadows |
| `frontend/src/assets/logo/sardines-logo.png` | Brand logo | PNG, used in navbar and marketing |
| `backend/app/api/` | API blueprints | Flask route definitions |
| `backend/app/services/` | Business logic | Core domain services |
| `backend/app/models/` | Data models | Project, Graph, SimulationRun, Report |
| `locales/*.json` | Multi-language strings | English, Vietnamese, Simplified Chinese |

---

## Useful Commands

### Frontend
```bash
npm run dev          # Start Vite dev server (localhost:5173)
npm run build        # Build for production
npm run preview      # Preview production build
```

### Backend
```bash
python run.py        # Start Flask development server
flask shell          # Interactive Python shell with app context
```

### Docker
```bash
docker-compose up    # Start all services
docker-compose down  # Stop all services
```

---

## Getting Help

### Common Questions
- **"Where do I find the API documentation?"** → See [System Architecture](./system-architecture.md) API section
- **"How do I use design tokens in Vue?"** → See [Design Guidelines](./design-guidelines.md) CSS Tokens section
- **"What's the database schema?"** → See [System Architecture](./system-architecture.md) Data Access Layer
- **"How do I add a new language?"** → See [Codebase Summary](./codebase-summary.md) Multi-Language Support
- **"What are the performance targets?"** → See [Project Overview](./project-overview-pdr.md) Non-Functional Requirements

### Contact
For documentation issues or improvements, refer to AGENTS.md for team contact information.

---

## Version & Status

**Last Updated:** 2026-04-24
**Documentation Version:** 1.0
**Project Version:** 0.2.0 (Sardines, v0.2.0)
**Build Status:** ✓ Production-ready (Vite build passes)

---

## Document Timeline

| Document | Created | Last Updated | Status |
|----------|---------|--------------|--------|
| DESIGN.md | 2026-03-20 | 2026-04-24 | Current |
| codebase-summary.md | 2026-04-24 | 2026-04-24 | Current |
| design-guidelines.md | 2026-04-24 | 2026-04-24 | Current |
| project-overview-pdr.md | 2026-04-24 | 2026-04-24 | Current |
| code-standards.md | 2026-04-24 | 2026-04-24 | Current |
| system-architecture.md | 2026-04-24 | 2026-04-24 | Current |
| development-roadmap.md | 2026-04-24 | 2026-04-24 | Current |
| project-changelog.md | 2026-04-24 | 2026-04-24 | Current |

---

**Ready to dive in? Start with the [Project Overview](./project-overview-pdr.md).**
