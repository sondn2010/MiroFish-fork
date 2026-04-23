# Phase 1 — Setup & Scout

## Context Links

- [plan.md](plan.md)
- `locales/zh.json` (source of truth, 665 lines)
- `locales/vi.json` (existing, confirmed untranslated)
- `locales/languages.json` (already has `vi` entry)
- `backend/app/utils/locale.py` (translation routing)

## Overview

- Priority: P1 (blocks all downstream work)
- Status: pending
- Confirm scope, back up current `vi.json`, produce baseline scout report.

## Key Insights

- Current `vi.json` = English content. Overwriting is safe (no Vietnamese content to lose).
- Existing `languages.json` has Vietnamese registered — no registry edits.
- Backend locale loader auto-discovers any `.json` file in `locales/` except `languages.json`; once `vi.json` is filled, backend routes work without code changes.

## Requirements

### Functional
- Baseline scan captured: counts + file lists for Chinese occurrences.
- Scout report saved to `plans/reports/`.
- Git baseline clean (no uncommitted changes in target files before starting).

### Non-Functional
- No code changes this phase. Discovery only.

## Architecture

Single command flow:
```
git status check  ->  rg scans (locale/frontend/backend/docs)  ->  report
```

## Related Code Files

- Read: `locales/*`, `backend/app/utils/locale.py`, `frontend/src/i18n/*` (confirm wiring)
- Modify: none
- Create: `plans/reports/planner-260423-1508-scout-chinese-strings.md`

## Implementation Steps

1. Run `git status` — confirm clean baseline or note dirty files.
2. Read `frontend/src/i18n/*` to document how frontend consumes locale JSON.
3. Execute scans (document counts per file):
   - `rg '[\p{Han}]' locales/vi.json -c` (expect 0 once done)
   - `rg '[\p{Han}]' frontend/src --count-matches`
   - `rg '[\p{Han}]' backend/app --count-matches`
   - `rg '[\p{Han}]' README.md`
4. Classify each hit as one of: `{locale-json, code-comment, docstring, log-message, user-facing-string, config-default, prompt-template}`.
5. Produce scout report listing:
   - Total Chinese character hits per category
   - List of files requiring user-facing string edits (Phase 4 input)
   - List of files with Chinese-only comments (Phase 4 stretch input)
6. Create git branch `feat/i18n-vietnamese-translation` from `main`.

## Todo List

- [ ] Verify git clean on target files
- [ ] Read frontend i18n wiring
- [ ] Run character scans and tally by category
- [ ] Save scout report
- [ ] Create feature branch

## Success Criteria

- Scout report committed to `plans/reports/`
- File classification table complete
- Feature branch checked out

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Hidden Chinese strings in `.vue` `<script>` that look like code identifiers | Low | Low | rg scan covers all file types |
| Untracked `vi.json` with user edits overwritten later | Low | Med | Confirm git-clean before Phase 2 |

## Rollback

No code changes — rollback = abandon feature branch.

## Next Steps

Phase 2 (translate locale file) unblocked once scout report exists.
