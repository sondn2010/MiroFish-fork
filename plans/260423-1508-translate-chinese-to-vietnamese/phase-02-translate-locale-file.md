# Phase 2 — Translate Locale File (vi.json)

## Context Links

- [plan.md](plan.md)
- [phase-01-setup-and-scout.md](phase-01-setup-and-scout.md)
- Source: `locales/zh.json` (canonical, 665 lines)
- Reference: `locales/en.json` (English equivalents — disambiguate zh idioms)
- Target: `locales/vi.json` (full rewrite)

## Overview

- Priority: P1
- Status: pending
- Produce complete Vietnamese translation dictionary matching `zh.json` key structure byte-for-byte (keys only; values translated).

## Key Insights

- `zh.json` and `en.json` already have identical key structure (665 lines each). Use `en.json` as semantic reference when `zh.json` phrasing is idiomatic.
- vi.json must preserve: JSON formatting (2-space indent), placeholder tokens (`{brand}`, `{agentScale}`, `{optimalSolution}`, `{count}`, etc.), HTML-like tags if any.
- Product nouns stay English per glossary: `MiroFish`, `Agent`, `GraphRAG`, `ReportAgent`, `OASIS`, `Zep`, `LLM`, `Reddit`, `Twitter`.
- Vietnamese localization conventions:
  - UI labels: sentence case, no trailing period
  - Button text: Tiêu đề ngắn gọn (e.g., "Xác nhận", "Hủy", "Quay lại")
  - Time units: "giờ", "phút", "vòng" (for rounds)
  - Numbers/units: Vietnamese uses `.` for thousands and `,` for decimals — DO NOT change placeholder formatting, only labels around them

## Requirements

### Functional
- Every key in `zh.json` present in `vi.json` with Vietnamese value
- Every placeholder `{x}` preserved verbatim
- JSON is valid (loads via `json.load`)
- Zero Chinese characters remain in `vi.json`

### Non-Functional
- File size comparable to `zh.json` (±30%)
- Diacritics present (dấu thanh: à, á, ả, ã, ạ etc.) — sanity check

## Architecture

```
zh.json (source)  ---- LLM translate (with en.json context) ---->  vi.json
                                      ^
                                      |
                            glossary enforcement
                            placeholder preservation
```

Translation strategy — chunk the JSON by top-level key to keep LLM context bounded:
- `common`, `meta`, `nav`, `home` — UI chrome (batch 1)
- `process`, `step1Graph`, `step2Env`, `step3Sim`, `step4Report`, `step5Interact` — workflow (batch 2)
- `simulation`, `report`, `graph`, `history` — data panels (batch 3)
- `errors`, `status`, `messages`, anything remaining — system messaging (batch 4)

## Related Code Files

- Modify: `locales/vi.json` (full rewrite)
- Read: `locales/zh.json`, `locales/en.json`
- No code file touched

## Implementation Steps

1. Read entire `zh.json` and `en.json` (665 lines each). Build side-by-side key map mentally.
2. Translate in 4 batches described above. For each batch:
   - Preserve exact JSON structure
   - Translate values to Vietnamese
   - Keep glossary English terms intact
   - Preserve `{placeholder}` tokens exactly
3. Assemble batches into single `vi.json`. Validate JSON parses.
4. Run key-diff check: `python -c "import json; z=json.load(open('locales/zh.json',encoding='utf-8')); v=json.load(open('locales/vi.json',encoding='utf-8')); ..."` (deep key comparison).
5. Run `rg '[\p{Han}]' locales/vi.json` — must return zero matches.
6. Spot-check 20 random values for naturalness (not literal word-for-word translation).
7. Commit: `feat(i18n): translate locales/vi.json to Vietnamese`.

## Todo List

- [ ] Read zh.json + en.json in full
- [ ] Translate batch 1: common/meta/nav/home
- [ ] Translate batch 2: process/stepN*
- [ ] Translate batch 3: simulation/report/graph/history
- [ ] Translate batch 4: errors/status/messages/remainder
- [ ] JSON validity check
- [ ] Key-parity check vs zh.json
- [ ] Zero-Chinese-character check
- [ ] Manual spot-check naturalness
- [ ] Commit

## Success Criteria

- `python -m json.tool locales/vi.json` exits 0
- Key diff script reports: `Missing: 0, Extra: 0`
- `rg '[\p{Han}]' locales/vi.json | wc -l` → 0
- Diacritic sanity: `rg '[àáảãạăắằẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ]' locales/vi.json -c` → ≥ 200

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Placeholder token stripped during translation | Med | High (runtime ReferenceError) | Post-translate diff: count `{` in zh vs vi — must match |
| Key renamed during translation | Low | High (lookup fail) | Key-parity script in step 4 |
| JSON structure broken (unescaped quotes) | Med | High | `json.load` validation in step 4 |
| Over-translation of product nouns | Med | Med | Glossary enforced; review pass after each batch |
| Length expansion breaks UI layout | Low | Low | Vietnamese typically 10-20% longer than zh — matches en.json footprint |

## Rollback

`git checkout locales/vi.json` reverts to prior (English-content) state. No downstream code depends on untranslated vi.json.

## Security Considerations

None — static text file with no PII/secrets.

## Next Steps

- Unblocks Phase 3 (README translation uses same glossary)
- Unblocks Phase 4 (code triage — some "hardcoded" strings may resolve via existing t() helper once vi.json is real)
- Feeds Phase 5 (smoke test with `Accept-Language: vi`)
