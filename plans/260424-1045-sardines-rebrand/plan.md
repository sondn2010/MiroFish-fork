---
title: "Sardines Rebrand — Full Design-System Overhaul"
description: "Rebrand MiroFish → Sardines with BK Global Digital Architect design system (MD3 tokens, new logo, typography)"
status: completed
priority: P1
effort: 13h
branch: main
tags: [branding, design-system, css-tokens, ui, typography]
blockedBy: []
blocks: []
created: 2026-04-24
---

# Sardines Rebrand — Full Design-System Overhaul

## Overview

Full visual rebrand of MiroFish → **Sardines** using the BK Global "Digital Architect" design system defined in `docs/DESIGN.md`. Creates a centralized MD3 CSS token file, replaces all brand assets, renames the product across all surfaces, and applies glassmorphism/gradient/typography rules throughout.

Brainstorm report: [`plans/reports/brainstorm-260424-1045-sardines-rebrand.md`](../reports/brainstorm-260424-1045-sardines-rebrand.md)

## Cross-Plan Dependencies

| Relationship | Plan | Status | Note |
|---|---|---|---|
| Shared files | [260423-1508 Vietnamese Translation](../260423-1508-translate-chinese-to-vietnamese/plan.md) | pending | Both touch `vi.json` and `zh.json` brand keys — coordinate execution order |

> **Coordination note:** Run rebrand Phase 3 (brand rename) AFTER the translation plan completes, so vi.json brand keys are set to "Sardines" rather than reverted to "MiroFish" after translation.

## Phases

| Phase | Name | Status | Effort |
|---|---|---|---|
| 1 | [Token Foundation](./phase-01-token-foundation.md) | ✅ Done | 1h |
| 2 | [Logo & Favicon](./phase-02-logo-and-favicon.md) | ✅ Done | 30m |
| 3 | [Brand Rename](./phase-03-brand-rename.md) | ✅ Done | 1.5h |
| 4 | [Color Overhaul](./phase-04-color-overhaul.md) | ✅ Done | 4h |
| 5 | [Typography](./phase-05-typography.md) | ✅ Done | 1.5h |
| 6 | [Special Effects](./phase-06-special-effects.md) | ✅ Done | 3h |
| 7 | [QA & Validation](./phase-07-qa-validation.md) | ✅ Done | 1.5h |

## Key Dependencies

- New logo: `docs/Logo.png` (PNG only — no SVG)
- Design spec: `docs/DESIGN.md`
- Token file to create: `frontend/src/styles/design-tokens.css`
- Phases 1 & 2 must complete before 4, 5, 6 (tokens and assets must exist first)
- Phase 3 can run independently or after Phase 1
- Phase 7 runs last
