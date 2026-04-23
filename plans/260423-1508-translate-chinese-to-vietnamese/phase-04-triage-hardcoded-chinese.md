# Phase 4 — Triage Hardcoded Chinese in Code

## Context Links

- [plan.md](plan.md)
- [phase-01-setup-and-scout.md](phase-01-setup-and-scout.md) (scout report drives triage)
- 20 frontend files, 30 backend files flagged by initial scan
- `backend/app/utils/locale.py` — existing `t()` helper
- `frontend/src/i18n/*` — existing frontend i18n plumbing

## Overview

- Priority: P2
- Status: pending
- Categorize every Chinese occurrence; translate or route through `t()` / `useI18n` the USER-VISIBLE ones; leave internal comments unless cheap wins.

## Key Insights

From spot checks:
- Backend: nearly all 2864 occurrences are in **comments, docstrings, or log messages** (developer-facing). Example: `simulation_config_generator.py` Chinese = file docstring + code comments.
- Frontend: 902 occurrences — mostly HTML comments (`<!-- 顶部导航栏 -->`), code comments (`// 提取分析问题`), AND some hardcoded user-visible strings (e.g., `console.error('缺少项目或图谱信息')` — user-visible if surfaced).
- User-visible hardcoded strings are the PRIORITY target; comments are secondary.
- Regex parsing logic (like `text.match(/分析问题:\s*(.+?)/)` in `Step4Report.vue:557`) parses LLM output in Chinese — **do not translate the regex; LLM prompt controls the language**. These resolve via `vi.json` LLM instruction already in `languages.json`.

## Classification Taxonomy

| Category | Action | Rationale |
|----------|--------|-----------|
| A. User-visible string (alert, toast, button label, template text) | Translate OR route via i18n | Directly shown to end user |
| B. Error thrown with user-surfaced message | Route via `t()` / i18n key | Shown in UI |
| C. Log/console messages | Translate to English (ops reads logs) | Developer-facing, English standard |
| D. Code comment | Leave OR translate to English if trivial | YAGNI — dev-only, not user-facing |
| E. Docstring | Leave OR translate to English if trivial | Dev-only |
| F. Regex matching LLM output | DO NOT TOUCH | LLM will emit Vietnamese once `vi.json` instruction active — but **this is a known open bug**: parsers currently assume Chinese output. Flag as follow-up, not blocker. |
| G. Config default ("Chinese working hours") | Parameterize or leave with English name | Out of scope this plan — note for follow-up |
| H. LLM prompt template | Route via `t()` if exists; otherwise leave | Backend already translates via helper where wired |

## Requirements

### Functional
- All Category A + B strings translated to Vietnamese OR routed through i18n with vi.json entry
- All Category C strings translated to English (ops standard)
- Category D/E: SKIP unless file already being modified for A/B/C (DRY pass)
- Category F flagged in follow-up list, not fixed here
- Category G/H left alone (out of scope)

### Non-Functional
- No behavior changes — string changes only
- Preserve stack traces / error identity (keep error class names, codes)
- Maintain log severity levels

## Architecture

Two flows — frontend and backend — triaged separately but by same taxonomy:

```
Frontend (.vue, .js)                Backend (.py)
    |                                    |
    v                                    v
 Scout hits                          Scout hits
    |                                    |
    +-- Cat A/B: $t('key') --> vi.json   +-- Cat A/B: t('key') --> vi.json
    |                                    |
    +-- Cat C: console.X -> English      +-- Cat C: logger.X -> English
    |                                    |
    +-- Cat D-H: defer / skip            +-- Cat D-H: defer / skip
```

New i18n keys added to BOTH `zh.json` and `vi.json` (and `en.json` for parity).

## Related Code Files

### Frontend (20 files) — triage required
- `frontend/src/components/Step1GraphBuild.vue` (5 hits)
- `frontend/src/components/Step2EnvSetup.vue` (76)
- `frontend/src/components/Step3Simulation.vue` (52)
- `frontend/src/components/Step4Report.vue` (176 — heaviest; regex logic)
- `frontend/src/components/Step5Interaction.vue` (34)
- `frontend/src/components/GraphPanel.vue` (84)
- `frontend/src/components/HistoryDatabase.vue` (124)
- `frontend/src/views/Home.vue` (43)
- `frontend/src/views/MainView.vue` (4)
- `frontend/src/views/InteractionView.vue` (6)
- `frontend/src/views/Process.vue` (191)
- `frontend/src/views/ReportView.vue` (6)
- `frontend/src/views/SimulationRunView.vue` (18)
- `frontend/src/views/SimulationView.vue` (22)
- `frontend/src/api/*.js` (~55 total)
- `frontend/src/store/pendingUpload.js` (2)
- `frontend/src/App.vue` (4)

### Backend (30 files) — mostly comments; focus on user-surfaced errors
- `backend/app/api/*.py` (error responses returned to HTTP clients)
- `backend/app/services/*.py` (strings surfaced via API)
- `backend/app/models/*.py` (field labels if serialized)
- Utility/config files: skip (Category D/E)

