# Chinese to Vietnamese Translation Project — Status Report
**Date:** 2026-04-23 | **Status:** 60% Complete (Phases 2-3 Done, Critical Gap Found in Phase 4)

---

## Executive Summary

✅ **Completed Successfully:**
- Phase 2: `locales/vi.json` created (665 keys, 100% translated, 0 Chinese characters)
- Phase 3: `README-VI.md` created, language switcher updated

⚠️ **Critical Issue Discovered:**
- Backend LLM prompts and frontend report parsers are hardcoded for Chinese format
- Vietnamese locale will display UI in Vietnamese but reports will render empty/unparsed
- Requires code changes to Step4Report.vue and backend services

---

## Phase Status

### Phase 1: Setup & Scout ✅
Completed by planner agent. Identified 3,860 Chinese strings across codebase.

### Phase 2: Translate Locale File (vi.json) ✅ COMPLETE
**Status:** Ready for deployment
- 665 keys translated from Chinese to Vietnamese
- All placeholders preserved: `{count}`, `{brand}`, `{error}`, etc.
- Product terms kept English: MiroFish, Agent, GraphRAG, Zep, LLM, Twitter, Reddit
- Vietnamese diacritics: 9,998 marks found (à, á, ả, ã, ạ, ă, â, ê, etc.)
- JSON validity: ✓ Passes `json.load()` validation
- File: `locales/vi.json` (46KB)

### Phase 3: Translate README & Docs ✅ COMPLETE
**Status:** Ready for deployment
- Created: `README-VI.md` (203 lines, full Vietnamese translation)
- Updated: `README.md` language switcher line 23
  - Old: `[English](./README.md) | [中文文档](./README-ZH.md)`
  - New: `[English](./README.md) | [Tiếng Việt](./README-VI.md) | [中文文档](./README-ZH.md)`
- All badges, links, structure preserved
- Professional Vietnamese tone

### Phase 4: Triage Hardcoded Chinese — 🚨 CRITICAL GAP FOUND

**The Problem:**
When users select Vietnamese locale (`SIMULATION_LANGUAGE=vi`), here's what happens:

1. **Frontend UI:** ✓ Displays in Vietnamese (from `vi.json`)
2. **Backend LLM:** ✗ Still generates Chinese-formatted output
   - Backend prompts in `report_agent.py` hardcoded Chinese: "分析问题:", "预测场景:", etc.
   - LLM generates output with Chinese section headers and labels
3. **Frontend Parser:** ✗ Fails to extract report sections
   - Step4Report.vue regex patterns hardcoded for Chinese: `/分析问题:/`, `/### 【关键事实】/`
   - Parser looks for Chinese keywords but Vietnamese LLM output has Vietnamese keywords
   - Result: Report shows as empty, even though backend successfully generated it

**Example Flow:**
```
User selects "Tiếng Việt" (Vietnamese)
    ↓
Frontend UI displays in Vietnamese ✓
    ↓
Backend LLM prompt still in Chinese → LLM generates Chinese-formatted report
    ↓
Frontend expects Chinese keywords (分析问题:, 【关键事实】)
    ↓
Parser fails → Report appears empty/broken ✗
```

---

## Critical Files Requiring Code Changes

### 1. `frontend/src/components/Step4Report.vue` (HIGH PRIORITY)
**Lines:** 557-799
**Issue:** 12 hardcoded Chinese regex patterns

```javascript
// Current (fails for Vietnamese):
/分析问题:\s*(.+?)(?:\n|$)/      // "分析问题:" = "Analysis Problem:"
/预测场景:\s*(.+?)(?:\n|$)/      // "预测场景:" = "Prediction Scenario:"
/### 【关键事实】/                // Chinese section header
/### 【核心实体】/                // Chinese section header
// ... 8 more patterns for Chinese keywords
```

**Required Fix:** Make regex patterns dynamic based on current locale:
- Extract patterns to locale-aware config
- Create Vietnamese pattern variants
- Use `$i18n.locale` to select correct parser

### 2. `backend/app/services/report_agent.py` (HIGH PRIORITY)
**Lines:** 917-942, and throughout
**Issue:** Tool descriptions and output format instructions in Chinese

