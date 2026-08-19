---
concept: Computational Complexity Theory
aliases: [Complexity Theory]
tags: [theory, branch]
created: 2026-04-11
updated: 2026-04-11
confidence: high
status: stable
---

## The Problem

How efficiently can problems be solved? What resource limits (time, memory) are required?

## Core Idea

Computational complexity theory studies not just whether a problem can be solved, but how efficiently it can be solved. It classifies problems based on the resources required to solve them.

## How It Works

Two major aspects are considered:

- **Time complexity** - how many steps a computation takes
- **Space complexity** - how much memory is required

Problems are grouped into complexity classes (P, NP, PSPACE, etc.) based on resource requirements. The famous P vs NP question asks whether problems whose solutions can be verified quickly can also be solved quickly.

## Key Properties

- Studies efficiency of computation
- Considers both time and space resources
- Classifies problems into complexity classes
- Uses Big O notation for asymptotic analysis
- P vs NP is a major open problem and Millennium Prize Problem

## Connections

- Built from: [[time-complexity|Time Complexity]], [[space-complexity|Space Complexity]], [[big-o-notation|Big O Notation]]
- Builds into: [[p-vs-np-problem|P vs NP Problem]], [[np-completeness|NP-Complete]]
- Related: [[computability-theory|Computability Theory]], [[algorithm|Algorithm]], [[model-of-computation|Model of Computation]]

## Edge Cases & Gotchas

- A problem being "hard" doesn't mean it's impossible—just that it requires lots of resources
- Polynomial vs exponential time is a crucial distinction in practice

## Sources

- [[theory-of-computation-wikipedia|Theory of computation - Wikipedia]]

## Why This Matters

Complexity theory guides algorithm design and informs which problems are tractable in practice. The P vs NP problem is one of the most important open questions in computer science.
