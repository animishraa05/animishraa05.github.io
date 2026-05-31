---
concept: Basic Blocks
aliases: [basic block, straight-line code, linear code segment]
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Three-address code is a flat sequence of instructions, but optimizations need to reason about program structure. A program has branches and joins — different paths of execution. Before analysis can begin, the compiler must partition TAC into straight-line segments where control enters at the top and leaves at the bottom, with no internal branches.

## Core Idea

A basic block is a sequence of consecutive three-address code instructions with a single entry point (the first instruction) and a single exit point (the last instruction). No jumps enter or leave the block except at the entry and exit. Within a basic block, if one instruction executes, all execute. Basic blocks form the nodes of the control-flow graph.

## How It Works

Basic blocks are identified by finding **leaders** — the first instruction of a block. Leaders are: the first instruction of the program, any instruction that is the target of a jump, and any instruction immediately following a jump. Starting from each leader, the block extends until another leader is reached (or the end). The block includes all instructions from the leader up to (but not including) the next leader.

## Visual Explanation

```dot
digraph basic_blocks {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  TAC [label="TAC:\n1: t1 = a + b\n2: t2 = c * d\n3: if t1 < t2 goto L\n4: t3 = t1 - t2\n5: goto M\nL: 6: t3 = t2 - t1\nM: 7: result = t3"]
  BB1 [label="Basic Block B1:\n1: t1 = a + b\n2: t2 = c * d" fillcolor="#cce5ff"]
  BB2 [label="Basic Block B2:\n3: if t1 < t2 goto L" fillcolor="#cce5ff"]
  BB3 [label="Basic Block B3:\n4: t3 = t1 - t2\n5: goto M" fillcolor="#cce5ff"]
  BB4 [label="Basic Block B4:\n6: t3 = t2 - t1" fillcolor="#cce5ff"]
  BB5 [label="Basic Block B5:\n7: result = t3" fillcolor="#cce5ff"]

  TAC -> BB1
  BB1 -> BB2
  BB2 -> BB3 [label="false"]
  BB2 -> BB4 [label="true (goto L)"]
  BB3 -> BB5
  BB4 -> BB5
}
```

## Semantic Network

```dot
graph semantic_bb {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Basic\nBlocks" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Three-Address\nCode" fillcolor="#cce5ff"]
  OUT1 [label="Control Flow\nGraph" fillcolor="#d4edda"]
  OUT2 [label="Data Flow\nAnalysis" fillcolor="#d4edda"]
  REL1 [label="Code\nOptimization" fillcolor="#f0f0f0"]
  REL2 [label="Intermediate\nCode Generation" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from — TAC partitioned into blocks" style=dashed]
  THIS -- OUT1 [label="builds into — blocks are CFG nodes"]
  THIS -- OUT2 [label="builds into — DFA operates on blocks"]
  THIS -- REL1 [label="related — optimizations work per block"]
  THIS -- REL2 [label="related"]
}
```

## Key Properties

- **Single entry, single exit:** Control enters at the top and leaves at the bottom
- **Leader-based identification:** Partition TAC by finding leaders (first instruction, jump targets, post-jump instructions)
- **Sequential execution:** If the first instruction executes, all instructions execute (no internal branches)
- **Optimization unit:** Many optimizations (constant propagation, dead code elimination) operate within a single basic block
- **CFG nodes:** Basic blocks are the vertices of the control-flow graph

## Connections

- **Built from:** [[three-address-code|Three-Address Code]] — TAC is partitioned into basic blocks
- **Builds into:** [[control-flow-graph|Control Flow Graph]] — basic blocks form the nodes of the CFG
- **Builds into:** [[data-flow-analysis|Data Flow Analysis]] — DFA uses GEN/KILL sets per basic block
- **Related:** [[code-optimization|Code Optimization]] — many local optimizations operate within a single block
- **Related:** [[intermediate-code-generation|Intermediate Code Generation]] — ICG produces the TAC that gets partitioned

## Edge Cases & Gotchas

- **Empty blocks:** A leader may be immediately followed by another leader, creating an empty basic block — rare but possible
- **Overlapping blocks:** Blocks cannot overlap — each instruction belongs to exactly one block
- **Critical edges:** Edges from a block with multiple successors to a block with multiple predecessors are called critical edges — they complicate optimization
- **Unreachable code:** Instructions after an unconditional jump (but before the next leader) are unreachable — dead code elimination can remove them

## Sources

- [[cd2-summary|Compiler Design for GATE Exam]] — covers basic blocks in intermediate code generation
