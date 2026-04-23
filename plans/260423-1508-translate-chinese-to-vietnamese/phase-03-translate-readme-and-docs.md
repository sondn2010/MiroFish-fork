# Phase 3 — Translate README & Docs

## Context Links

- [plan.md](plan.md)
- [phase-02-translate-locale-file.md](phase-02-translate-locale-file.md) (reuse glossary)
- `README.md` (main EN doc, 203 lines, 1 Chinese tagline + Chinese image filenames)
- `README-ZH.md` (Chinese doc — stays as-is)
- `README-SETUP.md` (confirmed Chinese-free)
- `AGENTS.md` (confirmed Chinese-free)

## Overview

- Priority: P2
- Status: pending
- Create `README-VI.md` as Vietnamese mirror of `README.md`. Translate lone Chinese tagline in `README.md`. Leave image filenames alone (out-of-scope per plan).

## Key Insights

- `README.md` line 7 has Chinese tagline: `简洁通用的群体智能引擎，预测万物` → keep as-is OR move to README-ZH and replace with English-only in README.md. Recommend: remove Chinese from `README.md` (kept line 9 italic English equivalent already present).
- Language switcher line 23: `[English](./README.md) | [中文文档](./README-ZH.md)` needs to become `[English](./README.md) | [Tiếng Việt](./README-VI.md) | [中文文档](./README-ZH.md)`.
- Chinese image filenames (`运行截图N.png`, `武大模拟演示封面.png`, `红楼梦模拟推演封面.jpg`, `QQ群.png`) — DO NOT rename (would break existing docs/links). Reference them verbatim in `README-VI.md`.

## Requirements

### Functional
- `README-VI.md` created at repo root, mirroring `README.md` structure
- All prose translated to Vietnamese; code blocks, URLs, badges untouched
- Glossary terms (MiroFish, Agent, GraphRAG, OASIS, Shanda, CAMEL-AI) kept English
- Language switcher updated in all 3 README variants (`README.md`, `README-ZH.md`, `README-VI.md`) to include link to `README-VI.md`
- Chinese tagline removed from `README.md` (line 7)

### Non-Functional
- Same markdown structure & heading hierarchy as `README.md`
- Same badges, shields, images, anchor links
- Preserve emoji section headers (⚡, 🌐, 📸, 🎬, 🔄, 🚀, 📬, 📄, 📈)

## Architecture

```
README.md (English base)
    |-- copy markdown structure --> README-VI.md (Vietnamese)
    |                                     ^
    |                                     |--- glossary from Phase 2
    |
    +-- patch line 7 (remove zh tagline)
    +-- patch line 23 (add VI link)

README-ZH.md (unchanged body)
    +-- patch language switcher to include VI
```

## Related Code Files

- Modify: `README.md` (remove Chinese tagline, update language switcher)
- Modify: `README-ZH.md` (update language switcher only)
- Create: `README-VI.md`

## Implementation Steps

1. Copy `README.md` to `README-VI.md`.
2. Translate all English prose in `README-VI.md` to Vietnamese (preserve code blocks, URLs, table headers where technical like "Tool", "Version", "Description", "Check Installation" — these become "Công cụ", "Phiên bản", "Mô tả", "Kiểm tra cài đặt").
3. Update language switcher line in `README-VI.md` to: `[English](./README.md) | **Tiếng Việt** | [中文文档](./README-ZH.md)` (mark current as bold unlinked).
4. In `README.md`: remove line 7 (Chinese tagline), keep italic English line. Update language switcher: `[English](./README.md) | [Tiếng Việt](./README-VI.md) | [中文文档](./README-ZH.md)`.
5. In `README-ZH.md`: update language switcher to include `[Tiếng Việt](./README-VI.md)`.
6. Render-check: open all 3 in a markdown previewer OR run `npx markdownlint *.md` (best-effort).
7. Commit: `docs: add Vietnamese README, remove Chinese tagline from README.md`.

## Todo List

- [ ] Copy README.md → README-VI.md
- [ ] Translate prose to Vietnamese
- [ ] Apply glossary (keep product nouns English)
- [ ] Preserve all code blocks/URLs/badges
- [ ] Update language switcher in README.md
- [ ] Remove Chinese tagline from README.md line 7
- [ ] Update language switcher in README-ZH.md
- [ ] Update language switcher in README-VI.md (bold current)
- [ ] Markdown lint / preview
- [ ] Commit

## Success Criteria

- `rg '[\p{Han}]' README-VI.md` → zero matches (excluding legitimate zh image filenames in src attrs)
- Note: `rg -g '!*.zh.md'` filter not needed — VI readme ONLY has Chinese in image path references inside `src="..."` — enumerate and accept those explicitly
- All 3 language READMEs link to all 3 language docs
- `README.md` line 7 no longer contains `简洁通用的群体智能引擎` phrase
- Visual parity: screenshots section + badges render identically in VI readme

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Broken relative image links in README-VI | Med | Med | Keep `./static/image/...` paths byte-for-byte from README.md |
| Language switcher drift between 3 files | Med | Low | Use same switcher template in all 3 |
| Translated link anchors break table-of-contents auto-links | Low | Low | README has no TOC; skip |
| Accidentally translating product noun "MiroFish" to Vietnamese phonetic | Low | High (brand) | Glossary enforcement, grep for `MiroFish` count parity |

## Rollback

- `git rm README-VI.md`
- `git checkout README.md README-ZH.md`

## Security Considerations

None.

## Next Steps

- Parallel with Phase 4 (different file ownership — no conflict)
- Phase 5 will smoke-test language switcher links resolve correctly
