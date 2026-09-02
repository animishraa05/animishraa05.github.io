---
concept: Predictive Parser
aliases: [LL(1) parser, table-driven predictive parser, non-recursive predictive parser]
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Recursive descent parsers require writing code for each non-terminal. For large grammars, this becomes labor-intensive. The parsing logic — choosing which production to apply based on lookahead — can be mechanized: given a grammar, a parsing table can be constructed automatically, and a generic driver can use the table to parse any LL(1) grammar.

## Core Idea

A predictive parser is a table-driven top-down parser that uses a **parsing table** (rows = non-terminals, columns = terminals) to decide which production to apply. It maintains an explicit stack of grammar symbols, eliminating the need for recursive function calls. The parser is driven by a simple algorithm: look up the top-of-stack non-terminal and current input token in the table to determine the next action.

## How It Works

The predictive parser has an input buffer, a stack (initialized with `$` and the start symbol), and a parsing table `M[A, a]`. At each step, it examines `X` (top of stack) and `a` (current input token). If `X` is a terminal matching `a`, it pops and advances. If `X` is a non-terminal, it looks up `M[X, a]` and replaces `X` with the production's right-hand side (pushed in reverse order). If the table entry is empty, a syntax error is reported.

## Visual Explanation

```dot
digraph predictive_parser {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Stack [label="Stack\n$ E'\n$ E' T\n$ E' id\n$ E'\n$"]
  Table [label="Parsing Table M\n\n  id    +     $\nE  E→TE'  -    -\nE'  -   E'→+TE' E'→ε\nT  T→id  -    -" fillcolor="#cce5ff"]
  Input [label="Input Buffer\nid + id $"]
  Driver [label="Predictive\nParser Driver" fillcolor="#ffd700"]
  Output [label="Production\nsequence"]

  Input -> Driver
  Stack -> Driver
  Table -> Driver [label="consult"]
  Driver -> Output
}
```

## Semantic Network

```dot
graph semantic_predictive {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Predictive\nParser" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Top-Down\nParsing" fillcolor="#cce5ff"]
  PRE2 [label="FIRST and\nFOLLOW Sets" fillcolor="#cce5ff"]
  OUT1 [label="LL(1) Parsing\nAlgorithm" fillcolor="#d4edda"]
  CON1 [label="Recursive\nDescent" fillcolor="#ffe5cc"]
  REL1 [label="LL(1) Parsing\nTable" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from" style=dashed]
  THIS -- PRE2 [label="built from" style=dashed]
  THIS -- OUT1 [label="enables"]
  THIS -- CON1 [label="contrasts with — table vs hand-written"]
  THIS -- REL1 [label="related"]
}
```

## Key Properties

- **Table-driven:** A single algorithm works for any LL(1) grammar by swapping the parsing table
- **Non-recursive:** Uses an explicit stack instead of function call recursion
- **LL(1):** Requires exactly one token of lookahead for deterministic decisions
- **Grammar requirements:** No left recursion, no common prefixes (must be left-factored)
- **Efficient:** Linear time O(n) where n is input length

## Connections

- **Built from:** [[top-down-parsing|Top-Down Parsing]] — predictive parsing is a specific top-down approach
- **Built from:** [[first-and-follow-sets|FIRST and FOLLOW Sets]] — used to construct the parsing table
- **Builds into:** [[ll1-parsing-algorithm|LL(1) Parsing Algorithm]] — the algorithm that drives the table
- **Contrasts with:** [[recursive-descent-parser|Recursive Descent Parser]] — table-driven vs hand-written approach
- **Related:** [[ll1-parsing-table|LL(1) Parsing Table]] — the data structure that the algorithm uses

## Edge Cases & Gotchas

- **Multiple entries:** If the table has multiple entries for the same cell, the grammar is not LL(1)
- **ε-productions:** Handled by using FOLLOW sets — when a non-terminal can derive ε, the parser matches its FOLLOW set
- **Error detection:** Errors are detected when the table entry is empty — error recovery routines can use the stack to skip tokens
- **LL(1) limitation:** Not all grammars are LL(1) — operator precedence and certain if-then-else constructs require more lookahead