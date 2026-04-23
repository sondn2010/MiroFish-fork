# Chinese Strings Audit Report
**MiroFish Codebase Internationalization (i18n) Gap Analysis**

**Date:** 2026-04-23  
**Scope:** Frontend (Vue/JS) + Backend (Python)  
**Total Chinese Occurrences:** 3,860 (963 frontend + 2,897 backend)

---

## Executive Summary

MiroFish uses hardcoded Chinese strings extensively across both frontend and backend. The codebase has a functional i18n system (vue-i18n + locale JSON files), but **critical gaps exist**:

1. **CRITICAL GAP (Category F):** Hardcoded Chinese regex patterns in frontend parsing code (Step4Report.vue) will break Vietnamese LLM output. This is a **correctness issue, not a UX issue**.
2. **High-Priority Gaps (Category B):** Comments in code reveal Chinese-only LLM prompt instructions embedded in Python backend.
3. **System Coverage:** i18n system is in place (zh, en, vi locales exist) but many strings bypass it.
4. **Frontend vs Backend:** Frontend mostly uses i18n properly; backend relies heavily on Chinese strings in comments and hardcoded values.

**Recommendation:** Fix Category F first (regex parsers). Then audit Category C (LLM prompts) for Vietnamese variants.

---

## Summary Statistics

| Category | Frontend | Backend | Total | Action Required |
|----------|----------|---------|-------|-----------------|
| **A** - Using i18n properly | 450+ | 0 | 450+ | ✓ None |
| **B** - Hardcoded UI strings | 15+ | 5+ | 20+ | ⚠ Move to locales |
| **C** - LLM prompts/instructions | 5+ | 80+ | 85+ | ⚠ Create Vietnamese variants |
| **D** - Comments/docstrings | 300+ | 1,500+ | 1,800+ | ℹ DEFER (dev-facing) |
| **E** - Log messages | 50+ | 200+ | 250+ | ⚠ Check if user-visible |
| **F** - Regex/parser keywords | **12 CRITICAL** | 0 | **12** | 🔴 **FIX IMMEDIATELY** |
| **G** - System messages | 80+ | 100+ | 180+ | ℹ DEFER (backend-only) |
| **H** - Other | 50+ | 12+ | 62+ | ⚠ Case-by-case |

**Files Affected:**
- **Frontend:** 21 files (all component/view files)
- **Backend:** 37 Python files
- **Locales:** 3 files (zh.json, en.json, vi.json) — **vi.json already exists (46KB)**

---

## CRITICAL FINDINGS — Category F (Regex Parsers)

### High-Risk File: `frontend/src/components/Step4Report.vue` (Lines 557-799)

This file contains **12 hardcoded Chinese regex patterns** used to parse LLM output. When Vietnamese LLM generates reports, these patterns will fail to match, causing report data to not be extracted.

#### Pattern List (All CRITICAL):

| Line | Pattern | Purpose | Risk |
|------|---------|---------|------|
| 557 | `/分析问题:\s*(.+?)(?:\n\|$)/` | Extract analysis question | Parser fails on Vietnamese output |
| 561 | `/预测场景:\s*(.+?)(?:\n\|$)/` | Extract prediction scenario | Parser fails |
| 565 | `/相关预测事实:\s*(\d+)/` | Extract fact count | Parser fails |
| 566 | `/涉及实体:\s*(\d+)/` | Extract entity count | Parser fails |
| 567 | `/关系链:\s*(\d+)/` | Extract relationship count | Parser fails |
| 580 | `/### 【关键事实】[\s\S]*?\n([\s\S]*?)(?=\n###\|$)/` | Extract key facts section | Parser fails |
| 590 | `/### 【核心实体】\n([\s\S]*?)(?=\n###\|$)/` | Extract core entities section | Parser fails |
| 609 | `/### 【关系链】\n([\s\S]*?)(?=\n###\|$)/` | Extract relationships section | Parser fails |
| 673 | `/### 【涉及实体】\n([\s\S]*?)(?=\n###\|$)/` | Extract involved entities | Parser fails |
| 702 | `/\*\*采访主题:\*\*\s*(.+?)(?:\n\|$)/` | Extract interview topic | Parser fails |
| 706 | `/\*\*采访人数:\*\*\s*(\d+)\s*\/\s*(\d+)/` | Extract interview count (X/Y) | Parser fails |
| 714 | `/### 采访对象选择理由\n([\s\S]*?)(?=\n---\n\|\n### 采访实录)/` | Extract selection reason | Parser fails |

