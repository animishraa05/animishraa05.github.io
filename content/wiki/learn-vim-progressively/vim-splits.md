---
title: Vim Splits
concept:
aliases: "[split, vsplit, window, pane, :split, :vsplit]"
tags: [dev, vim]
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



## Visual Explanation

```dot
digraph aliases____split__vsplit__window__pane___split___vsplit__ {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Aliases: "[Split, Vs\nInput"]
  B [label="Aliases: "[Split, Vs\nCore Mechanism"]
  C [label="Aliases: "[Split, Vs\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_aliases____split__vsplit__window__pane___split___vsplit__ {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Aliases: "[Split, Vs" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- [[vim-rectangular-blocks|Block Selection]] -- Shares window commands
- [[vim-basic-commands|Survival Commands]] -- Buffer commands apply in splits
- [[vim-visual-selection|Visual Selection]] -- Works across splits
- [[vim-modes|Vim Modes]] -- All commands work in split windows