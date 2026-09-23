---
title: Vim Rectangular Blocks
concept:
aliases: [block selection, rectangular blocks, column selection, Ctrl-v]
tags: [dev, vim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Editing multiple lines at the same column is common (indentation, commenting). Character/line selection can't handle this -- you need column-based selection.

## Core Idea

Block-wise visual mode (`<C-v>`) selects rectangular columns across multiple lines. This enables simultaneous edits to many lines at once.

## How It Works

Entry: `<C-v>` from Normal mode (or `<C-q>` on Windows if clipboard interferes)

Use cases:

- **Comment multiple lines**:
  1. `0` -- go to first column
  2. `<C-v>` -- start block selection
  3. `<C-d>` -- move down (or `jjj`, `%`, etc.)
  4. `I-- [ESC]` -- insert comment prefix on each line

- **Append to all lines**:
  1. `<C-v>` select blocks
  2. Move to target lines
  3. `$` -- extend to end of lines
  4. `A`, type text, `ESC`

Window commands:

- `<C-w><dir>` -- switch split (dir = h,j,k,l or arrows)
- `<C-w>_` -- maximize horizontal split
- `<C-w>|` -- maximize vertical split
- `<C-w>+` / `<C-w->` -- resize splits

## Key Properties

- Block selection persists during operations
- All selected lines get the same edit
- Case matters: `<C-v>` is block, `V` is line, `v` is character
- Works with `:split` and `:vsplit` for window splits

## Edge Cases & Gotchas

- Windows: `<C-q>` if `<C-v>` is clipboard paste
- `$` selects to end of longest line, not each line individually
- Block selection combined with `A` appends at line ends



## Visual Explanation

```dot
digraph aliases___block_selection__rectangular_blocks__column_selection__Ctrl_v_ {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Aliases: [Block Sele\nInput"]
  B [label="Aliases: [Block Sele\nCore Mechanism"]
  C [label="Aliases: [Block Sele\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_aliases___block_selection__rectangular_blocks__column_selection__Ctrl_v_ {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Aliases: [Block Sele" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- [[vim-visual-selection|Visual Selection]] -- Block selection is a variant
- [[vim-macros|Macros]] -- Can record block selection operations
- [[vim-text-objects|Text Objects]] -- Alternative selection syntax
- [[vim-splits|Vim Splits]] -- Related window functionality