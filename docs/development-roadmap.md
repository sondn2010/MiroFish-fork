# Development Roadmap

## Overview

This document outlines the planned milestones and current progress for the Sardines project. The roadmap is updated as work progresses and priorities may shift based on feedback and resource availability.

**Last Updated:** 2026-04-24

---

## Current Phase: v0.2 — Sardines Rebrand & Design System

### Status: COMPLETED ✓

**Dates:** 2026-04-20 → 2026-04-24

**Objectives:**
- [x] Rebrand product from MiroFish → Sardines
- [x] Implement Material Design 3 (MD3) design system
- [x] Create centralized design token system
- [x] Refactor all frontend components to use tokens
- [x] Update branding in all locales
- [x] Verify production build

**Deliverables:**
- New logo asset: `frontend/src/assets/logo/sardines-logo.png`
- Design tokens file: `frontend/src/styles/design-tokens.css`
- Updated HTML title: "Sardines - Predict Everything"
- Refactored all view components with MD3 styling
- Updated locale files (en.json, vi.json, zh.json)
- Design documentation: `docs/design-guidelines.md`
- Codebase documentation: `docs/codebase-summary.md`
- Changelog: `docs/project-changelog.md`

**Build Status:** ✓ Vite build passes with zero errors

---

## Phase 1: Core Simulation Engine Enhancement

### Status: PLANNED

**Target:** Q2-Q3 2026

**Objectives:**
- [ ] Formalize simulation runner IPC protocol
- [ ] Improve graph provider abstraction
- [ ] Add simulation parameter validation
- [ ] Enhance error handling and recovery
- [ ] Performance optimization for large graphs

**Deliverables:**
- Documented IPC protocol (specification)
- Enhanced graph provider interface
- Parameter validation layer
- Improved logging and diagnostics
- Performance benchmarks

**Dependencies:** None (can start immediately)

---

## Phase 2: Backend API Documentation & Standardization

### Status: PLANNED

**Target:** Q2 2026

**Objectives:**
- [ ] Generate OpenAPI/Swagger documentation
- [ ] Standardize API response formats
- [ ] Document all endpoints with examples
- [ ] Create API client SDK (TypeScript/Python)
- [ ] Add request/response validation

**Deliverables:**
- OpenAPI 3.0 specification
- Interactive API documentation
- TypeScript client library
- Python client library
- API testing suite

**Dependencies:** Core engine stable (Phase 1)

---

## Phase 3: Advanced Simulation Controls

### Status: PLANNED

**Target:** Q3 2026

**Objectives:**
- [ ] Enhanced parameter UI for simulation configuration
- [ ] Real-time simulation progress visualization
- [ ] A/B testing framework for comparing scenarios
- [ ] Batch simulation capabilities
- [ ] Historical simulation comparison

**Deliverables:**
- Advanced configuration panel
- Progress streaming UI
- Scenario comparison tools
- Batch job management
- Simulation history and versioning

**Dependencies:** Backend API standardization (Phase 2)

---

## Phase 4: Report Generation & Export

### Status: PLANNED

**Target:** Q3-Q4 2026

**Objectives:**
- [ ] Enhance report templates
- [ ] Add PDF export functionality
- [ ] Implement data export (CSV, JSON)
- [ ] Create custom report builder
- [ ] Add scheduling and email delivery

**Deliverables:**
- Multiple report templates
- PDF export service
- Data export formats
- Custom report UI
- Scheduled report jobs

**Dependencies:** Advanced simulation controls (Phase 3)

---

## Phase 5: Performance & Scalability

### Status: PLANNED

**Target:** Q4 2026

**Objectives:**
- [ ] Database query optimization
- [ ] Caching layer implementation
- [ ] Backend service scaling
- [ ] Frontend bundle size optimization
- [ ] Load testing and benchmarking

**Deliverables:**
- Performance baselines and targets
- Optimized queries and indexes
- Caching strategy documentation
- Optimized frontend bundles
- Load test reports

**Dependencies:** All previous phases stable

---

