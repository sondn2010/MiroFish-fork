---
title: "Translate Chinese Text to Vietnamese"
description: "Produce complete vi.json, remove/translate Chinese from README and code comments, enable Vietnamese locale end-to-end."
status: pending
priority: P2
effort: 6h
branch: main
tags: [i18n, locale, vietnamese, translation]
created: 2026-04-23
---

# Translate Chinese Text to Vietnamese

## Cross-Plan Dependencies

| Relationship | Plan | Status | Note |
|---|---|---|---|
| Shared files | [260424-1045 Sardines Rebrand](../260424-1045-sardines-rebrand/plan.md) | pending | Both touch `vi.json` brand keys — run this plan first, rebrand Phase 3 last |

## Goal

Deliver a first-class Vietnamese experience in MiroFish: complete `locales/vi.json`, translated README-VI.md, cleaned Chinese comments where value-add, and verified runtime routing through existing `locale.py` + `useI18n` pipeline.

## Key Findings (scoping facts)

1. `locales/vi.json` ALREADY EXISTS but is a copy of `en.json` (zero Vietnamese diacritics detected). Needs full re-translation from `zh.json` source of truth (665 lines).
2. `locales/languages.json` already declares `vi` with label "Tiếng Việt" and LLM instruction. No registry changes needed.
3. Backend has a mature locale system in `backend/app/utils/locale.py` — 14 backend files call `t()` helper. User-facing backend strings already flow through locale JSON.
4. Chinese occurrences in code: **2864** across 30 backend files, **902** across 20 frontend files. Spot checks show **majority are comments/docstrings, not runtime strings**.
5. `AGENTS.md` and `README-SETUP.md` are already Chinese-free.
6. `README.md` has 1 Chinese tagline + Chinese-named screenshot file paths (`运行截图1.png`, `武大模拟演示封面.png`, `红楼梦模拟推演封面.jpg`, `QQ群.png`).
7. `README-ZH.md` is the Chinese version of README — should stay Chinese (it is the zh doc); a new `README-VI.md` mirror is needed.
8. Backend default locale falls back to `'zh'` in `locale.py:38, 58, 62, 91, 102`. Consider making default configurable but DO NOT change default in this plan (out of scope — would affect existing zh users).

## Phases

| # | Phase | File | Status | Effort |
|---|-------|------|--------|--------|
| 1 | Setup & Scout | [phase-01-setup-and-scout.md](phase-01-setup-and-scout.md) | pending | 30m |
| 2 | Translate Locale File (vi.json) | [phase-02-translate-locale-file.md](phase-02-translate-locale-file.md) | pending | 3h |
| 3 | Translate README & Docs | [phase-03-translate-readme-and-docs.md](phase-03-translate-readme-and-docs.md) | pending | 1h |
| 4 | Triage Hardcoded Chinese in Code | [phase-04-triage-hardcoded-chinese.md](phase-04-triage-hardcoded-chinese.md) | pending | 1h |
| 5 | Validation & Testing | [phase-05-validation-and-testing.md](phase-05-validation-and-testing.md) | pending | 30m |

## Dependency Graph

```
Phase 1 (scout)
  |
  v
Phase 2 (vi.json) -------+
  |                      |
  v                      v
Phase 3 (README-VI.md)   Phase 4 (code triage)
  |                      |
  +----------+-----------+
             |
             v
          Phase 5 (validation)
```

Phase 3 and Phase 4 can run in parallel after Phase 2 if different files. File ownership is disjoint (Phase 3 owns `README*.md`, Phase 4 owns `frontend/src/**` and `backend/app/**`).

## Success Criteria (measurable)

- [ ] `locales/vi.json` has 0 Chinese characters remaining (`rg '[\p{Han}]' locales/vi.json` returns nothing)
- [ ] `locales/vi.json` has same key structure as `zh.json` (deep-diff shows no missing/extra keys)
- [ ] `locales/vi.json` values contain Vietnamese diacritics (sanity: diacritic count > 200)
- [ ] `README-VI.md` exists and is linked from `README.md` language switcher
- [ ] Setting `Accept-Language: vi` (frontend) OR `SIMULATION_LANGUAGE=vi` (backend) routes UI/LLM output to Vietnamese
- [ ] Backend unit/integration tests still pass (`cd backend && uv run pytest`)
- [ ] Frontend builds without error (`cd frontend && npm run build`)

## Out of Scope (YAGNI)

- Changing the default locale away from `zh`
- Translating `README-ZH.md` (it IS the Chinese doc)
- Refactoring Chinese code comments to English (discussed in Phase 4; keep minimal)
- Renaming Chinese image files (breaks embedded links in existing README — separate cleanup)
- Translating LLM prompt templates embedded in Python (they already branch via `t()` helper where relevant)

## Unresolved Questions

1. Should `README-VI.md` mirror `README.md` (English baseline) or `README-ZH.md` (Chinese richer content)? Recommend mirror of `README.md` for consistency.
2. Do we want a language switch link in `README-VI.md` header pointing back to EN/ZH? Recommend yes.
3. User requested translating "hardcoded strings in code" — confirm scope: just user-visible strings (errors, log messages surfaced to UI), or all comments/docstrings too? Plan assumes **user-visible only** for P2 effort budget; doc-comment sweep offered as optional stretch in Phase 4.
4. Is there a glossary of MiroFish product terms (Agent, GraphRAG, Swarm Intelligence, Prediction Engine) that must stay English in Vietnamese text? Plan assumes yes (keep technical terms English, add Vietnamese gloss in parens on first mention).