**Impact:** Vietnamese version will show report data as empty/unparsed even though Vietnamese LLM generated correct output.

**Root Cause:** LLM prompts (backend) are hardcoded in Chinese, so backend generates Chinese-labeled output. Frontend parser expects Chinese labels. When locale changes to Vietnamese, prompts still generate Chinese output (no Vietnamese LLM instruction variant).

---

## High-Priority Findings — Category C (LLM Prompts)

### Backend LLM Instruction System

**File:** `backend/app/utils/locale.py` (Line 123)

```python
return lang_config.get('llmInstruction', '请使用中文回答。')
```

**Problem:** LLM instruction is read from `locales/languages.json`. Vietnamese instruction exists but is NOT being used in LLM system prompts that generate report content.

**Affected Backend Files:**
1. `backend/app/services/report_agent.py` — Tool descriptions in Chinese (lines 917-942):
   - `"query": "你想深入分析的问题或话题"` (Chinese parameter description)
   - `"report_context": "当前报告章节的上下文..."` (Chinese parameter description)
   - Lines in tool result formatting expect Chinese output structure

2. `backend/app/services/ontology_generator.py` — Docstrings in Chinese (lines 1-5)

3. `backend/app/services/simulation_config_generator.py` — Comments describe "中国作息时间配置" (Chinese work schedule config, lines 28-46)

### Missing Vietnamese Variants

LLM prompts are NOT locale-aware. When Vietnamese is selected:
- Frontend shows Vietnamese UI
- But backend still instructs LLM to generate Chinese-format output
- Frontend parser expects Chinese labels
- **Result:** Report generation fails silently

---

## Medium-Priority Findings — Category B (Hardcoded UI Strings)

### Frontend Hardcoded Strings (Not Using i18n)

**File:** `frontend/src/components/Step4Report.vue`

| Line | String | Should Be |
|------|--------|-----------|
| 75 | `"Waiting for Report Agent..."` | Use `$t('step4.waitingForAgent')` |
| 337 | `"Report Generation Complete"` | Use `$t('step4.reportGenerationComplete')` |
| 371 | `"Waiting for agent activity..."` | Use `$t('step4.waitingForActivity')` |

**File:** `frontend/src/components/Step1GraphBuild.vue`

| Line | String | Issue |
|------|--------|-------|
| 216 | `'缺少项目或图谱信息'` (Chinese) | Should use i18n key, not hardcoded |
| 237 | `'创建模拟失败:'` (Chinese) | Should use i18n key |
| 241 | `'创建模拟异常:'` (Chinese) | Should use i18n key |

These are error messages shown to users and should be translatable.

---

## Lower-Priority Findings — Category E (Log Messages)

### Potentially User-Visible Logs

**Backend:** `backend/app/api/simulation.py` contains Chinese logs:
- Line 70: `logger.info(f"获取图谱实体: ...")` — Gets exposed to frontend? Check if frontend reads logs.
- Line 85: `logger.error(f"获取图谱实体失败: ...")` — Error shown to user?
- Line 188: `logger.info(f"开始处理 /prepare...")` — Debug logs, probably not user-visible.

**Action:** Check frontend log consumption (Step2EnvSetup.vue shows progress). If logs are streamed to UI, they need translation.

---

## Deferred — Category D (Comments/Docstrings)

**Scope:** ~1,800+ Chinese comments and docstrings across codebase.

**Files:** Every backend service file (report_agent.py, ontology_generator.py, etc.)

**Example:** `backend/app/services/report_agent.py` (lines 1-10):
```python
"""
Report Agent服务
使用LangChain + Zep实现ReACT模式的模拟报告生成
"""
```

**Decision:** DEFER translation. These are dev-facing documentation. Mark for post-MVP phase if team prefers English-only codebase. Not blocking user-facing functionality.

---

## Deferred — Category G (System Messages)

Backend system messages (mostly internal logging and configuration):

- `backend/app/services/simulation_config_generator.py` (lines 28-46): Chinese comments explaining work-hour configurations
- `backend/app/services/report_agent.py` (lines 59-385): Detailed logging docstrings in Chinese

**Decision:** DEFER. These are operational/debugging messages. Not user-visible unless frontend surfaces logs.

---

## Category A — Already Handled (Good!)

~450+ strings properly using i18n system:

