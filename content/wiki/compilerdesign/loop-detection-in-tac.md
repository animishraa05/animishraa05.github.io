---
concept: Detection of a Loop in Three-Address Code
aliases: [loop detection, loop analysis, dominator-based loops]
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Loops are where programs spend most of their execution time. To optimize effectively (loop invariant code motion, induction variable elimination), the compiler must first identify which instructions belong to loops and what kind of loops they are.

## Core Idea

Loop detection in TAC identifies loop structures in the control-flow graph (CFG). A **loop** in the CFG is a set of nodes (basic blocks) where: every node can reach the loop header, and the header dominates all nodes in the loop. The key concept is **dominators** — node d dominates node n if every path from entry to n goes through d.

## How It Works

The compiler builds a control-flow graph from TAC instructions. It computes the **dominator tree** (which nodes dominate which). A **back edge** is identified when an edge from node n to node h has h dominating n. The loop consists of all nodes that can reach n without going through h. Natural loops have a single entry (the header) and are amenable to optimization.

## Visual Explanation

```dot
digraph loop_detection {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  subgraph cluster_cfg {
    label="Control-Flow Graph (TAC Basic Blocks)"
    style=dashed

    Entry [label="B1: Entry"]
    Header [label="B2: Loop Header\n(L1: t1 = i < n)" fillcolor="#ffd700"]
    Body1 [label="B3: Loop Body\n(sum = sum + a[i])"]
    Body2 [label="B4: i = i + 1"]
    Exit [label="B5: Continue"]

    Entry -> Header
    Header -> Body1 -> Body2 -> Header [label="back edge" color="red"]
    Header -> Exit [label="i >= n"]
  }

  DomTree [label="Dominator Tree:\nB1 dominates B2\nB2 dominates B3, B4, B5\nBack edge: B4 → B2\nLoop = {B2, B3, B4}"]

  CFG -> DomTree [style=dashed]
}
```

## Key Properties

- **Control-flow graph:** Nodes are basic blocks; edges are jumps
- **Dominator:** h dominates n if all paths from entry to n include h
- **Back edge:** Edge from n to h where h dominates n
- **Natural loop:** Header h + all nodes that can reach a back edge without passing through h
- **Nested loops:** A loop inside another — inner loop is optimized first

## Connections

- **Built from:** [[three-address-code|Three-Address Code]] — TAC provides the instruction sequence for CFG construction
- **Builds into:** [[code-optimization|Code Optimization]] — loop detection enables loop optimizations
- **Related:** [[data-flow-analysis|Data Flow Analysis]] — data-flow analysis often computes loop information
- **Related:** [[intermediate-code-generation|Intermediate Code Generation]] — TAC enables loop detection at the IR level
- **Related:** [[code-generator-design-issues|Issues in Code Generator Design]] — code generators must be aware of loop structure for register allocation

## Edge Cases & Gotchas

- **Irreducible loops:** Multiple entry points (from goto) — cannot be identified as natural loops, require special handling
- **Outer vs inner loops:** When loops are nested, the inner loop should be optimized first (maximizes benefit)
- **Infinite loops:** A loop with no exit edge — the compiler must detect this to avoid infinite optimization
- **Loop-invariant code:** Instructions inside the loop that produce the same value every iteration — should be moved to the pre-header

## Sources

- [[compilerdesign-summary|Compiler Design Tutorial]] — covers loop detection in three-address code
