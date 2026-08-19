---
title: "Dependency Preserving Decomposition - DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Dependency Preserving Decomposition - DBMS
A decomposition of a relation R into R₁, R₂, …, Rₙ is dependency preserving if the union of functional dependencies on the decomposed relations is equivalent to the original set of functional dependencies F.

- Preserves original functional dependencies and allows easy enforcement without costly JOIN operations
- Ensures lossless join so the original relation can be reconstructed without data loss
- Supports normalization to higher normal forms (3NF/BCNF)
- Reduces redundancy, prevents data anomalies, and improves performance and data integrity

## Derivation of Dependency Preservation

A decomposition D={R1, R2,...,Rn } of R is dependency preserving with respect to a set of functional dependencies F if:

(F1 ∪ F2 ∪...∪ Fn )+ = F+

Consider a relation R→F with some functional dependencies.

If R is decomposed into R1 with FD {f1} and R2 with FD {f2}, then there are three cases:

- f 1 ∪ f 2 = F → Dependency preserving
- f 1 ∪ f 2 ⊂ 𝐹 → Not dependency preserving
- f 1 ∪ f 2 ⊃ 𝐹 → Not possible

## Problem: 1

Given relation R(A, B, C) with functional dependencies F = { A → B, B → C } and decomposition R₁(A, B), R₂(B, C), determine whether the decomposition is dependency preserving.

### Solution: Step 1: Project Dependencies

- On R₁(A, B): A → B
- On R₂(B, C): B → C

So, F′ = { A → B, B → C }

### Step 2: Find Closure of F′

From A → B and B → C, we get A → C

F′⁺ = { A → B, B → C, A → C }

### Step 3: Compare with Original Closure

Since F′⁺ = F⁺,

The decomposition is dependency preserving.

## Problem: 2

Given relation R(A, B, C, D) with functional dependencies F = { AB → C, C → D, D → A } and decomposition R₁(A, B, C), R₂(C, D), determine whether the decomposition is dependency preserving.

### Solution: Step 1: Project Dependencies

On R₁(A, B, C):

- AB → C (present)
- From C → D and D → A ⇒ C → A

So, F₁ = { AB → C, C → A }

On R₂(C, D):

- C → D

So, F₂ = { C → D }

### Step 2: Union of Dependencies

F₁ ∪ F₂ = { AB → C, C → A, C → D }

### Step 3: Check Original Dependencies

- AB → C
- C → D
- D → A (cannot be derived)

Since D → A ∉ (F₁ ∪ F₂)⁺,

The decomposition is NOT dependency preserving.

Question 1: Let R (A, B, C, D) be a relational schema with the following functional dependencies:

A → B, B → C, C → D and D → B. The decomposition of R into (A, B), (B, C), (B, D)

(A) Gives a lossless join, and is dependency preserving

(B) Gives a lossless join, but is not dependency preserving

(C) Does not give a lossless join, but is dependency preserving

(D) Does not give a lossless join and is not dependency preserving

Refer to this for a solution.Question 2 R(A, B, C, D) is a relation. Which of the following does not have a lossless join, dependency-preserving BCNF decomposition?

(A) A->B, B->CD

(B) A->B, B->C, C->D

(C) AB->C, C->AD

(D) A ->BCD

Refer to this for a solution.

Quiz of the previous year's GATE Questions.