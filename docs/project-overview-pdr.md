# Project Overview & Product Development Requirements (PDR)

## Executive Summary

**Sardines** is a web-based social media opinion simulation system that uses graph-based agent models and LLM integration to predict opinion dynamics and collective behavior on social platforms. Users can construct knowledge graphs, configure simulation parameters, run multi-agent simulations, and generate data-driven reports about how opinions evolve.

**Rebranded from:** MiroFish (as of 2026-04-24)

**Current Version:** v0.2.0 (Production-Ready, MD3 Design System)

---

## Vision & Strategic Goals

### Vision Statement
To empower researchers, analysts, and platforms to understand and predict social media opinion dynamics through agent-based simulation and AI-driven analysis.

### Strategic Goals
1. **Accuracy:** Produce reliable opinion simulation predictions validated against real social media datasets
2. **Usability:** Make opinion simulation accessible to non-technical domain experts
3. **Scalability:** Support large-scale simulations (100k+ agents, complex graphs)
4. **Transparency:** Provide explainable AI outputs with clear reasoning trails
5. **Modularity:** Support pluggable graph backends and simulation engines

---

## Product Definition

### Core Value Proposition
Sardines enables users to:
1. Build knowledge graphs of entities and relationships
2. Configure agent behavior and opinion initialization
3. Simulate opinion evolution under various scenarios
4. Analyze results through interactive visualizations
5. Export findings as professional reports

### Target Users
- **Primary:** Academic researchers studying social dynamics
- **Secondary:** Platform analysts, content strategists, misinformation researchers
- **Tertiary:** Data scientists exploring opinion modeling

### Key Differentiators
- Multi-graph backend support (local + cloud)
- LLM-powered report generation
- Interactive, real-time simulation controls
- Multi-language interface (EN, VI, ZH)
- Enterprise-ready MD3 design system

---

## Functional Requirements

### F1: Graph Management
**Description:** Users can create, edit, and manage knowledge graphs representing entities and relationships.

**Requirements:**
- Create new graphs from scratch or templates
- Import graphs from external formats (JSON, GraphML)
- Visualize graph structure (nodes, edges, attributes)
- Edit nodes and edges with custom properties
- Delete/archive graphs
- Version control for graph history

**Success Criteria:**
- Users can create and visualize a 1000-node graph in <30 seconds
- Graph import/export maintains data integrity (100% round-trip accuracy)
- UI remains responsive for graphs up to 10,000 nodes

### F2: Simulation Configuration
**Description:** Users configure simulation parameters to define agent behavior and opinion dynamics.

**Requirements:**
- Define initial opinion distribution across agents
- Configure opinion dynamics parameters (convergence rates, influence weights)
- Set simulation duration and step size
- Define stopping conditions and thresholds
- Save and load configuration templates
- Validate configuration before execution

**Success Criteria:**
- Configuration UI supports 50+ distinct parameters
- Validation prevents invalid parameter combinations
- Users can run simulation in <5 minutes for typical graphs (1000 nodes, 100 steps)

### F3: Simulation Execution
**Description:** Run agent-based opinion simulations with real-time progress tracking.

**Requirements:**
- Execute simulations with configurable backend (Graphiti, Zep)
- Track simulation progress in real-time
- Support parallel simulation runs
- Handle interruption and resumption
- Capture detailed step-by-step simulation logs
- Store simulation results for analysis

**Success Criteria:**
- Simulations complete within user-defined time budgets
- Real-time progress updates to UI (latency <2 seconds)
- Support at least 10 parallel simulations on standard hardware
- Ability to resume interrupted simulations with state preservation

### F4: Results Analysis & Visualization
**Description:** Provide interactive tools to explore and understand simulation results.

**Requirements:**
- Visualize opinion trajectories over time
- Filter and explore results by agent, opinion dimension, time range
- Compare multiple simulation runs
- Export analysis-ready datasets
- Interactive graph state exploration at any time step

**Success Criteria:**
- Render complex visualizations (1000+ data points) in <2 seconds
- Support filtering by 20+ dimensions without UI lag
- Export formats: CSV, JSON, Parquet

### F5: Report Generation
**Description:** Generate professional analysis reports powered by LLM insights.

**Requirements:**
- Auto-generate narrative reports with key findings
- Include visualizations, statistics, and recommendations
- Support custom report templates
- Export to PDF, HTML, Markdown
- Scheduled report generation
- Report archival and retrieval

