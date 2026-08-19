---
title: "Boolean Algebra"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Boolean Algebra
Boolean Algebra is a branch of mathematics that deals with variables that have only two possible values — typically denoted as 0 and 1 (or false and true). It focuses on binary variables and logic operations such as AND, OR, and NOT.

- Boolean Algebra provides a formal way to represent and manipulate logical statements and binary operations.
- It is the mathematical foundation of digital electronics, computer logic, and programming conditions.

## Logical Operations

Various operations are used in Boolean algebra, but the basic operations that form the base of Boolean Algebra are:

> • Negation or NOT Operation• Conjunction or AND Operation• Disjunction or OR Operation

• Negation or NOT Operation• Conjunction or AND Operation• Disjunction or OR Operation

![Boolean-Algebra-Operations](Daily/computer-science/digital-logic/images/boolean-algebra-operations.png)

These operations have their oymbols and precedence ,and the table added below shows the ssymbolsand the precedence of these operators.

| Operator | Symbol | Precedence |
| --- | --- | --- |
| NOT | ' (or) ⇁ | First |
| AND | . (or) ∧ | Second |
| OR | + (or) ∨ | Third |

Operator

Symbol

Precedence

NOT

' (or) ⇁

First

AND

. (or) ∧

Second

+ (or) ∨

Third

We can easily define these operations using two Boolean variables.

Let's take two Boolean variables A and B that can have any of the two values 0 or 1, i.e., they can be either OFF or ON. Then these operations are explained as,

### Negation or NOT Operation

Using the NOT operation reverse the value of the Boolean variable from 0 to 1 or vice-versa. This can be understood as:

> If A = 1, then using NOT operation we have (A)' = 0If A = 0, then using the NOT operation we have (A)' = 1We also represent the negation operation as ~A, i.e if A = 1, ~A = 0

- If A = 1, then using NOT operation we have (A)' = 0
- If A = 0, then using the NOT operation we have (A)' = 1
- We also represent the negation operation as ~A, i.e if A = 1, ~A = 0

### Conjunction or AND Operation

Using the AND operation satisfies the condition if both the values of the individual variables are true, and if any of the values is false, then this operation gives a negative result. This can be understood as,

> If A = True, B = True, then A . B = TrueIf A = True, B = False, Or A = false, B = True, then A . B = FalseIf A = False, B = False, then A . B = False

- If A = True, B = True, then A . B = True
- If A = True, B = False, Or A = false, B = True, then A . B = False
- If A = False, B = False, then A . B = False

### Disjunction (OR) Operation

Using the OR operation satisfies the condition if any value of the individual variables is true; it only gives a negative result if both the values are false. This can be understood as,

> If A = True, B = True, then A + B = TrueIf A = True, B = False, Or A = false, B = True, then A + B = TrueIf A = False, B = False, then A + B = False

- If A = True, B = True, then A + B = True
- If A = True, B = False, Or A = false, B = True, then A + B = True
- If A = False, B = False, then A + B = False

## Boolean Algebra Table (Extended)

Given Below is the Expression for the Boolean Algebra

| Operation | Symbol | Definition |
| --- | --- | --- |
| AND Operation | ⋅ or ∧ | Returns true only if both inputs are true. |
| OR Operation | + or ∨ | Returns true if at least one input is true. |
| NOT Operation | ¬ or ∼ | Reverses the input. |
| XOR Operation | ⊕ | Returns true if exactly odd number of inputs are true. |
| NAND Operation | ↑ | Returns false only if both inputs are true. |
| NOR Operation | ↓ | Returns false if at least one input is true. |
| XNOR Operation | ↔ | Returns true if both inputs are equal. |

## Boolean Expression and Variables

Boolean expression is an expression that produces a Boolean value when evaluated, i.e., it produces either a true value or a false value. Whereas Boolean variables are variables that store Boolean numbers.

P + Q = R is a Boolean expression in which P, Q, and R are Boolean variables that can only store two values: 0 and 1.

Thus, we can say that statements using Boolean variables and operating on Boolean operations are Boolean Expressions. Some examples of Boolean expressions are,

> A + B = TrueA . B = True(A)' = False

- A + B = True
- A . B = True
- (A)' = False

## Truth Tables

A truth table represents all the combinations of input values and outputs in a tabular manner. All the possibilities of the input and output are shown in it ,and hence the name truth table. In logic problems, truth tables are commonly used to represent various cases. T or 1 denotes 'True' & F or 0 denotes 'False' in the truth table.

> Number of Rows in Truth Table = 2 nwhere n is the number of Boolean variables used.

Number of Rows in Truth Table = 2 n

