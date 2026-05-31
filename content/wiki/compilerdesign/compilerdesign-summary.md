---
source: Compiler Design Tutorial
source_path: sources/compilerdesign.md
ingested: 2026-05-13
concepts_count: 34
tags: [dev, compiler-design]
---

## What This Source Is

A tutorial/overview of compiler design covering the complete compilation pipeline — from high-level introduction, through lexical analysis, syntax analysis, syntax-directed translation, code generation and optimization, to runtime environments. The source uses a structured topic-based format with links to detailed subtopics.

## Concepts Extracted

**Created (all in wiki/compilerdesign/):**

- [[compiler|Compiler]] — definition, role as translator, front-end vs back-end architecture
- [[phases-of-compiler|Phases of a Compiler]] — six-phase pipeline from lexical analysis to code generation
- [[lexical-analysis|Lexical Analysis]] — first phase, scanning source into tokens
- [[token|Token]] — atomic unit of lexical analysis: token class + attribute value
- [[syntax-analysis|Syntax Analysis]] — parsing, verifying grammatical structure via CFG
- [[semantic-analysis|Semantic Analysis]] — type checking, scope resolution, semantic rules
- [[intermediate-code-generation|Intermediate Code Generation]] — producing machine-independent IR
- [[code-optimization|Code Optimization]] — semantics-preserving code improvement transformations
- [[code-generation|Code Generation]] — final phase, producing target machine code
- [[object-code|Object Code]] — relocatable output of compilation, input to linker
- [[compiler-pass|Compiler Pass]] — single-pass vs multi-pass compiler organization
- [[compiler-construction-tools|Compiler Construction Tools]] — Lex, Yacc, Flex, Bison for automating compiler development
- [[symbol-table-in-compiler|Symbol Table in Compiler]] — data structure for identifier information across phases
- [[error-handling-in-compiler|Error Handling in Compiler Design]] — detection, reporting, and recovery from lexical/syntax/semantic errors
- [[programming-language-generations|Programming Language Generations]] — 1GL through 5GL classification
- [[flex-lexical-analyzer-generator|Flex — Fast Lexical Analyzer Generator]] — tool for generating DFA-based lexers
- [[context-free-grammar|Context-Free Grammar]] — formal system for language syntax specification
- [[first-and-follow-sets|FIRST and FOLLOW Sets]] — computed from CFG for parser table construction
- [[ambiguous-grammar|Ambiguous Grammar]] — grammar with multiple parse trees for one input
- [[parser-introduction|Parser Introduction]] — role and types of parsers in syntax analysis
- [[top-down-parsing|Top-Down Parsing]] — recursive descent, LL(1) predictive parsing
- [[bottom-up-parsing|Bottom-Up Parsing]] — LR parsing family, shift-reduce mechanism
- [[shift-reduce-parser|Shift Reduce Parser]] — stack-based bottom-up parsing with shift/reduce operations
- [[lr-parsers|LR Parsers]] — SLR, CLR, LALR variants with different power/size trade-offs
- [[operator-precedence-parser|Operator Precedence Parser]] — simple bottom-up parser for operator grammars
- [[syntax-directed-translation|Syntax-Directed Translation]] — attaching semantic actions to grammar productions
- [[attributed-sdt|S-Attributed and L-Attributed SDTs]] — classification by attribute flow direction
- [[three-address-code|Three-Address Code]] — IR form with at most three operands per instruction
- [[loop-detection-in-tac|Detection of a Loop in TAC]] — dominator-based loop identification in control-flow graphs
- [[code-generator-design-issues|Issues in Code Generator Design]] — instruction selection, register allocation, scheduling
- [[data-flow-analysis|Data Flow Analysis]] — collecting information about program values via data-flow equations
- [[static-and-dynamic-scoping|Static and Dynamic Scoping]] — compile-time vs runtime scope resolution
- [[runtime-environment|Runtime Environment]] — call stack, heap, activation records, runtime system
- [[linker-and-loader|Linker and Loader]] — symbol resolution, relocation, program loading
- [[storage-allocation-strategies|Storage Allocation Strategies]] — static, stack, heap allocation for different data lifetimes

**Syntheses created:**

- [[single-pass-vs-multi-pass|Single-Pass vs Multi-Pass Compiler]] — trade-off between compilation speed and code quality
- [[compiler-vs-interpreter|Compiler vs Interpreter]] — comparing translation strategies and modern hybrid approaches

## Key Takeaways

- The compiler's six-phase pipeline (lexical → syntax → semantic → IR → optimize → codegen) separates concerns and enables modular design
- Front-end (analysis) and back-end (synthesis) separation enables retargeting compilers to different architectures
- CFGs are the formal foundation for syntax analysis; LR parsing is more powerful than LL parsing
- Single-pass compilers are fast but limited; multi-pass enables optimization at the cost of compile time
- The distinction between compiler and interpreter is increasingly blurred (JIT compilation, bytecode)
- Runtime environments handle memory management, calling conventions, and language-specific services

## Related Sources

- [[cd2-summary|Compiler Design for GATE Exam]] — complementary GATE exam-focused source adding 15 new concept pages (lexer working, CFG classification, recursive descent, predictive parser, LL(1) table/algorithm, LR(0), SDT schemes/applications, basic blocks, CFG, peephole, CSE, constant propagation, liveliness analysis)

## Open Questions

- How do modern JIT compilers (V8, HotSpot) dynamically choose which code to compile vs interpret?
- What are the practical performance differences between LL(1), LALR(1), and LR(1) parsing for real languages?
- How do incremental compilation systems (like Rust's rustc or TypeScript's tsc) change the compiler architecture?