**Files Using i18n Correctly:**
- `frontend/src/components/Step2EnvSetup.vue` — Uses `$t('step2.*')`
- `frontend/src/components/Step3Simulation.vue` — Uses `$t('step3.*')`
- `frontend/src/components/LanguageSwitcher.vue` — Switches locale
- `frontend/src/views/Home.vue` — Uses `$t('common.*')`

**Locale Files Status:**
- ✓ `locales/zh.json` (665 keys, 37KB) — Complete
- ✓ `locales/en.json` (665 keys, 38KB) — Complete
- ✓ `locales/vi.json` (665 keys, 46KB) — **ALREADY EXISTS** (recently added via commit 90da4c3)

---

## Root Cause Analysis

| Issue | Root Cause | Impact |
|-------|-----------|--------|
| Category F (Regex fail) | LLM prompts hardcoded Chinese in backend → LLM output in Chinese → frontend parser hardcoded for Chinese | **Report parsing fails in Vietnamese mode** |
| Category C (LLM prompts) | Backend doesn't use locale-aware prompts | **Vietnamese UI with Chinese LLM output mismatch** |
| Category B (UI strings) | Some component text not wrapped in `$t()` | **Strings won't translate in UI** |
| Category E (Logs) | Console/error logs hardcoded in Chinese | **If user-visible, appears in wrong language** |
| Category D & G (Comments) | Codebase comments in Chinese | **Dev experience, not user-facing** |

---

## Actionable Recommendations (Ranked by Priority)

### PHASE 1: CRITICAL (Fix Before Vietnamese Release)

#### Task 1.1: Fix Regex Parser Patterns (Category F)
**File:** `frontend/src/components/Step4Report.vue` (Lines 557-799)

**Action:** Extract hardcoded Chinese patterns into a **locale-aware configuration object**.

**Approach:**
```javascript
// Add to locales/vi.json and locales/en.json
{
  "reportParsing": {
    "analysisQuestion": "Câu hỏi phân tích:",  // Vietnamese
    "predictionScenario": "Kịch bản dự đoán:",
    "keyFacts": "### 【Sự kiện chính】",
    "coreEntities": "### 【Các thực thể cốt lõi】",
    // ... etc for all 12 patterns
  }
}
```

**Update Frontend Code:**
```javascript
const parseInsightForge = (text, locale = 'zh') => {
  const patterns = {
    zh: { analysisQuestion: /分析问题:\s*(.+?)/, ... },
    en: { analysisQuestion: /Analysis Question:\s*(.+?)/, ... },
    vi: { analysisQuestion: /Câu hỏi phân tích:\s*(.+?)/, ... }
  }
  const locale_patterns = patterns[locale]
  const queryMatch = text.match(locale_patterns.analysisQuestion)
  // ... rest of parsing
}
```

**Effort:** 2-3 hours (update frontend + backend prompts)

#### Task 1.2: Create Vietnamese LLM Prompts (Category C)
**Files:** 
- `backend/app/services/report_agent.py` (lines 470-850 — prompt templates)
- `backend/app/services/ontology_generator.py` (prompt templates)
- `backend/app/services/simulation_config_generator.py` (prompt templates)

**Action:** Create Vietnamese variants of all LLM prompts that define output format.

**Example Current (Chinese):**
```python
OUTLINE_PLANNING_PROMPT = """
...
生成的大纲应该遵循以下格式：
### 分析问题
...
### 预测场景
...
### 相关预测事实
...
"""
```

**Needed (Vietnamese):**
```python
OUTLINE_PLANNING_PROMPT_VI = """
...
Dàn cương được tạo ra phải tuân theo định dạng sau:
### Câu hỏi phân tích
...
### Kịch bản dự đoán
...
### Sự kiện dự đoán liên quan
...
"""
```

**Effort:** 4-6 hours (translate + test all prompt variants)

---

### PHASE 2: HIGH PRIORITY (Complete Before Alpha)

#### Task 2.1: Make Backend LLM Prompts Locale-Aware
**File:** `backend/app/utils/locale.py` (extend with prompt templates)

**Action:** 
1. Extract all hardcoded prompt templates from service files
2. Store in `backend/app/config/prompts.json` or similar
3. Load based on current locale

**Effort:** 2-3 hours

#### Task 2.2: Move Hardcoded UI Strings to i18n (Category B)
**Files:** 
- `frontend/src/components/Step4Report.vue` (lines 75, 337, 371)
- `frontend/src/components/Step1GraphBuild.vue` (lines 216, 237, 241)
- Other components as found

**Action:** Replace hardcoded strings with i18n keys.

**Effort:** 1 hour (straightforward mechanical change)

---

