---
title: "Armstrong's Axioms in Functional Dependency in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Armstrong's Axioms in Functional Dependency in DBMS
Armstrong's Axioms refer to a set of inference rules that are used to [[test]] the logical implication of functional dependencies.

- Given a set of functional dependencies F, the closure of F (denoted as F+) is the set of all functional dependencies logically implied by F.
- Armstrong's Axioms, when applied repeatedly, help generate the closure of functional dependencies.
- These axioms are fundamental in determining functional dependencies in databases and are used to derive conclusions about the relationships between attributes.

The following are different axioms.

![axioms](images/axioms.webp)

- Axiom of Reflexivity: If A is a set of attributes and B is a subset of A, then A holds B. If B⊆A then A→B. This property is trivial property.
- Axiom of Augmentation: If A→B holds and Y is the attribute set, then AY→BY also holds. That is adding attributes to dependencies, does not change the basic dependencies. If A→B, then AC→BC for any C.
- Axiom of Transitivity: Same as the transitive rule in algebra, if A→B holds and B→C holds, then A→C also holds. In the dependency A→B we say that A functionally determines B. For example, if X→Y and Y→Z, then X→Z.

Example: Let's assume the following functional dependencies:

> {A} → {B}{B} → {C}{A, C} → {D}

{A} → {B}{B} → {C}{A, C} → {D}

1. Reflexivity: Since any set of attributes determines its subset, we can immediately infer the following:

- {A} → {A} (A set always determines itself).
- {B} → {B}.
- {A, C} → {A}.

2. Augmentation: If we know that {A} → {B}, we can add the same attribute (or set of attributes) to both sides:

- From {A} → {B}, we can augment both sides with {C}: {A, C} → {B, C}.
- From {B} → {C}, we can augment both sides with {A}: {A, B} → {A, C}.

3. Transitivity: If we know {A} → {B} and {B} → {C}, we can infer that:

- {A} → {C} (Using transitivity: {A} → {B} and {B} → {C}).

Although Armstrong's axioms are sound and complete, there are additional rules for functional dependencies that are derived from them. These rules are introduced to simplify operations and make the process easier.

### Secondary Rules

These rules can be derived from the above axioms.

- Union: If A→B holds and A→C holds, then A→BC holds. If X→Y and X→Z then X→YZ.
- Composition: If A→B and X→Y hold, then AX→BY holds.
- Decomposition: If A→BC holds then A→B and A→C hold. If X→YZ then X→Y and X→Z.
- Pseudo Transitivity: If A→B holds and BC→D holds, then AC→D holds. If X→Y and YZ→W then XZ→W.

Example: Let's assume we have the following functional dependencies in a relation schema:

> {A} → {B}{A} → {C}{X} → {Y}{Y, Z} → {W}

{A} → {B}{A} → {C}{X} → {Y}{Y, Z} → {W}

Now, let's apply the Secondary Rules to derive new functional dependencies.

1. Union Rule: If A → B and A → C, then by the Union Rule, we can infer:

- A → BC This means if A determines B and C individually, it also determines their combination, BC.

2. Composition Rule: Since A → B and X → Y hold, then by the Composition Rule, we can infer:

- AX → BY

3. Decomposition Rule: Using the dependency A → BC (derived in step 1), the Decomposition Rule allows us to break it back down to infer:

- A → B and A → C

4. Pseudo Transitivity Rule: Since X → Y and YZ → W hold, the Pseudo Transitivity Rule, rule allows us to substitute $Y$ with $X$ in the second dependency to infer:

- XZ → W

### Armstrong Relation

An Armstrong Relation for a set of functional dependencies F is a relation (table) that perfectly represents F. It must satisfy all functional dependencies in the F+ Closure and strictly violate all functional dependencies that are NOT in the F+ Closure. In a given set of dependencies, the size of the minimum Armstrong Relation can be an exponential function of the number of attributes present in the dependency under consideration.

### Why Armstrong Axioms Are Considered Sound and Complete?

- Soundness: Armstrong's axioms are sound because any functional dependency inferred using them will always be valid and hold true in every relation state that satisfies the original set of dependencies.
- Completeness: Armstrong's axioms are complete because applying them repeatedly will generate all possible functional dependencies that can be derived from the original set, ensuring no dependencies are missed.