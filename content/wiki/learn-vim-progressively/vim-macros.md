---
title: Vim Macros
concept:
aliases: [macro, recording, qa, register, replay]
tags: [dev, vim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Repetition with `.` is limited to the last change. Complex multi-step sequences need more powerful automation.

## Core Idea

Macros record and replay sequences of Normal-mode commands using registers (a-z).

## How It Works

Recording workflow:

1. `qa` -- start recording to register `a` (shows `recording @a`)
2. Perform the sequence of commands
3. `q` -- stop recording
4. `@a` -- replay the macro
5. `@@` -- replay last executed macro

Example: Numbered list

1. Place cursor on line with `1`
2. `qaYp<C-a>q` -- record: yank line, paste, increment number, stop
3. `@a` -- writes 2 below 1
4. `@@` -- writes 3 below 2
5. `100@@` -- creates 1 through 103

## Key Properties

- Registers are named a-z (26 total)
- Uppercase registers append: `qA` appends to register `a`
- Macros persist until overwritten
- Works across files if registers are preserved

## Edge Cases & Gotchas

- Macros execute at Normal mode -- recording in Insert mode includes literal keystrokes
- `<C-a>` increments if cursor is on/on after a number
- `:reg` shows all register contents



## Visual Explanation

```dot
digraph aliases___macro__recording__qa__register__replay_ {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Aliases: [Macro, Rec\nInput"]
  B [label="Aliases: [Macro, Rec\nCore Mechanism"]
  C [label="Aliases: [Macro, Rec\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_aliases___macro__recording__qa__register__replay_ {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Aliases: [Macro, Rec" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- [[vim-repetition|Repetition]] -- Simpler than macros for single changes
- [[vim-modes|Vim Modes]] -- Recording works in Normal mode
- [[vim-visual-selection|Visual Selection]] -- Can record visual selections
- [[vim-rectangular-blocks|Block Selection]] -- Can be combined with macros