---
concept: P vs NP Problem
aliases: [P = NP Question, P NP Problem]
tags: [theory, open-problem]
created: 2026-04-11
updated: 2026-04-11
---

## The Problem

If you can verify a solution quickly, can you also find a solution quickly?

## Core Idea

The P vs NP problem asks whether every problem whose solution can be verified in polynomial time can also be solved in polynomial time. It is one of the seven Millennium Prize Problems with a $1 million reward.

## How It Works

- **P (Polynomial)** - problems solvable in polynomial time
- **NP (Non-deterministic Polynomial)** - problems verifiable in polynomial time

All P problems are in NP, but whether NP ⊆ P (i.e., P = NP) is unknown. If P = NP, problems like factorization, SAT, and many optimization problems would become efficiently solvable.

## Key Properties

- One of the seven Millennium Prize Problems
- Asks if P = NP
- If true, many hard problems become easy
- Current consensus: probably false
- Has profound implications for cryptography, optimization, AI



## Visual Explanation

```dot
digraph P_vs_NP_Problem {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="P Vs Np Problem\nInput"]
  B [label="P Vs Np Problem\nCore Mechanism"]
  C [label="P Vs Np Problem\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_P_vs_NP_Problem {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="P Vs Np Problem" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[computational-complexity-theory|Computational Complexity Theory]], [[np-complete|NP-Complete]]
- Related: [[polynomial-time|Polynomial Time]], [[nondeterministic-turing-machine|Non-deterministic Turing Machine]], [[sat-problem|SAT Problem]]

## Edge Cases & Gotchas

- Even if P = NP, the polynomial might be too large to be practical
- Cryptography assumes P ≠ NP
## Why This Matters

The P vs NP problem is the most important open problem in computer science. Its resolution would revolutionize computing, cryptography, and our ability to solve complex optimization problems.