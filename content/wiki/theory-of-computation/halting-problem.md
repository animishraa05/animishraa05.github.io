---
concept: Halting Problem
aliases: [Halting Problem for Turing Machines]
tags: [theory, undecidability]
created: 2026-04-11
updated: 2026-04-11
confidence: high
status: stable
---

## The Problem

Is there an algorithm that can determine whether any arbitrary program will eventually halt or run forever?

## Core Idea

The halting problem asks: given a program and its input, will it terminate (halt) or run forever? Alan Turing proved in 1937 that no algorithm can solve this for all possible program-input pairs.

## How It Works

The proof uses self-reference and diagonalization:

1. Assume a hypothetical "halting solver" H(P, I) that returns "halts" or "loops forever"
2. Create a paradoxical program that does the opposite of what H predicts
3. Feed this program to itself → contradiction
4. Therefore, H cannot exist

This is one of the most important results in computability theory.

## Key Properties

- Proved undecidable by Alan Turing in 1937
- Example of a concrete problem that is easy to formulate but impossible to solve
- Foundation for much of computability theory
- Any problem that can encode the halting problem is also undecidable

## Connections

- Built from: [[turing-machine|Turing Machine]]
- Builds into: [[computability-theory|Computability Theory]], [[rices-theorem|Rice's Theorem]]
- Related: [[church-turing-thesis|Church-Turing Thesis]], [[undecidability|Undecidability]]

## Edge Cases & Gotchas

- The problem is undecidable for Turing machines, but some specific programs can be analyzed
- Knowing individual instances are solvable doesn't make the general problem solvable

## Sources

- [[theory-of-computation-wikipedia|Theory of computation - Wikipedia]]

## Why This Matters

The halting problem proves that there are limits to what algorithms can know. This fundamental result shapes how we think about program analysis, verification, and the boundaries of computation.
