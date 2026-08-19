---
title: "Basic Operators in Relational Algebra"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Basic Operators in Relational Algebra
The Relational Model is a way of structuring data using relations, which are a collection of tuples that have the same attributes. Relational Algebra is a procedural query language that takes relations as input and returns relations as output. Here, we'll explore the basic operators of Relational Algebra using below tables.

Table 1: STUDENT_SPORTS

| ROLL_NO | SPORTS |
| --- | --- |
| 1 | Badminton |
| 2 | Cricket |
| 2 | Badminton |
| 4 | Badminton |

Table 2: EMPLOYEE

| EMP_NO | NAME | ADDRESS | PHONE | AGE |
| --- | --- | --- | --- | --- |
| 1 | RAM | DELHI | 9455123451 | 18 |
| 5 | NARESH | HISAR | 9782918192 | 22 |
| 6 | SWETA | RANCHI | 9852617621 | 21 |
| 4 | SURESH | DELHI | 9156768971 | 18 |

Table 3: STUDENT

| ROLL_NO | NAME | ADDRESS | PHONE | AGE |
| --- | --- | --- | --- | --- |
| 1 | RAM | DELHI | 9455123451 | 18 |
| 2 | RAMESH | GURGAON | 9652431543 | 18 |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 |
| 4 | SURESH | DELHI | 9156768971 | 18 |

## 1. Selection operator (σ)

Selection operator is used to selecting tuples from a relation based on some condition.

Syntax:

> σ (Condition)(Relation Name)

σ (Condition)(Relation Name)

Extract students whose age is greater than 18 from STUDENT relation given in Table 3

> σ (AGE>18)(STUDENT)

σ (AGE>18)(STUDENT)

Note: SELECT operation does not show any result, the projection operator must be called before the selection operator to generate or project the result. So, the correct syntax to generate the result is:

> ∏(σ(AGE>18) (STUDENT))

∏(σ(AGE>18) (STUDENT))

Result:

| ROLL_NO | NAME | ADDRESS | PHONE | AGE |
| --- | --- | --- | --- | --- |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 |

## 2. Projection Operator (∏)

Projection operator is used to project particular columns from a relation.

Syntax:

> ∏(Column 1,Column 2….Column n)(Relation Name)

∏(Column 1,Column 2….Column n)(Relation Name)

Extract ROLL_NO and NAME from STUDENT relation given in Table 3

> ∏(ROLL_NO,NAME)(STUDENT)

∏(ROLL_NO,NAME)(STUDENT)

Result:

| ROLL_NO | NAME |
| --- | --- |
| 1 | RAM |
| 2 | RAMESH |
| 3 | SUJIT |
| 4 | SURESH |

Note: If the resultant relation after projection has duplicate rows, it will be removed. For Example ∏(ADDRESS)(STUDENT) will remove one duplicate row with the value DELHI and return three rows.

## 3. Cross Product(X)

Cross product is used to join two relations. For every row of Relation1, each row of Relation2 is concatenated. If Relation1 has m tuples and and Relation2 has n tuples, cross product of Relation1 and Relation2 will have m x n tuples.

Syntax:

> Relation1 X Relation2

Relation1 X Relation2

To apply Cross Product on STUDENT relation given in Table 1 and STUDENT_SPORTS relation given in Table 2,

> STUDENT X STUDENT_SPORTS

STUDENT X STUDENT_SPORTS

Result:

| ROLL_NO | NAME | ADDRESS | PHONE | AGE | ROLL_NO | SPORTS |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | RAM | DELHI | 9455123451 | 18 | 1 | Badminton |
| 1 | RAM | DELHI | 9455123451 | 18 | 2 | Cricket |
| 1 | RAM | DELHI | 9455123451 | 18 | 2 | Badminton |
| 1 | RAM | DELHI | 9455123451 | 18 | 4 | Badminton |
| 2 | RAMESH | GURGAON | 9652431543 | 18 | 1 | Badminton |
| 2 | RAMESH | GURGAON | 9652431543 | 18 | 2 | Cricket |
| 2 | RAMESH | GURGAON | 9652431543 | 18 | 2 | Badminton |
| 2 | RAMESH | GURGAON | 9652431543 | 18 | 4 | Badminton |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 | 1 | Badminton |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 | 2 | Cricket |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 | 2 | Badminton |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 | 4 | Badminton |
| 4 | SURESH | DELHI | 9156768971 | 18 | 1 | Badminton |
| 4 | SURESH | DELHI | 9156768971 | 18 | 2 | Cricket |
| 4 | SURESH | DELHI | 9156768971 | 18 | 2 | Badminton |
| 4 | SURESH | DELHI | 9156768971 | 18 | 4 | Badminton |

## 4. Union (U)

Union on two relations R1 and R2 can only be computed if R1 and R2 are union compatible (These two relations should have the same number of attributes and corresponding attributes in two relations have the same domain). Union operator when applied on two relations R1 and R2 will give a relation with tuples that are either in R1 or in R2. The tuples which are in both R1 and R2 will appear only once in the result relation.

Syntax:

> Relation1 U Relation2

Relation1 U Relation2

Find the person who is either student or employees, we can use Union operators like:

> STUDENT U EMPLOYEE

STUDENT U EMPLOYEE

RESULT:

| ROLL_NO | NAME | ADDRESS | PHONE | AGE |
| --- | --- | --- | --- | --- |
| 1 | RAM | DELHI | 9455123451 | 18 |
| 2 | RAMESH | GURGAON | 9652431543 | 18 |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 |
| 4 | SURESH | DELHI | 9156768971 | 18 |
| 5 | NARESH | HISAR | 9782918192 | 22 |
| 6 | SWETA | RANCHI | 9852617621 | 21 |

## 5. Minus (-) or Set Difference

Minus on two relations R1 and R2 can only be computed if R1 and R2 are union compatible. Minus operator when applied on two relations as R1-R2 will give a relation with tuples that are in R1 but not in R2. Syntax:

> Relation1 - Relation2

Relation1 - Relation2

Find the person who is a student but not an employee, we can use minus operator like:

> STUDENT - EMPLOYEE

STUDENT - EMPLOYEE

Result:

| ROLL_NO | NAME | ADDRESS | PHONE | AGE |
| --- | --- | --- | --- | --- |
| 2 | RAMESH | GURGAON | 9652431543 | 18 |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 |

## 6. Rename(ρ)

Rename operator is used to rename a relation or its attributes for clarity or further operations.

Syntax:

> ρ(new_relation_name, original_relation)

ρ(new_relation_name, original_relation)

To rename STUDENT relation to STUDENT1, we can use rename operator like:

> ρ(STUDENT1, STUDENT)

ρ(STUDENT1, STUDENT)

If you want to create a relation STUDENT_NAMES with ROLL_NO and NAME from STUDENT, it can be done using rename operator as:

> ρ(STUDENT_NAMES, ∏(ROLL_NO, NAME)(STUDENT))

ρ(STUDENT_NAMES, ∏(ROLL_NO, NAME)(STUDENT))

### Extended Relational Algebra Operators

- Intersection (∩)
- Division (÷)
- Join Operations (⋈)
- Natural Join
- Theta Join
- Equi Join

These operators provide more functionality for complex queries in relational databases.