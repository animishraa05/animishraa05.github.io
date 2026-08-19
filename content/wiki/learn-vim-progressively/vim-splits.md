---
title: Vim Splits
concept:
aliases: [split, vsplit, window, pane, :split, :vsplit]
tags: [dev, vim]
sources_count: 1
last_source: YBlog - Learn Vim Progressively.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Working with multiple files or views requires switching buffers. Split windows provide simultaneous visibility of multiple files or different parts of the same file.

## Core Idea

Vim supports horizontal (`:split`) and vertical (`:vsplit`) window splits for simultaneous file viewing. Window commands enable navigation and resizing.

## How It Works

Split commands:
| Command | Action |
|---------|--------|
| `:split` or `:sp` | Horizontal split (top/bottom) |
| `:vsplit` or `:vsp` | Vertical split (left/right) |
| `:split <file>` | Split and open file |
| `<C-w><dir>` | Switch focus (dir = h,j,k,l or arrows) |
| `<C-w>_` | Maximize horizontal split |
| `<C-w>|` | Maximize vertical split |
| `<C-w>+` | Grow split by 1 line |
| `<C-w>-` | Shrink split by 1 line |

## Key Properties

- Each split has its own buffer
- Splits share registers and global settings
- `:hide` closes current split
- `:only` closes all other splits

## Edge Cases & Gotchas

- Resize mode: `<C-w>=` equals all split sizes
- Tab-based workflow is modern alternative to splits
- `:help split` has comprehensive documentation

## Connections

- [[vim-rectangular-blocks|Block Selection]] — Shares window commands
- [[vim-basic-commands|Survival Commands]] — Buffer commands apply in splits
- [[vim-visual-selection|Visual Selection]] — Works across splits
- [[vim-modes|Vim Modes]] — All commands work in split windows

## Sources

- [[learn-vim-progressively-summary|YBlog - Learn Vim Progressively]]
