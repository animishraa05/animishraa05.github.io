---
title: "Classification of Context Free Grammars"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Classification of Context Free Grammars
A Context-Free Grammar (CFG) is a formal rule system used to describe the syntax of programming languages in compiler design. It provides a set of production rules that specify how symbols (terminals and non-terminals) can be combined to form valid sentences in the language. CFGs are important in the parsing phase of a compiler, where the source code is checked to make sure it follows the rules of the programming language. By using CFGs, the compiler can confirm the code's structure is correct and then organize it into a format that makes it easier to work with for the next steps, like optimization and code generation.

## Key components of a CFG:

1. Non-terminals: These are symbols that can be replaced by other symbols in the production rules. They represent syntactical categories (e.g., statements, expressions). Example: S,A,B.
2. Terminals: These are the basic symbols of the language that cannot be replaced further. They are the actual symbols in the language (e.g., keywords, operators). Example: a, b, +, if.
3. Start symbol: This is the non-terminal from which the derivation begins. It represents the entire language. Example: S.
4. Production rules: These describe how non-terminals can be expanded into sequences of non-terminals and/or terminals. Example: S→A B , A→a.

### Example of a CFG:

Let’s take a simple CFG for arithmetic expressions:

1. E→E+T ∣ T
2. T→T×F ∣ F
3. F→(E) ∣ id

Here, E is an expression, T is a term, F is a factor, +,× are operators, id is an identifier (terminal).

Read more about Context Free Grammar.

## Classification of CFG

Context Free Grammars (CFG) can be classified on the basis of following two properties:

## 1) Based on number of strings it generates:

### Non-Recursive Grammar

If a CFG generates a finite number of strings, it is called a non-recursive grammar.

Example: S → Aa A → b | c

Language generated: {ba, ca} (finite)

## Recursive Grammar

If a CFG generates an infinite number of strings, it is called a recursive grammar.

Example 1

S → SaS S → b

Language generated: {b, bab, babab, ...} (infinite)

Example 2

S → Aa A → Ab | c

Language generated: {ca, cba, cbba, ...} (infinite)

### Types of Recursive Grammars:

• Left Recursive Grammar – Recursion occurs on the left side. Example: S → Sα

• Right Recursive Grammar – Recursion occurs on the right side. Example: S → αS

• General Recursive Grammar – Recursion is neither strictly left nor strictly right.

## 2) Based on the number of derivation trees

### Unambiguous Grammar

If a string has only one parse tree (or one leftmost/rightmost derivation), the CFG is unambiguous.

Example of Unambiguous CFG:

E → E + T | T T → T × F | F F → (E) | id

This grammar defines operator precedence. For the expression a + b × c, multiplication is performed first, and only one parse tree is possible. Therefore, the grammar is unambiguous.

### Ambiguous Grammar

If a string has more than one parse tree (or more than one leftmost/rightmost derivation), the CFG is ambiguous.

Example of Ambiguous CFG:

E → E + E | E × E | id

This grammar does not define operator precedence. For the expression a + b × c, two different parse trees are possible:

a + (b × c) (a + b) × c

Since more than one interpretation is possible, the grammar is ambiguous.

Note: A linear grammar is a CFG in which each production has at most one non-terminal on the right-hand side.