---
title: Vim Buffers
concept:
aliases: [buffer, :e, :bn, :bp, :w, :q]
tags: [dev, vim]
sources_count: 1
last_source: YBlog - Learn Vim Progressively.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Editing multiple files sequentially requires efficiently loading, saving, and switching between file buffers.

## Core Idea

A buffer is an in-memory copy of a file. Vim provides commands to load, save, and navigate between open buffers.

## How It Works

Basic buffer commands:
| Command | Action |
|---------|--------|
| `:e <path>` | Open (edit) a file |
| `:w` | Save current buffer |
| `:w <path>` | Save to new file |
| `:saveas <path>` | Save buffer as new file |
| `:x` | Save if modified and quit |
| `:q` | Quit (fails if unsaved) |
| `:q!` | Quit without saving |
| `:qa!` | Quit all, ignore changes |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |

## Key Properties

- `:q!` discards unsaved changes
- `:x` only writes if buffer is modified
- `ZZ` = `:wq` (write and quit)
- Buffer list persists until explicitly cleared

## Edge Cases & Gotchas

- Unload buffer vs delete buffer are different
- Hidden buffers: `:bn` fails with unsaved changes — use `:bn!` or `:set hidden`
- `:b#` switches to alternate buffer

## Connections

- [[vim-splits|Vim Splits]] — Each split shows a buffer
- [[vim-basic-commands|Survival Commands]] — Basic save/quit
- [[vim-modes|Vim Modes]] — Works in Normal mode
- [[vim-macros|Macros]] — Can record buffer operations

## Sources

- [[learn-vim-progressively-summary|YBlog - Learn Vim Progressively]]
