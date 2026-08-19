---
title: "Lossless Join and Dependency Preserving Decomposition"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Lossless Join and Dependency Preserving Decomposition
Decomposition of a relation is done when a relation in a relational model is not in appropriate normal form. Relation R is decomposed into two or more relations if decomposition is lossless join as well as dependency preserving.

## Lossless Join Decomposition

If we decompose a relation R into relations R1 and R2,

```
Decomposition is lossy if R1 ⋈ R2 ⊃ RDecomposition is lossless if R1 ⋈ R2 = R
```

To check for lossless join decomposition using the FD set, the following conditions must hold:

1. The Union of Attributes of R1 and R2 must be equal to the attribute of R. Each attribute of R must be either in R1 or in R2.

```
 Att(R1) U Att(R2) = Att(R)
```

2. The intersection of Attributes of R1 and R2 must not be NULL.

```
 Att(R1) ∩ Att(R2) ≠ Φ
```

3. The common attribute must be a key for at least one relation (R1 or R2)

```
 Att(R1) ∩ Att(R2) -> Att(R1) or Att(R1) ∩ Att(R2) -> Att(R2)
```

For Example, A relation R (A, B, C, D) with FD set{A->BC} is decomposed into R1(ABC) and R2(AD) which is a lossless join decomposition as:

1. First condition holds true as Att(R1) U Att(R2) = (ABC) U (AD) = (ABCD) = Att(R).
2. Second condition holds true as Att(R1) ∩ Att(R2) = (ABC) ∩ (AD) ≠ Φ
3. The third condition holds as Att(R1) ∩ Att(R2) = A is a key of R1(ABC) because A->BC is given.

## Dependency Preserving Decomposition

If we decompose a relation R into relations R1 and R2, All dependencies of R either must be a part of R1 or R2 or must be derivable from a combination of functional dependency of R1 and R2. For Example, A relation R (A, B, C, D) with FD set{A->BC} is decomposed into R1(ABC) and R2(AD) which is dependency preserving because FD A->BC is a part of R1(ABC).

## Advantages of Lossless Join and Dependency Preserving Decomposition

- Improved Data Integrity: Lossless join and dependency preserving decomposition help to maintain the data integrity of the original relation by ensuring that all dependencies are preserved.
- Reduced Data Redundancy: These techniques help to reduce data redundancy by breaking down a relation into smaller, more manageable relations.
- Improved Query Performance: By breaking down a relation into smaller, more focused relations, query performance can be improved.
- Easier Maintenance and Updates: The smaller, more focused relations are easier to maintain and update than the original relation, making it easier to modify the database schema and update the data.
- Better Flexibility: Lossless join and dependency preserving decomposition can improve the flexibility of the database system by allowing for easier modification of the schema.

## Disadvantages of Lossless Join and Dependency Preserving Decomposition

- Increased Complexity: Lossless join and dependency-preserving decomposition can increase the complexity of the database system, making it harder to understand and manage.
- Costly: Decomposing relations can be costly, especially if the database is large and complex. This can require additional resources, such as hardware and personnel.
- Reduced Performance: Although query performance can be improved in some cases, in others, lossless join and dependency-preserving decomposition can result in reduced query performance due to the need for additional join operations.
- Limited Scalability: These techniques may not scale well in larger databases, as the number of smaller, focused relations can become unwieldy.

### GATE Question

Consider a schema R(A, B, C, D) and functional dependencies A->B and C->D. Then the decomposition of R into R1(AB) and R2(CD) is [GATE-CS-2001]

(A) dependency preserving and lossless join

(B) lossless join but not dependency preserving

(C) dependency preserving but not lossless join

(D) not dependency preserving and not lossless join

Answer:

For lossless join decomposition, these three conditions must hold:

```
Att(R1) U Att(R2) = ABCD = Att(R)Att(R1) ∩ Att(R2) = Φ, which violates the condition of lossless join decomposition. Hence the decomposition is not lossless.
```

For dependency preserving decomposition, A->B can be ensured in R1(AB) and C->D can be ensured in R2(CD). Hence it is dependency preserving decomposition. So, the correct option is C.