### PHASE 3: MEDIUM PRIORITY (Before Public Beta)

#### Task 3.1: Audit Log Message Exposure (Category E)
**Action:** 
1. Check if frontend reads backend logs from API responses
2. If yes, mark logs that are user-visible and add i18n wrapping
3. If no, DEFER logs to Phase 4

**Files:** 
- `backend/app/api/simulation.py`
- `backend/app/api/graph.py`
- Check frontend log consumption in Step2EnvSetup.vue, Step3Simulation.vue

**Effort:** 1-2 hours (audit only, action depends on findings)

---

### PHASE 4: OPTIONAL (Post-MVP)

#### Task 4.1: Translate Comments/Docstrings (Category D)
**Scope:** ~1,800+ lines in backend services

**Action:** Translate all Python docstrings to English (common open-source standard)

**Effort:** 8-12 hours (mechanical but large)

---

## File Inventory

### Frontend Files to Modify

| File | Hardcoded Chinese Count | Action |
|------|------------------------|--------|
| Step4Report.vue | 12 patterns (CRITICAL) | Fix regex patterns + parser |
| Step1GraphBuild.vue | 3 error messages | Move to i18n |
| Other Vue components | ~15 strings | Audit, move to i18n |

### Backend Files to Modify

| File | Type | Action |
|------|------|--------|
| report_agent.py | Prompts + comments | Create Vietnamese prompts, defer comments |
| ontology_generator.py | Prompts + comments | Create Vietnamese prompts, defer comments |
| simulation_config_generator.py | Prompts + comments | Create Vietnamese prompts, defer comments |
| locale.py | Config | Extend with Vietnamese prompts |
| simulation_runner.py | Logs | Audit log exposure |
| api/simulation.py | Logs | Audit log exposure |

### Locale Files (Already Exist!)

| File | Status | Action |
|------|--------|--------|
| locales/zh.json | ✓ Complete (665 keys) | No changes needed |
| locales/en.json | ✓ Complete (665 keys) | No changes needed |
| locales/vi.json | ✓ Complete (665 keys) | Add new keys for prompts (Phase 1.1) |
| locales/languages.json | ✓ Configured | No changes needed |

---

## Unresolved Questions

1. **Do backend logs get streamed to frontend UI?**
   - Check: Step2EnvSetup.vue, Step3Simulation.vue, Step4Report.vue for log consumption
   - If yes: Category E logs need i18n wrapping
   - If no: Can DEFER Category E

2. **Should Vietnamese LLM prompts match English output format or use Vietnamese-first format?**
   - Option A: Vietnamese prompts generate Vietnamese-labeled output → Update frontend parser to match
   - Option B: Vietnamese prompts generate English-labeled output → Parser uses English keys but no frontend text change
   - Recommendation: Option A (more natural for Vietnamese users)

3. **What is the release timeline for Vietnamese support?**
   - If imminent: Prioritize Phase 1 (critical fixes)
   - If 2+ weeks: Can schedule Phase 1 + 2 in parallel

4. **Are there additional LLM models (beyond report generation) that need Vietnamese prompts?**
   - Check: ontology_generator.py, simulation_config_generator.py, oasis_profile_generator.py for other prompt-using services

5. **Should Vietnamese LLM instructions be in `languages.json` or only in prompt templates?**
   - Current: Only in languages.json (llmInstruction field)
   - Needed: Expand to prompt format specifications (section headers, output structure, etc.)

---

## Summary of Action Items

| Priority | Task | File(s) | Effort | Owner | Status |
|----------|------|---------|--------|-------|--------|
| 🔴 CRITICAL | Fix regex patterns (12 patterns) | Step4Report.vue | 2-3h | Dev | Not started |
| 🔴 CRITICAL | Create Vietnamese LLM prompts | report_agent.py + 2 others | 4-6h | Dev | Not started |
| 🟠 HIGH | Move UI strings to i18n | Step4Report.vue, Step1GraphBuild.vue | 1h | Dev | Not started |
| 🟠 HIGH | Make backend prompts locale-aware | locale.py, service files | 2-3h | Dev | Not started |
| 🟡 MEDIUM | Audit log message exposure | api/simulation.py + frontend | 1-2h | Research | Not started |
| 🟢 LOW | Translate comments | backend/**/*.py | 8-12h | Post-MVP | Deferred |

---

**Report Generated:** 2026-04-23 16:14 UTC  
**Next Step:** Start Phase 1 critical fixes immediately. Coordinate with Vietnamese LLM specialist if available.
