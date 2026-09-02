---
title: Vim Visual Selection
concept:
aliases: [visual mode, visual select, v, V, Ctrl-v]
tags: [dev, vim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Editing arbitrary regions requires cursor gymnastics or awkward mouse selection. Standard editors let you select text then act on it — Vim needs equivalent functionality.

## Core Idea

Visual mode selects text ranges then applies operators. Three variants: character-wise, line-wise, and block-wise.

## How It Works

Entry commands:
| Key | Selection Type |
|-----|----------------|
| `v` | Character-wise (highlight characters) |
| `V` | Line-wise (highlight entire lines) |
| `<C-v>` | Block-wise (rectangular column selection) |

Post-selection operations:

- `J` — join selected lines together
- `<` — indent left
- `>` — indent right
- `=` — auto-indent
- `~` — toggle case

For block selection across lines:

1. `<C-v>` start block
2. Move (`jjj` or `<C-d>` or `/pattern` or `%`)
3. `$` go to end of lines
4. `A`, type text, `ESC` to append to all lines

## Key Properties

- Selection endpoint is marked at cursor position when entered
- Works with all operators: `d`, `y`, `c`, `gU`, `gu`, etc.
- `o` moves cursor to opposite end of selection
- `gv` reselects last visual selection

## Edge Cases & Gotchas

- Windows: may need `<C-q>` instead of `<C-v>` for block mode
- Block selection with `$` selects to end of longest line
- Visual mode is temporary — operators exit back to Normal

## Connections

- [[vim-modes|Vim Modes]] — Visual is one of the three main modes
- [[vim-macros|Macros]] — Record actions on visual selection
- [[vim-rectangular-blocks|Block Selection]] — Special case of visual block mode
- [[vim-text-objects|Text Objects]] — Alternative selection syntax