### Locales (shared ownership — sequenced not parallel)
- `locales/zh.json`, `locales/vi.json`, `locales/en.json` — add any new keys introduced by refactoring

## Implementation Steps

1. Load scout report (Phase 1 output) — work file-by-file in priority order.
2. For each frontend file:
   - Open, categorize each Chinese occurrence (A-H)
   - Cat A/B: replace with `$t('section.key')`; add keys to all 3 locale JSONs
   - Cat C: translate `console.log/error/warn` messages to English in place
   - Cat D-H: leave
   - Save
3. For each backend file:
   - Same triage pass
   - Cat A/B: replace with `t('section.key')` from `app.utils.locale`; add keys
   - Cat C: translate `logger.info/error/warn` messages to English
4. Re-run scan: `rg '[\p{Han}]' frontend/src backend/app | rg -v '\.vue:.*<!--' | rg -v 'regex\('` — remaining hits should all be Category D-H (documented).
5. Compile check:
   - Backend: `cd backend && uv run python -m py_compile app/**/*.py` (glob expand in Windows: use Python `compileall`)
   - Frontend: `cd frontend && npm run build`
6. Produce follow-up list in `plans/reports/` enumerating Cat F (LLM-output parsing), Cat G (Chinese-locale config defaults), Cat D/E deferred comments.
7. Commit: `refactor(i18n): route user-visible Chinese strings through locale system`.

## Todo List

- [ ] Frontend: Step1GraphBuild.vue triage
- [ ] Frontend: Step2EnvSetup.vue triage
- [ ] Frontend: Step3Simulation.vue triage
- [ ] Frontend: Step4Report.vue triage (heavy — regex caution)
- [ ] Frontend: Step5Interaction.vue triage
- [ ] Frontend: GraphPanel.vue triage
- [ ] Frontend: HistoryDatabase.vue triage
- [ ] Frontend: Home.vue + other views triage
- [ ] Frontend: api/*.js + store + App.vue triage
- [ ] Backend: api/*.py triage
- [ ] Backend: services/*.py triage (user-surfaced only)
- [ ] Backend: models/*.py triage
- [ ] Add new i18n keys to zh/vi/en.json
- [ ] Re-run scan, confirm only Cat D-H remain
- [ ] Backend py_compile check
- [ ] Frontend build check
- [ ] Write follow-up report for Cat F/G
- [ ] Commit

## Success Criteria

- After triage, remaining `rg '[\p{Han}]' frontend/src backend/app` hits all classified as Cat D/E/F/G/H (documented in follow-up report)
- Zero Category A/B strings hardcoded — all route through i18n
- All Category C log strings in English
- Backend `py_compile` exits 0 on every `.py` touched
- `cd frontend && npm run build` exits 0
- New i18n keys present in all 3 locale JSONs with matching structure

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Accidentally modify regex patterns parsing LLM output | High | High (runtime parse failure) | Explicit Category F rule — skip any string inside `match(/.../)`, `RegExp(...)`, `re.compile(...)` |
| LLM output language mismatch: backend now prompts Vietnamese but frontend regex expects Chinese keywords | High | High | **Known limitation** — scope this plan to NOT auto-fix; produce follow-up ticket. Current behavior (zh default) unchanged when no Accept-Language header |
| Over-refactoring comments delays phase | Med | Low | Strict Cat D/E = SKIP |
| New i18n key missing in one locale file | Med | Med (key leaks to UI) | Parity check script after edits |
| String interpolation broken (e.g., `f"加载{name}"` → `t('key', name=name)`) | Med | High | Per-file review; keep formatting contract |
| File ownership overlap if Phase 3 still editing README | Low | Low | File ownership already disjoint (READMEs vs src/) |

## Rollback

- `git checkout frontend/src/ backend/app/` — reverts triage
- Keep Phase 2 (vi.json) — independent commit; no rollback needed

## Security Considerations

- Ensure error messages routed via i18n don't accidentally leak internal paths or stack traces (review each replacement)
- Log translations to English: preserve any redaction logic (e.g., `logger.error(f"API key: ***")`)

## Out of Scope (Deferred)

- **Cat F follow-up**: regex parsers in `Step4Report.vue` expect Chinese LLM keywords (`分析问题`, `预测场景`, `关键事实`, `核心实体`). When user sets `vi` locale, LLM emits Vietnamese and these regexes fail silently. **Tracked as separate ticket**: "Make LLM-output parsers locale-aware (use marker tokens not translated words)".
- **Cat G follow-up**: `simulation_config_generator.py` hardcodes Chinese working-hour profile. Flag for internationalization refactor.
- Comment-sweep to translate Chinese code comments to English — optional stretch; not required for user-facing translation task.

## Next Steps

- Phase 5 validates user-facing translations via smoke tests
- Produce follow-up tickets for Cat F / Cat G as separate GitHub issues