- where n is the number of Boolean variables used.

Example: Draw the truth table of the conditions A + B and A . B ,where A and B are Boolean variables.

Solution:

The required Truth Table is,

| A | B | X = A + B | Y = A . B |
| --- | --- | --- | --- |
| T | T | T | T |
| T | F | T | F |
| F | T | T | F |
| F | F | F | F |

X = A + B

## Laws for Boolean Algebra

These are the rules we use to simplify logical expressions and design efficient circuits.

### 1. Identity Law

In the Boolean Algebra, we have identity elements for both AND(.) and OR(+) operations. The identity law states that in Boolean algebra, we have such variables that, on operating with the AND and OR operations we get the same result, i.e.

> A + 0 = AA.1 = A

- A + 0 = A
- A.1 = A

### 2. Commutative Law

Binary variables in Boolean Algebra follow the commutative law. This law states that operating Boolean variables A and B is similar to operating Boolean variables B and A. That is,

> A. B = B. AA + B = B + A

- A. B = B. A
- A + B = B + A

### 3. Associative Law

Associative law states that the order of performing Boolean operator is illogical as their result is always the same. This can be understood as,

> ( A . B ) . C = A . ( B . C )( A + B ) + C = A + ( B + C)

- ( A . B ) . C = A . ( B . C )
- ( A + B ) + C = A + ( B + C)

### 4. Distributive Law

Boolean Variables also follow the distributive law, and the expression for the Distributive law is given as:

> A . ( B + C) = (A . B) + (A . C)

- A . ( B + C) = (A . B) + (A . C)

### 5. Inversion Law

Inversion law is the unique law of Boolean algebra that states, the complement of the complement of any number is the number itself.

