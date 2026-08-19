---
concept: Classification of Context-Free Grammars
aliases: [CFG classification, grammar classes, grammar types for parsing]
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Not all context-free grammars are equally useful for parsing. Some grammars are ambiguous (producing multiple parse trees), some contain left recursion (breaking top-down parsers), and some require unbounded lookahead. A classification system helps parser designers choose or transform grammars for the target parsing strategy.

## Core Idea

Context-free grammars are classified by their properties relevant to parsing: **ambiguous vs unambiguous**, **left-recursive vs non-left-recursive**, **LL(k)** (parseable with k lookahead top-down), and **LR(k)** (parseable with k lookahead bottom-up). Every LL grammar is also LR, but not vice versa. Grammars can often be transformed (left-recursion elimination, left-factoring) to fit a desired class.

## How It Works

A grammar is **ambiguous** if some string has more than one leftmost derivation. A grammar is **left-recursive** if a non-terminal derives a string starting with itself (direct: `A → Aα`, or indirect: `A → Bβ, B → Aγ`). A grammar is **LL(k)** if for every non-terminal and every k-token lookahead, exactly one production can be chosen. A grammar is **LR(k)** if handle identification can be done with k lookahead. The class hierarchy: `LL ⊂ LR ⊂ unambiguous CFG ⊂ CFG`.

## Visual Explanation

```dot
digraph cfg_classification {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  CFG [label="All CFGs" fillcolor="#fff3cd"]
  Unamb [label="Unambiguous" fillcolor="#d4edda"]
  LR [label="LR(k)\n(bottom-up)" fillcolor="#cce5ff"]
  LL [label="LL(k)\n(top-down)" fillcolor="#e8d4ff"]

  CFG -> Unamb [label="no ambiguity"]
  Unamb -> LR  [label="deterministic"]
  LR -> LL    [label="left-to-right\nparseable"]

  Amb [label="Ambiguous\n(multiple trees)" fillcolor="#ffe5cc"]
  NonDet [label="Non-deterministic\n(shift/reduce conflicts)" fillcolor="#ffe5cc"]

  Amb -> CFG [style=dotted]
  NonDet -> Unamb [style=dotted]
}
```

## Semantic Network

```dot
graph semantic_cfg_class {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="CFG\nClassification" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Context-Free\nGrammar" fillcolor="#cce5ff"]
  OUT1 [label="Top-Down\nParsing" fillcolor="#d4edda"]
  OUT2 [label="Bottom-Up\nParsing" fillcolor="#d4edda"]
  OUT3 [label="LR Parsers" fillcolor="#d4edda"]
  REL1 [label="Ambiguous\nGrammar" fillcolor="#f0f0f0"]
  REL2 [label="FIRST and\nFOLLOW Sets" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from" style=dashed]
  THIS -- OUT1 [label="LL grammars used here"]
  THIS -- OUT2 [label="LR grammars used here"]
  THIS -- OUT3 [label="builds into"]
  THIS -- REL1 [label="contrasts with"]
  THIS -- REL2 [label="related"]
}
```

## Key Properties

- **Ambiguous:** Multiple parse trees for the same string — problematic for deterministic parsing
- **Left-recursive:** Direct or indirect recursion on the left — fatal for top-down parsers
- **LL(k):** Deterministic top-down parseable with k-token lookahead — requires left-factoring
- **LR(k):** Deterministic bottom-up parseable with k-token lookahead — more powerful than LL
- **Hierarchy:** Every LL grammar is LR, but LR grammars include non-LL languages (e.g., left-recursive expressions)

## Connections

- **Built from:** [[context-free-grammar|Context-Free Grammar]] — CFG is the formal foundation being classified
- **Builds into:** [[top-down-parsing|Top-Down Parsing]] — requires non-left-recursive, LL(k) grammars
- **Builds into:** [[lr-parsers|LR Parsers]] — LR(k) grammars are the input class for LR parser generators
- **Related:** [[wiki/compilerdesign/ambiguous-grammar|Ambiguous Grammar]] — ambiguity is a key classification dimension
- **Related:** [[first-and-follow-sets|FIRST and FOLLOW Sets]] — used to determine if a grammar is LL(1)

## Edge Cases & Gotchas

- **LL(1) ≠ LL(k):** A grammar may not be LL(1) but may be LL(2) — increasing lookahead increases power
- **LR(0) < SLR < LALR < CLR:** Within LR family, each subclass handles a larger set of grammars
- **Grammar transformation:** Left-recursive grammars can be mechanically transformed to non-left-recursive, but the resulting grammar may be harder to read
- **Inherently ambiguous languages:** Some languages are inherently ambiguous — no unambiguous grammar exists for them

## Sources

- [[cd2-summary|Compiler Design for GATE Exam]] — covers classification of context-free grammars for parsing
