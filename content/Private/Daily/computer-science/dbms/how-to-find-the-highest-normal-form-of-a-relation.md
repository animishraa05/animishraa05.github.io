---
title: "How to find the highest normal form of a relation"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# How to find the highest normal form of a relation
Normalization is the process of structuring data in a database by creating tables and defining relationships between them. This process ensures data consistency, data protection and efficient storage by minimizing redundancy and dependency anomalies.

- To determine how well a table is structured, we check which is the highest normal form (1NF, 2NF, 3NF or BCNF) that the relation satisfies.
- Every table in a relational database is typically assumed to be in the First Normal Form (1NF), which means that all its attributes contain atomic (indivisible) values - no multiple or composite values are allowed in a single cell.

> Note: To understand this topic, you should have a basic idea about Functional Dependency , Candidate keys and Normal forms .

Note: To understand this topic, you should have a basic idea about Functional Dependency , Candidate keys and Normal forms .

## Normal Forms

### 1. First Normal Form (1NF):

A relation is in 1NF if all attributes contain atomic (single) values - no repeating groups or multi-valued attributes are allowed.

### 2. Second Normal Form (2NF):

A relation is in 2NF if:

- It is already in 1NF and
- It has no partial dependencies, i.e., no non-prime attribute depends only on part of a composite key.

### 3. Third Normal Form (3NF):

A relation is in 3NF if:

- It is already in 2NF and
- It has no transitive dependencies, i.e., no non-prime attribute depends on another non-prime attribute.

### 4. Boyce-Codd Normal Form (BCNF):

A relation is in BCNF if:

- It is already in 3NF and
- For every functional dependency (X -> Y), X is a super key.

> Read more about Normal Forms

Read more about Normal Forms

## Steps to Find the Highest Normal Form of a Relation

To systematically determine the highest normal form, follow these steps:

### Step 1: Find All Candidate Keys

Identify all candidate keys of the relation using the given set of functional dependencies (FDs).

> Example: If (AC)+ = {A, B, C, D, E}, then AC is a candidate key because its closure includes all attributes.

Example: If (AC)+ = {A, B, C, D, E}, then AC is a candidate key because its closure includes all attributes.

### Step 2: Identify Prime and Non-Prime Attributes

- Prime Attributes: Attributes that are part of any candidate key.
- Non-Prime Attributes: Attributes that are not part of any candidate key.

### Step 3: Check for 1NF

- Ensure that all columns contain atomic values only.
- If there are multi-valued or composite attributes, it’s not in 1NF.
- Example of non-atomic value: {Math, Science}.

> Note: If all attributes are single-valued, the relation is in 1NF.

Note: If all attributes are single-valued, the relation is in 1NF.

### Step 4: Check for 2NF

- The relation must already be in 1NF.
- Ensure there are no partial dependencies - a non-prime attribute depending on part of a composite key.

> Note: If any partial dependency exists, the relation is not in 2NF. Otherwise, it is in 2NF.

Note: If any partial dependency exists, the relation is not in 2NF. Otherwise, it is in 2NF.

### Step 5: Check for 3NF

- The relation must already be in 2NF.
- Ensure there are no transitive dependencies, i.e., non-prime attributes should not depend on other non-prime attributes.

To satisfy 3NF, for every functional dependency X -> Y:

- Either X is a super key or
- Y is a prime attribute.

> Note: If any dependency violates this, the relation is not in 3NF.

Note: If any dependency violates this, the relation is not in 3NF.

### Step 6: Check for BCNF

- The relation must already be in 3NF.
- For every functional dependency X -> Y, the determinant X must be a super key.

> Note: If any FD has a determinant that is not a super key, the relation is not in BCNF.

Note: If any FD has a determinant that is not a super key, the relation is not in BCNF.

## Examples

### Example 1: Given: R(A, B, C, D, E), FDs = { A -> D, B -> A, BC -> D, AC -> BE }

Step 1:

- (AC)+ = {A, B, C, D, E} -> Candidate Key = AC
- Also, since B -> A, replacing A in AC gives BC as another candidate key.
- Candidate Keys = {AC, BC}

Step 2:

- Prime attributes = {A, B, C}
- Non-prime attributes = {D, E}

Step 3: R is in 1NF - all attributes are atomic.

Step 4 (2NF check): A -> D is a partial dependency (A ⊂ AC and D is non-prime). -> Violates 2NF.

> Highest Normal Form = 1NF

Highest Normal Form = 1NF

### Example 2: R(A, B, C, D, E), FDs = { BC -> D, AC -> BE, B -> E }

Step 1: (AC)+ = {A, B, C, D, E} -> Candidate Key = ACStep 2:

- Prime attributes = {A, C}
- Non-prime attributes = {B, D, E}

Step 3: R is in 1NF (no multi-valued attributes).Step 4 (2NF check): All dependencies are full, none partial -> Relation is in 2NF.Step 5 (3NF check): B -> E violates 3NF (B is not super key, E is non-prime) -> Violates 3NF.

> Highest Normal Form = 2NF

Highest Normal Form = 2NF

## Key Points to Remember

- Always start checking from 1NF -> 2NF -> 3NF -> BCNF in order.
- 1NF: Remove multi-valued attributes.
- 2NF: Remove partial dependencies.
- 3NF: Remove transitive dependencies.
- BCNF: Ensure every determinant is a super key.

> Note: The form where the relation first fails to satisfy conditions determines the highest normal form.

Note: The form where the relation first fails to satisfy conditions determines the highest normal form.