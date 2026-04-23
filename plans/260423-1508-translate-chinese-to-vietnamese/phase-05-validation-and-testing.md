# Phase 5 — Validation & Testing

## Context Links

- [plan.md](plan.md)
- [phase-02-translate-locale-file.md](phase-02-translate-locale-file.md)
- [phase-03-translate-readme-and-docs.md](phase-03-translate-readme-and-docs.md)
- [phase-04-triage-hardcoded-chinese.md](phase-04-triage-hardcoded-chinese.md)
- `backend/tests/` — existing test suite
- `backend/app/utils/locale.py` — locale routing under test

## Overview

- Priority: P1 (final gate)
- Status: pending
- End-to-end verification: locale routing, JSON parity, build health, smoke tests with `vi` locale active.

## Key Insights

- Existing backend test suite should already exist under `backend/tests/`; run as-is — no new tests required for translation task (DRY — don't duplicate i18n framework tests).
- Primary validation is **integration smoke test** not unit: can I set `Accept-Language: vi` and get Vietnamese responses?
- LLM-dependent tests will produce Vietnamese output — consuming code paths (especially Cat F parsers from Phase 4) may fail. This validates the known gap — document, don't fix here.

## Requirements

### Functional
- All 3 locale JSONs (zh, en, vi) have identical key structure
- Backend loads all 3 locales at startup without error
- `t()` returns Vietnamese when thread locale = `vi`
- Frontend builds with vi.json imported
- HTTP `Accept-Language: vi` round-trip returns Vietnamese strings
- LLM instruction for `vi` = "Vui lòng trả lời bằng tiếng Việt." (confirmed in `languages.json`)

### Non-Functional
- No regression: existing `zh` and `en` flows still work
- No new test failures in existing suite
- Frontend bundle size within 10% of baseline

## Test Matrix

| Test | Type | Command | Pass Criteria |
|------|------|---------|---------------|
| JSON validity | Unit | `python -m json.tool locales/vi.json` | Exit 0 |
| Key parity zh↔vi | Unit | See script below | Missing=0, Extra=0 |
| Key parity en↔vi | Unit | Same script, swap args | Missing=0, Extra=0 |
| Zero Chinese in vi.json | Unit | `rg '[\p{Han}]' locales/vi.json` | No matches |
| Diacritic presence | Unit | rg diacritic class | ≥200 matches |
| Backend locale loader | Unit | `python -c "from backend.app.utils.locale import t; print(t('common.confirm'))"` | No exception |
| Backend existing tests | Regression | `cd backend && uv run pytest` | All pass (or same as baseline) |
| Backend py_compile | Build | `uv run python -m compileall app/` | No syntax errors |
| Frontend build | Build | `cd frontend && npm run build` | Exit 0 |
| Frontend dev start | Smoke | `npm run frontend` | Starts, no console errors |
| HTTP Accept-Language: vi | Integration | `curl -H 'Accept-Language: vi' http://localhost:5001/api/health` | Vietnamese in error/info strings |
| Backend config override | Integration | `SIMULATION_LANGUAGE=vi` env → start backend → hit API | Vietnamese responses |
| README-VI renders | Manual | GitHub markdown preview | Renders, images visible, links resolve |
| Language switcher | Manual | Click each README's switcher | Navigates correctly |

### Parity Script

```python
# plans/260423-1508-translate-chinese-to-vietnamese/scripts/check-locale-parity.py
import json
import sys

def flat_keys(d, prefix=''):
    out = set()
    for k, v in d.items():
        kp = f'{prefix}.{k}' if prefix else k
        if isinstance(v, dict):
            out.update(flat_keys(v, kp))
        else:
            out.add(kp)
    return out

def load(p):
    with open(p, encoding='utf-8') as f:
        return json.load(f)

zh = flat_keys(load('locales/zh.json'))
vi = flat_keys(load('locales/vi.json'))
en = flat_keys(load('locales/en.json'))

print(f'zh missing in vi: {sorted(zh - vi)}')
print(f'vi extra vs zh:   {sorted(vi - zh)}')
print(f'en missing in vi: {sorted(en - vi)}')
print(f'vi extra vs en:   {sorted(vi - en)}')

ok = (zh == vi == en)
sys.exit(0 if ok else 1)
```

(Save under `plans/260423-1508-translate-chinese-to-vietnamese/scripts/` for reuse.)

## Architecture

```
JSON parity ----\
                 \
Backend tests ----+---> Gate: all pass?
                 /       |
Frontend build -/        |---YES--> Manual smoke
                         |                  |
                         |                  v
                         |              Accept-Language: vi
                         |                  |
                         |                  v
                         |          Visual confirm Vietnamese
                         |
                         +---NO---> Return to failing phase
```

## Related Code Files

- Read: `locales/*.json`, `backend/tests/**`, `frontend/package.json`
- Create: `plans/.../scripts/check-locale-parity.py`
- Modify: none (validation only)

## Implementation Steps

1. Write parity script (above) to plan scripts dir.
2. Run parity script — triage any mismatches back to Phase 2 or Phase 4.
3. Run zero-Chinese-in-vi.json check.
4. Run diacritic sanity check.
5. Run backend pytest — compare to baseline (pre-Phase 4) run count.
6. Run frontend `npm run build` — confirm exit 0, capture bundle size delta.
7. Start backend + frontend in dev mode.
8. Curl health endpoint with `Accept-Language: vi` — verify Vietnamese strings.
9. Manually open UI in browser, set UI language to Vietnamese, click through:
   - Home → Upload → Start Simulation
   - View status messages, error toasts
   - View one completed report
10. Render-check all 3 READMEs on GitHub preview or local markdown viewer.
11. Produce validation report: `plans/reports/planner-260423-1508-validation-summary.md` with pass/fail per row of test matrix.
12. If all pass: tag commit `v0.1-i18n-vi`. If any fail: create issue referencing the failing phase.

## Todo List

- [ ] Write parity script
- [ ] Run JSON validity check
- [ ] Run parity script (zh↔vi, en↔vi)
- [ ] Run zero-Chinese check
- [ ] Run diacritic sanity check
- [ ] Run backend pytest
- [ ] Run backend py_compile
- [ ] Run frontend build
- [ ] Start services; curl with Accept-Language: vi
- [ ] Browser smoke test: full flow in vi locale
- [ ] README rendering check (×3 files)
- [ ] Write validation report
- [ ] Tag / create follow-up issues

## Success Criteria

- Every row in test matrix passes OR failures documented with root cause pointing to specific phase to reopen
- Validation report committed to `plans/reports/`
- Known follow-ups (Cat F/G from Phase 4) tracked as GitHub issues

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Existing zh flow broken by vi.json load order | Low | High | locale.py loads all .json files; no load-order dependency. Test zh still works after vi added |
| LLM integration tests flaky under vi prompts | High | Med | Mark as known; scope this plan doesn't guarantee LLM-output consumer correctness — Cat F follow-up |
| Frontend bundle grows beyond budget | Low | Low | vi.json ~ same size as zh.json (~40KB) |
| pytest failures due to Chinese string assertions | Med | Med | If found: tests assert specific Chinese strings → need to be i18n-aware. Fix as Phase 4 tail. |
| `Accept-Language` fallthrough to default zh masks vi misconfig | Med | Med | Explicit test with env var `SIMULATION_LANGUAGE=vi` + no Accept-Language header |

## Rollback

All prior phase commits are independent. Rollback order if validation fails catastrophically:
1. `git revert` Phase 4 commit (code triage) — restores hardcoded behavior
2. Keep Phase 2/3 (vi.json + README-VI.md) — pure additions, low risk

## Security Considerations

- Verify translated error messages still redact sensitive fields (API keys, connection strings)
- Verify language-switching logic not vulnerable to header injection (existing locale.py uses `.split(',')[0].strip().lower()` — safe, no code injection vector)

## Definition of Done

- [ ] Test matrix 100% pass (or documented deferrals)
- [ ] Validation report in `plans/reports/`
- [ ] Follow-up issues created for Cat F (LLM-output parsers) and Cat G (Chinese config defaults)
- [ ] README-VI.md live on main branch
- [ ] `locales/vi.json` complete and validated
- [ ] User can set Accept-Language: vi and see Vietnamese UI

## Next Steps

Post-merge:
- Announce vi support in CHANGELOG
- Consider switching default locale from `zh` to explicit negotiation (separate plan)
- Address Cat F parser locale-awareness (separate plan)
