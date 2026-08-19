---
title: "Tuple Relational Calculus (TRC) in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Tuple Relational Calculus (TRC) in DBMS
Tuple Relational [[calculus|Calculus]] (TRC) is a non-procedural query language used to retrieve data from relational databases by describing the properties of the required data (not how to fetch it). It is based on first-order predicate logic and uses tuple variables to represent rows of tables.

Syntax: The basic syntax of TRC is as follows:

> { t | P(t) }

{ t | P(t) }

- t: Tuple variable (row placeholder)
- P(t): Predicate condition to satisfy
- {}: Denotes a set of result tuples

### Logical Operators in TRC:

- ∧: AND
- ∨: OR
- ¬: NOT

### Quantifiers:

- ∃ t ∈ r (Q(t)) → There exists a tuple t in relation r satisfying predicate Q(t)
- ∀ t ∈ r (Q(t)) → For all tuples t in relation r, predicate Q(t) holds

For example, let's say we have a table called "Employees" with the following attributes:

| Employee ID |
| --- |
| Name |
| Salary |
| Department ID |

To retrieve the names of all employees who earn more than $50,000 per year, we can use the following TRC query:

> { t | Employees(t) ∧ t.Salary > 50000 }

{ t | Employees(t) ∧ t.Salary > 50000 }

Explanation:

- Employees(t) means t is a tuple from the Employees table.
- ∧ (AND) is used to add a condition on salary.
- The result is a set of tuples where each employee earns more than $50,000.

TRC is non-procedural - it specifies what data to retrieve, not how to retrieve it.

While expressive, TRC is more abstract and mainly used in academic or theoretical contexts, not practical database systems.

## Tuple Relational Query

In Tuple [[calculus|Calculus]], a query is expressed as

> {t| P(t)}

{t| P(t)}

- t represents the resulting tuples.
- P(t) is a predicate (a condition that must be true for t to be included in the resul

P(t) may have various conditions logically combined with OR (∨), AND (∧), NOT(¬).

It also uses quantifiers:

- ∃ t ∈ r (Q(t)) = ”there exists” a tuple in t in relation r such that predicate Q(t) is true.
- ∀ t ∈ r (Q(t)) = Q(t) is true "for all" tuples in relation r.

## Domain Relational Calculus (DRC)

Domain Relational [[calculus|Calculus]] is similar to Tuple Relational [[calculus|Calculus]], where it makes a list of the attributes that are to be chosen from the relations as per the conditions.

> {<a1,a2,a3,.....an> | P(a1,a2,a3,.....an)}

{<a1,a2,a3,.....an> | P(a1,a2,a3,.....an)}

where a1,a2,...an are the attributes of the relation and P is the condition.

## Tuple Relational Calculus Examples

Table Customer

| Customer name | Street | City |
| --- | --- | --- |
| Saurabh | A7 | Patiala |
| Mehak | B6 | Jalandhar |
| Sumiti | D9 | Ludhiana |
| Ria | A5 | Patiala |

Table Branch

| Branch name | Branch City |
| --- | --- |
| ABC | Patiala |
| DEF | Ludhiana |
| GHI | Jalandhar |

Table Account

| Account number | Branch name | Balance |
| --- | --- | --- |
| 1111 | ABC | 50000 |
| 1112 | DEF | 10000 |
| 1113 | GHI | 9000 |
| 1114 | ABC | 7000 |

Table Loan

| Loan number | Branch name | Amount |
| --- | --- | --- |
| L33 | ABC | 10000 |
| L35 | DEF | 15000 |
| L49 | GHI | 9000 |
| L98 | DEF | 65000 |

Table Borrower

| Customer name | Loan number |
| --- | --- |
| Saurabh | L33 |
| Mehak | L49 |
| Ria | L98 |

Table Depositor

| Customer name | Account number |
| --- | --- |
| Saurabh | 1111 |
| Mehak | 1113 |
| Suniti | 1114 |

Example 1: Find the loan number, branch, and amount of loans greater than or equal to 10000 amount.

> {t| t ∈ loan ∧ t[amount]>=10000}

{t| t ∈ loan ∧ t[amount]>=10000}

Resulting relation:

| Loan number | Branch name | Amount |
| --- | --- | --- |
| L33 | ABC | 10000 |
| L35 | DEF | 15000 |
| L98 | DEF | 65000 |

In the above query, t[amount] is known as a tuple variable.

Example 2: Find the loan number for each loan of an amount greater or equal to 10000.

> {t| ∃ s ∈ loan(t[loan number] = s[loan number] ∧ s[amount]>=10000)}

{t| ∃ s ∈ loan(t[loan number] = s[loan number] ∧ s[amount]>=10000)}

Resulting relation:

| Loan number |
| --- |
| L33 |
| L35 |
| L98 |

Example 3: Find the names of all customers who have a loan and an account at the bank.

> {t | ∃ s ∈ borrower( t[customer-name] = s[customer-name]) ∧ ∃ u ∈ depositor( t[customer-name] = u[customer-name])}

{t | ∃ s ∈ borrower( t[customer-name] = s[customer-name]) ∧ ∃ u ∈ depositor( t[customer-name] = u[customer-name])}

Resulting relation:

| Customer name |
| --- |
| Saurabh |
| Mehak |

Example 4: Find the names of all customers having a loan at the "ABC" branch.

> {t | ∃ s ∈ borrower(t[customer-name] = s[customer-name] ∧ ∃ u ∈ loan(u[branch-name] = “ABC” ∧ u[loan-number] = s[loan-number]))}

{t | ∃ s ∈ borrower(t[customer-name] = s[customer-name] ∧ ∃ u ∈ loan(u[branch-name] = “ABC” ∧ u[loan-number] = s[loan-number]))}

Resulting relation:

| Customer name |
| --- |
| Saurabh |

## Key Concepts:

- TRC does not specify execution steps, only the condition of result.
- It focuses on what to retrieve, not how.
- Based on variables, predicates, and quantifiers.
- More theoretical, often used in database theory, formal methods, and GATE questions.

## Comparison: TRC vs Relational Algebra

| Feature | TRC | Relational Algebra |
| --- | --- | --- |
| Type | Non-procedural | Procedural |
| Focus | What to retrieve | How to retrieve |
| Expression Style | Logical expressions | Set-based operators |
| Execution | Abstract, not directly executable | Directly convertible to query |
| Use in DBMS | Theoretical foundation | Basis for query execution |

Feature

TRC

Relational Algebra

Type

Non-procedural

Procedural

Focus

What to retrieve

How to retrieve

Expression Style

Logical expressions

Set-based operators

Execution

Abstract, not directly executable

Directly convertible to query

Use in DBMS

Theoretical foundation

## Important Points to Remember:

- TRC is declarative: Describes result conditions, not how to get them.
- Uses tuple variables referring to rows.
- Allows quantifiers and logic operators for flexible querying.
- Similar to mathematical set notation.
- Does not include built-in operators like SQL or Relational Algebra.
- Each TRC query defines a set of tuples satisfying given predicates.
- Safer queries (domain-independent) always produce meaningful results regardless of database size or content.