---
concept: Constant Propagation
aliases: [constant folding, constant propagation, compile-time evaluation]
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Source code often contains expressions whose operands are all known at compile time — either literal constants or variables that can only hold one value. Evaluating these at runtime wastes cycles. The compiler should replace them with their computed values and propagate those values through subsequent uses.

## Core Idea

Constant propagation replaces variables whose values are known at compile time with their constant values, and constant folding evaluates constant expressions at compile time. If `x = 5` and later `y = x * 2`, the compiler replaces this with `y = 10`. This eliminates runtime computation and often enables further optimizations (dead code elimination, branch elimination).

## How It Works

The compiler tracks which variables hold known constant values at each program point. It starts by identifying assignments of constants to variables (`x = 5`). For each subsequent use of `x`, if no intervening assignment has changed `x`, it replaces `x` with `5`. When a constant expression is formed (e.g., `5 * 2`), constant folding evaluates it at compile time (`10`). This propagates forward — simplifications create more opportunities for propagation. Reaching-definitions analysis determines which assignments reach which uses.

## Visual Explanation

```dot
digraph constant_prop {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Before [label="Before CP+CF:\n  pi = 3.14\n  r  = 5\n  area = pi * r * r\n  if area > 100 goto L"]
  After [label="After CP+CF:\n  pi = 3.14\n  r  = 5\n  area = 78.5\n  if false goto L" fillcolor="#d4edda"]
  Folded [label="Further:\n  (dead branch eliminated)"]
  Eliminated [label="Result:\n  area = 78.5"]

  Before -> After
  After -> Folded [style=dashed]
  Folded -> Eliminated
}
```

## Semantic Network

```dot
graph semantic_const_prop {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Constant\nPropagation" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Code\nOptimization" fillcolor="#cce5ff"]
  PRE2 [label="Data Flow\nAnalysis" fillcolor="#cce5ff"]
  CON1 [label="Common Subexpr.\nElimination" fillcolor="#ffe5cc"]
  REL1 [label="Peephole\nOptimization" fillcolor="#f0f0f0"]
  REL2 [label="Basic\nBlocks" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from" style=dashed]
  THIS -- PRE2 [label="built from — uses reaching definitions"]
  THIS -- CON1 [label="contrasts with — CP is about constant values, not repeated expressions"]
  THIS -- REL1 [label="related — peephole can do local constant folding"]
  THIS -- REL2 [label="related — local CP works within a block"]
}
```

## Key Properties

- **Constant propagation:** Replacing variable uses with known constant values
- **Constant folding:** Evaluating constant expressions at compile time (e.g., `2 * 3.14` → `6.28`)
- **Cascading:** CP creates more constant expressions, CF evaluates them, creating more CP opportunities
- **Reaching definitions:** Used to determine which assignments reach which variable uses
- **Conditional branches:** CP can simplify conditional expressions, enabling dead branch elimination

## Connections

- **Built from:** [[code-optimization|Code Optimization]] — CP/CF is a fundamental optimization technique
- **Built from:** [[data-flow-analysis|Data Flow Analysis]] — reaching-definitions analysis drives global CP
- **Contrasts with:** [[common-subexpression-elimination|Common Subexpression Elimination]] — CP simplifies constant expressions; CSE eliminates redundant computations
- **Related:** [[peephole-optimization|Peephole Optimization]] — local constant folding can be done as a peephole optimization on target code
- **Related:** [[basic-blocks|Basic Blocks]] — local CP works within a single block; global CP needs the CFG

## Edge Cases & Gotchas

- **Over-approximation:** The analysis must be conservative — if a variable might have been modified (e.g., through a pointer), CP cannot assume its previous constant value
- **Conditional constant propagation:** When a variable is constant on one branch but not another, the analysis must handle this precisely
- **Sparse conditional constant propagation (SCCP):** A more powerful form that simultaneously tracks constants and reachability
- **Not always beneficial:** Propagating a constant may increase code size (different constants propagated to different uses) without runtime benefit

## Sources

- [[cd2-summary|Compiler Design for GATE Exam]] — covers constant propagation as a data-flow analysis and optimization technique
