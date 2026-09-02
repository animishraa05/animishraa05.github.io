---
title: Parsing Techniques Compared — LL(1), LR(0), SLR, CLR, LALR
type: synthesis
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## What's Being Compared

Compiler design offers multiple parsing strategies — top-down (LL) and bottom-up (LR) with several variants. Each has different power, table size, and implementation complexity. Understanding the spectrum from LL(1) through LALR helps compiler designers choose the right parsing technique for their language and constraints.

## The Core Tension

Parsing power and table size are inversely related across the LR family, and a fundamental trade-off exists between human-readability (LL grammars require grammar transformations) and language coverage (LR handles more constructs natively). The CLR(1) parser is the most powerful but produces impractically large tables — LALR exists precisely to trade a tiny amount of power for dramatically smaller tables.

## Comparison

| Dimension | [[ll1-parsing-table\|LL(1)]] | [[lr0-parser\|LR(0)]] | LR: [[lr-parsers\|SLR]] | LR: [[lr-parsers\|CLR (LR(1))]] | LR: [[lr-parsers\|LALR]] |
|-----------|----------|---------|---------|---------|---------|
| Strategy | Top-down, predictive | Bottom-up, shift-reduce | Bottom-up + FOLLOW | Bottom-up + full lookahead | Bottom-up + merged lookahead |
| Lookahead | 1 token | 0 tokens | FOLLOW sets | 1 token (precise) | 1 token (approximate) |
| Table size | Small (rows = non-terminals) | Medium (states = LR(0) items) | Medium (SLR states) | Very large (thousands of states) | Medium (merged states) |
| Parsing power | Least | Less | Medium | Most | Near-CLR |
| Grammar requirement | No left recursion, left-factored | LR(0) grammars | SLR grammars | LR(1) grammars | LALR(1) grammars |
| Error detection | Immediate (empty table cell) | At state with no action | At state with no action | Most precise | Near CLR |
| Conflicts | FIRST/FOLLOW conflicts | Shift/reduce, reduce/reduce | Reduced vs LR(0) | Minimal | Possible reduce/reduce from merging |

## When to Choose Each

**LL(1) / Predictive:** When you are hand-writing a parser (recursive descent) or when the grammar is naturally LL(1). Used in many production compilers (GCC, Clang use hand-written recursive descent).

**LR(0):** Rarely chosen in practice — almost never sufficient for real languages. Useful only as a pedagogical stepping stone to understanding SLR and LALR.

**SLR:** When the grammar is simple enough that FOLLOW sets provide sufficient conflict resolution. Easier to debug than LALR because the relationship between conflicts and grammar rules is clearer.

**CLR / LR(1):** When maximum parsing power is needed and table size is not a constraint. Research and educational use mainly — impractical for production compilers due to state explosion.

**LALR:** The practical sweet spot — the default for parser generators like Yacc and Bison. Handles nearly all programming language constructs with table sizes comparable to SLR.

## The Insight

The LR family shows a beautiful engineering trade-off: by adding just enough lookahead information (merge LR(1) states with same core), LALR achieves CLR-like power with SLR-like table sizes. Meanwhile, LL(1) represents an entirely different approach — predicting rather than reducing — which is simpler to implement by hand but requires more grammar transformation. Most modern compilers use either hand-written recursive descent (LL) or generated LALR parsers, with the middle variants (LR(0), SLR, CLR) serving mainly as conceptual building blocks.

## Connections

- [[ll1-parsing-table|LL(1) Parsing Table]] — top-down predictive parsing approach
- [[lr0-parser|LR(0) Parser]] — simplest LR variant, zero lookahead
- [[lr-parsers|LR Parsers (SLR, CLR, LALR)]] — the three main bottom-up LR variants
- [[predictive-parser|Predictive Parser]] — LL(1) table-driven implementation
- [[recursive-descent-parser|Recursive Descent Parser]] — hand-written top-down approach
- [[top-down-parsing|Top-Down Parsing]] — the LL family category
- [[bottom-up-parsing|Bottom-Up Parsing]] — the LR family category