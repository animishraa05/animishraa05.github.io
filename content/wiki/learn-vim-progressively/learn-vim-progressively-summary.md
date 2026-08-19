---
title: YBlog - Learn Vim Progressively Summary
source: YBlog - Learn Vim Progressively.md
source_path: sources/YBlog - Learn Vim Progressively.md
content_hash: a1b2c3d4e5f6
ingested: 2026-04-12
concepts_count: 11
tags: [dev, vim]
---

## Concepts Extracted

- **vim-modes** — Modal editing: Normal, Insert, Visual (character/line/block)
- **vim-basic-commands** — Five survival commands: i, x, :wq, dd, p
- **vim-text-objects** — Zone selection with i/a prefixes (words, sentences, quotes, brackets)
- **vim-visual-selection** — v, V, <C-v> for character/line/block selection
- **vim-search-navigation** — Movement: 0, ^, $, g\_, f/F/t/T, gg/G/N G, /pattern, \*, %, word/line/file moves
- **vim-rectangular-blocks** — <C-v> block selection for columns, commenting multiple lines
- **vim-repetition** — . (dot) for last change, N prefix for counts
- **vim-macros** — qa...q recording, @a, @@ replay
- **vim-splits** — :split/:vsplit, <C-w> navigation
- **vim-buffers** — :e/:w/:q/:bn/:bp for file and buffer management
- **vim-completion** — <C-n>/<C-p> in Insert mode

## Wiki Pages Created/Updated

**Created:**

- wiki/learn-vim-progressively/vim-modes.md
- wiki/learn-vim-progressively/vim-basic-commands.md
- wiki/learn-vim-progressively/vim-text-objects.md
- wiki/learn-vim-progressively/vim-visual-selection.md
- wiki/learn-vim-progressively/vim-search-navigation.md
- wiki/learn-vim-progressively/vim-rectangular-blocks.md
- wiki/learn-vim-progressively/vim-repetition.md
- wiki/learn-vim-progressively/vim-macros.md
- wiki/learn-vim-progressively/vim-splits.md
- wiki/learn-vim-progressively/vim-buffers.md
- wiki/learn-vim-progressively/vim-completion.md

**Updated:**

- None (new topic folder)

## Key Takeaways

1. **Progressive learning**: Four levels — Survive → Comfortable → Better/Stronger/Faster → Superpowers
2. **Modal editing** is the fundamental differentiator from conventional editors
3. **Operators + Motions** compose: d$, yG, c w (change word)
4. **Counts and repetition** multiply, not add: 3. = 9, not 6
5. **Learning curve**: 2-3 weeks before productivity gains over conventional editors

## Novelty for Wiki

Extracted 11 atomic Vim concept pages with practical commands. Complements existing LSP wiki (which covers Neovim configuration). These pages cover the Vim fundamentals that LSP wiki assumes knowledge of.

## Open Questions

- How do folds (za, zR) fit into this progressive framework?
- How do registers (especially unnamed, black hole, and named) extend beyond macros?
- How does this connect to Neovim's Lua configuration and plugins?

## Connections

- [[vim-modes|Vim Modes]] — modal editing fundamentals
- [[vim-basic-commands|Vim Basic Commands]] — survival commands
- [[vim-text-objects|Vim Text Objects]] — zone selection
- [[vim-visual-selection|Vim Visual Selection]] — text region selection
- [[vim-search-navigation|Vim Search & Navigation]] — movement patterns
- [[vim-macros|Vim Macros]] — command recording/replay
- [[vim-repetition|Vim Repetition]] — dot command and counts
- [[vim-splits|Vim Splits]] — window management
- [[vim-buffers|Vim Buffers]] — file management
- [[language-server-protocol|Language Server Protocol]] — complements LSP wiki
- [[vim-lsp|vim.lsp]] — related Neovim LSP integration