**Success Criteria:**
- Reports generate in <30 seconds for typical simulations
- LLM summaries accurately reflect simulation data (validated against outputs)
- PDF export maintains visual fidelity

### F6: Multi-Language Support
**Description:** Provide interface and content in multiple languages.

**Requirements:**
- Support English, Vietnamese, Simplified Chinese
- Runtime language switching without reload
- Consistent terminology across all languages
- Culture-appropriate date/time/number formatting

**Success Criteria:**
- 100% UI string coverage in all supported languages
- No hardcoded strings in Vue components
- Language selection persisted across sessions

### F7: User Authentication & Authorization
**Description:** Manage user identity and access control (future enterprise feature).

**Requirements:**
- User registration and login
- Session management with tokens
- Role-based access control (RBAC) — future phase
- Multi-tenancy support — future phase
- Audit logging of all actions

**Success Criteria:**
- Session tokens expire after 24 hours
- All user actions logged with user ID and timestamp
- Access control enforced at API level

---

## Non-Functional Requirements

### NF1: Performance
- **Frontend Load:** Page load <2 seconds (lighthouse metric)
- **API Response Time:** 95th percentile <500ms
- **Simulation Speed:** >1000 agents/step on standard hardware
- **Scalability:** Support 100k+ agent simulations

### NF2: Reliability
- **Uptime:** 99.5% during business hours
- **Data Integrity:** Zero data loss for completed simulations
- **Error Recovery:** Graceful degradation with user notifications
- **Backup:** Daily automated backups

### NF3: Security
- **Authentication:** Token-based (JWT or similar)
- **Authorization:** Role-based access control
- **Data Protection:** Encryption at rest (sensitive data) and in transit (HTTPS)
- **Input Validation:** All user inputs sanitized and validated
- **API Security:** Rate limiting, CORS, CSRF protection

### NF4: Accessibility
- **Compliance:** WCAG 2.1 AA standard
- **Keyboard Navigation:** All features accessible via keyboard
- **Screen Reader:** Compatible with NVDA, JAWS, VoiceOver
- **Color Contrast:** Minimum 4.5:1 for text

### NF5: Usability
- **Learning Curve:** First-time users complete workflow in <30 minutes
- **Internationalization:** Fully localized for 3+ languages
- **Mobile Responsiveness:** Functional on 375px+ width screens
- **Help & Documentation:** Contextual help, user guide, API docs

### NF6: Maintainability
- **Code Quality:** Test coverage ≥80% for critical paths
- **Documentation:** API docs, code comments, user guide
- **Monitoring:** Centralized logging and error tracking
- **CI/CD:** Automated testing and deployment

---

## Architectural Constraints

### Technology Constraints
1. **Frontend:** Vue 3 (established codebase)
2. **Backend:** Flask/Python (established codebase)
3. **Database:** PostgreSQL (current infrastructure)
4. **Deployment:** Docker containerization

### Design Constraints
1. **Design System:** Material Design 3 (MD3) with "Digital Architect" philosophy
2. **Branding:** Sardines brand (updated 2026-04-24)
3. **Token-Based Styling:** All colors, fonts, spacing via CSS custom properties
4. **No Hardcoded Values:** Maintain centralized design token system

### Scalability Constraints
1. **Simulation Engine:** Backend must support horizontal scaling via IPC
2. **Graph Storage:** PostgreSQL with efficient indexing for relationship queries
3. **API Rate Limits:** Per-user rate limiting to prevent abuse
4. **Concurrent Sessions:** Support 100+ concurrent simulation runs

---

## Acceptance Criteria (Definition of Done)

### For All Features
1. [ ] Code passes linting and compilation
2. [ ] Unit tests written with ≥80% coverage
3. [ ] Integration tests pass on staging environment
4. [ ] Manual testing completed on all supported browsers
5. [ ] Accessibility audit (WCAG AA minimum)
6. [ ] Documentation updated (code comments, user guide, API docs)
7. [ ] Performance benchmarks meet targets
8. [ ] Security review completed for data handling
9. [ ] Production deployment verified
10. [ ] Changelog entry added

### For Frontend Changes
1. [ ] Vue components use design tokens (no hardcoded values)
2. [ ] Responsive design tested on mobile (375px+)
3. [ ] Internationalization strings added to all locale files
4. [ ] Components support keyboard navigation