```python
# Current:
"分析问题: ..."  # "Analysis Problem" in Chinese
"预测场景: ..."  # "Prediction Scenario" in Chinese
```

**Required Fix:**
- Use backend `t()` locale helper to localize LLM prompt instructions
- Create Vietnamese variant of output format specification
- Ensure LLM generates output with correct Vietnamese labels

### 3. `backend/app/services/ontology_generator.py` (MEDIUM PRIORITY)
**Issue:** Chinese prompts throughout
**Required Fix:** Localize via `t()` helper or create language-aware variants

### 4. `backend/app/services/simulation_config_generator.py` (MEDIUM PRIORITY)
**Issue:** Chinese prompts
**Required Fix:** Same as above

---

## Summary of Changes Required

### For Full Vietnamese Support (All Phases Including Code):

| Category | Count | Effort | Status |
|----------|-------|--------|--------|
| Phase 2: Locale file (vi.json) | 665 keys | 3h | ✅ DONE |
| Phase 3: README & docs | 2 files | 1h | ✅ DONE |
| **Phase 4A: Report parser regex** | 12 patterns | 2-3h | ⏳ NEEDED |
| **Phase 4B: LLM prompt localization** | 5+ files | 4-6h | ⏳ NEEDED |
| Phase 4C: Dev-facing comments | 2,000+ | 10h | 📋 OPTIONAL |
| Phase 5: Validation & testing | - | 1h | ⏳ NEEDED |
| **Total (MVP Vietnamese support)** | - | **11-13h** | **40-50% done** |

---

## Recommended Next Steps

### Option A: MVP Vietnamese Support (Recommended)
Focus on making Vietnamese fully functional:
1. Fix Step4Report.vue regex patterns (2-3h)
2. Localize backend LLM prompts (4-6h)
3. Test Vietnamese end-to-end (1h)
**Total:** 7-10 hours, achieves working Vietnamese locale

### Option B: Basic Translation Only (Current State)
Stop here — Vietnamese UI works, but reports render empty.
**Issue:** Users see Chinese tagline removed but report feature broken in Vietnamese

### Option C: Complete Translation (Stretch)
Add Option A + translate all dev-facing comments (10h additional)
**Total:** 17-20 hours, fully cleaned codebase

---

## Files Modified So Far

- ✅ `locales/vi.json` — Created (new file, 46KB)
- ✅ `README-VI.md` — Created (new file, ~203 lines)
- ✅ `README.md` — Updated (language switcher line 23)

---

## Files That Still Need Changes (for Option A)

- 🔴 `frontend/src/components/Step4Report.vue` — Regex pattern extraction + localization
- 🔴 `backend/app/services/report_agent.py` — LLM prompt localization
- 🟡 `backend/app/services/ontology_generator.py` — Prompt localization
- 🟡 `backend/app/services/simulation_config_generator.py` — Prompt localization

---

## Unresolved Questions for User

1. **Scope Approval:** Should I proceed with Option A (MVP Vietnamese support, 7-10h) or keep current Option B (UI translation only)?
2. **Report Parser:** Do you want the parser to auto-detect language from backend or use explicit config?
3. **LLM Prompts:** Should backend prompts branch on locale, or stay Chinese-only for now?
4. **Timeline:** Is there a deadline for Vietnamese feature completeness?

---

## Validation Checklist (Phases 2-3)

- [x] `locales/vi.json` is valid JSON
- [x] All keys from `zh.json` present in `vi.json`
- [x] Zero Chinese characters in `vi.json`
- [x] 9,998+ Vietnamese diacritics found
- [x] All placeholders preserved
- [x] README-VI.md created and linked
- [x] Language switcher updated in README.md
- [ ] Backend can use Vietnamese locale (requires Phase 4 fixes)
- [ ] Reports render correctly in Vietnamese (blocked by Step4Report.vue)
- [ ] End-to-end test with `SIMULATION_LANGUAGE=vi` (blocked by Phase 4)

---

## Next Action

Please clarify:
- **Should I proceed with Phase 4 code changes (Option A) for full Vietnamese support?**
- Or keep current translation-only deliverable (Option B)?

Once approved, I can complete the remaining work within 7-10 hours.