## Phase 6: Enterprise Features

### Status: PLANNED

**Target:** 2027 Q1+

**Objectives:**
- [ ] Multi-tenancy support
- [ ] Role-based access control (RBAC)
- [ ] Audit logging and compliance
- [ ] Advanced authentication (SSO, OAuth2)
- [ ] Data retention and archival policies

**Deliverables:**
- Tenant isolation architecture
- RBAC implementation
- Audit trail system
- SSO/OAuth2 integration
- Data lifecycle management

**Dependencies:** All core features stable and tested

---

## In-Progress Items

### Technical Debt
- [ ] Consolidate LLM prompt engineering parameters (currently scattered across service files)
- [ ] Formalize backend database schema documentation
- [ ] Add comprehensive API error codes documentation
- [ ] Create developer setup guide

### Documentation
- [x] Design system documentation
- [x] Codebase summary
- [x] Design guidelines
- [ ] API documentation
- [ ] Database schema documentation
- [ ] Deployment guide
- [ ] Troubleshooting guide

### Testing
- [ ] Expand unit test coverage
- [ ] Add integration tests for simulation workflow
- [ ] Add E2E tests for critical user paths
- [ ] Performance testing suite

---

## Completed Milestones

### ✓ v0.1.0 — Initial MiroFish Release (2026-03-20)
- Vue 3 frontend with 5-step workflow
- Flask backend with simulation engine
- Multi-language support (EN, VI, ZH)
- Docker containerization
- Basic graph visualization and reporting

### ✓ v0.2.0 — Sardines Rebrand & MD3 (2026-04-24)
- Complete brand identity update
- Material Design 3 implementation
- Centralized design tokens
- Production-ready styling
- Enhanced documentation

---

## Success Metrics

### Quality
- Test coverage: ≥80% for critical paths
- Build time: <5 minutes
- Performance: Page load <2 seconds, simulation <5 minutes for typical graphs

### User Experience
- Localization: 3+ languages fully supported
- Accessibility: WCAG 2.1 AA compliance
- Mobile responsiveness: All views functional on 375px+ screens

### Documentation
- API documentation: 100% endpoint coverage
- Code documentation: Inline comments for complex logic
- User guide: Step-by-step workflows documented

---

## Priority Matrix

| Phase | Priority | Effort | Impact | Status |
|-------|----------|--------|--------|--------|
| Rebrand & Design (v0.2) | P0 | 5 days | High | ✓ Done |
| Core Engine Enhancement (P1) | P0 | 10 days | High | Planned |
| API Documentation (P2) | P1 | 5 days | Medium | Planned |
| Advanced Controls (P3) | P1 | 10 days | Medium | Planned |
| Report Export (P4) | P2 | 7 days | Medium | Planned |
| Performance (P5) | P1 | 8 days | High | Planned |
| Enterprise (P6) | P2 | 20+ days | High | Future |

---

## Dependencies & Blockers

### Current Blockers
- None identified

### Known Dependencies
- Phase 2 depends on Phase 1 completion
- Phase 3 depends on Phase 2 completion
- Phase 4 depends on Phase 3 completion

---

## Resource Allocation

**Current Team:**
- Frontend: 1 developer
- Backend: 1 developer
- Design/Product: 1 role
- QA: As-needed

**Estimated Capacity:** 2 major features per quarter

---

## Communication & Updates

- **Status Updates:** Weekly during active development phases
- **Blockers:** Escalated immediately
- **Major Changes:** Discussed and documented in CLAUDE.md and this roadmap

---

## How to Contribute

1. Review current phase objectives
2. Check AGENTS.md for team contact information
3. Propose changes via pull request with detailed rationale
4. Discuss priority adjustments in team meetings

---

## Archive & Historical Context

- **Original Project:** MiroFish (Social Media Opinion Simulation)
- **Rebranding Date:** 2026-04-24
- **Design System:** "Digital Architect" (proprietary, BK Global)
- **Version History:** See `docs/project-changelog.md`

---

**Next Review:** 2026-05-22 (4 weeks)