### For Backend Changes
1. [ ] API changes documented in OpenAPI spec
2. [ ] Database migrations included (if applicable)
3. [ ] Error responses follow standard format
4. [ ] Input validation implemented
5. [ ] Performance tested with realistic data volumes

---

## Success Metrics & KPIs

### User Engagement
- **Daily Active Users:** Target 50+ by Q3 2026
- **Session Duration:** Average >20 minutes
- **Feature Usage:** >80% of users use report export feature

### Product Quality
- **Bug Detection:** <5 critical bugs in production per month
- **Crash Rate:** <0.1% of sessions
- **API Error Rate:** <1% of requests
- **Page Load Time:** 95th percentile <2 seconds

### Developer Productivity
- **Feature Velocity:** 2-3 major features per quarter
- **Deployment Frequency:** Weekly deployments
- **Time to Resolve Issues:** <48 hours for critical issues
- **Test Coverage:** Maintain ≥80% for critical paths

### Business Metrics
- **User Acquisition Cost:** TBD (research phase)
- **Retention Rate:** Target 70% 30-day retention
- **Time to Value:** First meaningful simulation in <1 hour
- **NPS (Net Promoter Score):** Target >50

---

## Risk Assessment

### High-Risk Areas

**R1: Simulation Performance at Scale**
- **Risk:** Simulations with 100k+ agents may exceed time budgets
- **Mitigation:** Performance optimization (Phase 5), parallel execution, caching
- **Owner:** Backend lead

**R2: LLM Integration Reliability**
- **Risk:** LLM API downtime impacts report generation
- **Mitigation:** Fallback report templates, error handling, retry logic
- **Owner:** Backend lead

**R3: Database Scalability**
- **Risk:** Large graph datasets may slow queries
- **Mitigation:** Index optimization, caching layer, read replicas
- **Owner:** DevOps/Backend

### Medium-Risk Areas

**R4: Multi-Tenancy Complexity**
- **Risk:** Enterprise feature introduces architectural complexity
- **Mitigation:** Phase implementation, thorough testing, gradual rollout
- **Owner:** Architecture lead

**R5: Localization Maintenance**
- **Risk:** Maintaining 3+ languages increases QA burden
- **Mitigation:** Automated translation validation, community volunteers
- **Owner:** Content/QA

---

## Dependencies

### External Dependencies
- **Claude API:** Report generation
- **Zep Cloud:** Optional graph memory backend
- **Google Fonts:** Typography (Manrope, Inter, Noto Sans SC)
- **D3.js:** Visualization library

### Internal Dependencies
- **Frontend ← Backend:** REST API contracts
- **Backend ← Database:** PostgreSQL schema evolution
- **All Components ← Design Tokens:** CSS custom properties system

### Team Dependencies
- Design leadership for design system updates
- Product management for feature prioritization
- DevOps for infrastructure and deployment

---

## Timeline & Milestones

| Milestone | Target Date | Status |
|-----------|-------------|--------|
| v0.1.0 (MiroFish Launch) | 2026-03-20 | ✓ Complete |
| v0.2.0 (Sardines Rebrand + MD3) | 2026-04-24 | ✓ Complete |
| v1.0.0 (Core Features Stable) | 2026-06-30 | Planned |
| v1.1.0 (Advanced Simulation) | 2026-08-31 | Planned |
| v2.0.0 (Enterprise Features) | 2027-01-31 | Planned |

---

## Governance & Decision-Making

### Change Control
- **Minor Changes:** Developer discretion + code review
- **Medium Changes:** Product + Engineering alignment
- **Major Changes:** Leadership approval + stakeholder communication
- **Design Changes:** Design review + brand consistency check

### Documentation Updates
- This PDR reviewed quarterly
- Design guidelines updated with each design system change
- Changelog maintained for every release
- Roadmap updated weekly during active development

---

## References

- **Design System:** `docs/DESIGN.md`, `docs/design-guidelines.md`
- **Codebase Structure:** `docs/codebase-summary.md`
- **Development Roadmap:** `docs/development-roadmap.md`
- **Changelog:** `docs/project-changelog.md`
- **Team Contact:** `AGENTS.md`

---

**Document Version:** 1.0
**Last Updated:** 2026-04-24
**Next Review:** 2026-05-22 (quarterly)