> (A')' = A

- (A')' = A

Apart from these other laws are mentioned below:

### 6. AND Law

AND law of the Boolean algebra uses AND operator and the AND law is,

> A . 0 = 0A . 1 = AA . A = A

- A . 0 = 0
- A . 1 = A
- A . A = A

### 7. OR Law

OR law of the Boolean algebra uses OR operator and the OR law is,

> A + 0 = AA + 1 = 1A + A = A

- A + 0 = A
- A + 1 = 1
- A + A = A

### 8. Complement Law

The Complement Law states that a variable ORed with its complement is always 1, and a variable ANDed with its complement is always 0.

> A + A' = 1A . A' = 0

- A + A' = 1
- A . A' = 0

### 9. Domination Law

The Domination Law states that any variable ORed with 1 will always be 1, and any variable ANDed with 0 will always be 0.

> A + 1 = 1A . 0 = 0

- A + 1 = 1
- A . 0 = 0

### 10. Double Negation Law

The Double Negation Law states that the complement of the complement of a variable is the variable itself.

> (A')' = A

- (A')' = A

### Summary Table

The basic laws of Boolean Algebra are summarized in the table below:

| Law | OR Form | AND Form |
| --- | --- | --- |
| 1. Identity Law | P + 0 = P | P ⋅ 1 = P |
| 2. Idempotent Law | P + P = P | P ⋅ P = P |
| 3. Commutative Law | P + Q = Q + P | P ⋅ Q = Q ⋅ P |
| 4. Associative Law | P + (Q + R) = (P + Q) + R | P ⋅ (Q ⋅ R) = (P ⋅ Q) ⋅ R |
| 5. Distributive Law | P + (Q ⋅ R) = (P + Q) ⋅ (P + R) | P ⋅ (Q + R) = (P ⋅ Q) + (P ⋅ R) |
| 6. Inversion Law | (A′)′ = A | (A′)′ = A |
| 7. De Morgan's Law | (P + Q)′ = P′ ⋅ Q′ | (P ⋅ Q)′ = P′ + Q′ |
| 8. Complement Law | P + P′ = 1 | P ⋅ P′ = 0 |
| 9. Domination Law | P + 1 = 1 | P ⋅ 0 = 0 |
| 10. Double Negation Law | (P′)′ = P | (P′)′ = P |
| 11. Absorption Law | P + (P ⋅ Q) = P | P ⋅ (P + Q) = P |

## De Morgan’s Theorems

There are two basic theorems of great importance in Boolean Algebra, which are De Morgan’s First Law and De Morgan’s Second Law. These are also called De Morgan’s Theorems. Now let's learn about both in detail.

### De Morgan’s First Law

De Morgan's Law states that the complement of the product (AND) of two Boolean variables (or expressions) is equal to the sum (OR) of the complement of each Boolean variable (or expression).

> (P.Q)' = (P)' + (Q)'

(P.Q)' = (P)' + (Q)'

The truth table for the same is given below:

| P | Q | (P)' | (Q)' | (P.Q)' | (P)' + (Q)' |
| --- | --- | --- | --- | --- | --- |
| T | T | F | F | F | F |
| T | F | F | T | T | T |
| F | T | T | F | T | T |
| F | F | T | T | T | T |

We can cee that truth values for (P.Q)' are equal to truth values for (P)' + (Q)', corresponding to the same input. Thus, De Morgan's first law is true.

### De Morgan’s Second Law

Statement: The Complement of the sum (OR) of two Boolean variables (or expressions) is equal to the product(AND) of the complement of each Boolean variable (or expression).

> (P + Q)' = (P)'.(Q)'

(P + Q)' = (P)'.(Q)'

Proof:

The truth table for the same is given below:

| P | Q | (P)' | (Q)' | (P + Q)' | (P)'.(Q)' |
| --- | --- | --- | --- | --- | --- |
| T | T | F | F | F | F |
| T | F | F | T | F | F |
| F | T | T | F | F | F |
| F | F | T | T | T | T |

We can see that truth values for (P + Q)' are equal to truth values for (P)'.(Q)', corresponding to the same input. Thus, De Morgan's second law is true.

## Applications of Boolean Algebra

Boolean Algebra finds applications in many other fields of science related to digital logic design, computer science, telecommunications, etc. Some of its applications are:

Digital Logic Design:

Boolean Algebra acts as the backbone of digital logic design, being the most important element in the creation and analysis of digital circuits used in computers, smartphones, and all other electronic devices. It helps simplify the [[logic-gates|logic gates]] and circuits so that in the design of digital systems, they can be effectively designed and optimized.

Algorithm Design:

In computer science, Boolean Algebra is utilized in the design and study of algorithms, particularly in fields that require decision-making processes. It's vital in database [[query-optimization|query optimization]], where Boolean logic is utilized to filter and obtain specific data based on circumstances.

Telecommunications:

Boolean Algebra finds application in the design and analysis of communication systems in telecommunication. More specifically, it is used in error detection and correction mechanisms. It is also used in the modulation and encoding of signals so that data is efficiently and accurately transmitted over networks.

Artificial Intelligence (AI):

Boolean Algebra is vital in AI, notably in the construction of decision-making algorithms and neural networks. It's used to model logical thinking and decision trees, which are crucial in machine learning and expert systems.

Electrical Engineering:

In electrical engineering, Boolean Algebra is employed to analyze and design switching circuits, which are important in the operation of electrical networks and systems. It aids in the optimization of these circuits, ensuring minimal energy loss and effective functioning.

## Solved Examples on Boolean Algebra

Question 1: Draw a Truth Table for P + P . Q = P

Solution:

> The truth table for P + P . Q = PPQP . QP + P . QTTTTTFFTFTFFFFFFIn the truth table, we can see that the truth values for P + P.Q is exactly the same as P.

The truth table for P + P . Q = P

| P | Q | P . Q | P + P . Q |
| --- | --- | --- | --- |
| T | T | T | T |
| T | F | F | T |
| F | T | F | F |
| F | F | F | F |

In the truth table, we can see that the truth values for P + P.Q is exactly the same as P.

Question 2: Draw Truth Table for P . Q + P + Q

Solution:

> The truth table for P . Q + P + QPQP . QP . Q + P + QTTTTTFFTFTFTFFFF

The truth table for P . Q + P + Q

| P | Q | P . Q | P . Q + P + Q |
| --- | --- | --- | --- |
| T | T | T | T |
| T | F | F | T |
| F | T | F | T |
| F | F | F | F |

Question 3: Solve ((A.B)+C)′

Solution:

> Using De Morgan's Law((A.B)+C)′ = (A.B)′.C′Using De Morgan's Law(A.B)′+C′ = (A′+B′).C′Using Distributive Law(A′+B′).C′ = A'.C' + B'C'So, the simplified expression for ((A⋅B)+C)′ = A'.C' + B'C'

Using De Morgan's Law

((A.B)+C)′ = (A.B)′.C′

Using De Morgan's Law

(A.B)′+C′ = (A′+B′).C′

Using Distributive Law

(A′+B′).C′ = A'.C' + B'C'

So, the simplified expression for ((A⋅B)+C)′ = A'.C' + B'C'

### Related Articles

> [[Basics]] of Boolean Algebra in Digital ElectronicsProperties of Boolean AlgebraBoolean Algebraic TheoremsAxioms of Boolean Algebra

- [[Basics]] of Boolean Algebra in Digital Electronics
- Properties of Boolean Algebra
- Boolean Algebraic Theorems
- Axioms of Boolean Algebra