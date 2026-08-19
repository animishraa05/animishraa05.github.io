---
title: "Compiler Design Tutorial"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---
# Compiler Design Tutorial
A compiler is software that translates or converts a program written in a high-level language (Source Language) into a low-level language (Machine Language or Assembly Language). Compiler design is the process of developing a compiler.

- The Key objectives of compiler design are to automate the translation process, check the correctness of input code, and reporting errors in source code.
- It acts as the "translator" of the programming world, bridging the gap between human-readable code and machine-understandable instructions.
- It involves many stages, like lexical analysis, syntax analysis (parsing), semantic analysis, code generation, code optimisation, etc.
- Most of the early high-level languages, like C and C++ were compiled. However, modern languages like Java and Python use both interpreter and compiler. Please note that the compiler only translates, but interpreter runs as well.

![compiler](images_compiler.webp)

## Introduction

Explains how high-level programs are converted into machine code.

1. [[Basics|Introduction]]
2. [[phases-of-a-compiler|Phases of a Compiler]]
3. Single Pass vs Two Passes
4. [[wiki/compilerdesign/compiler-construction-tools|Compiler construction tools]]
5. [[wiki/compilerdesign/symbol-table-in-compiler|Symbol Table in Compiler]]
6. [[error-handling-in-compiler-design|Error Handling in Compiler Design]]
7. Generations of Programming Languages

## Lexical Analysis

First compiler phase that converts source code into tokens.

1. Lexical Analysis
2. Program to detect tokens in a C program
3. Flex (Fast Lexical Analyzer Generator )

> Quiz on Lexical Analysis

Quiz on Lexical Analysis

## Syntax Analysis

Verifies the grammatical structure of a program.

1. [[Basics|Introduction]] to Syntax Analysis
2. FIRST and FOLLOW
3. [[wiki/compilerdesign/classification-of-context-free-grammars|Classification of Context Free Grammars]](CFG)
4. [[wiki/compilerdesign/ambiguous-grammar|Ambiguous Grammar]]
5. [[Basics|Introduction]] to Parsers
6. [[classification-of-top-down-parsers|Classification of top down parsers]]
7. Bottom Up Parser
8. [[shift-reduce-parser-in-compiler|Shift Reduce Parser in Compiler]]
9. [[slr-clr-and-lalr-parsers|SLR, CLR and LALR Parsers]]
10. [[Daily/computer-science/compiler-design/operator-grammar-and-precedence-parser|Operator grammar and precedence parser]]

## Syntax Directed Translation

Uses grammar-based semantic rules to guide program translation.

1. Syntax Directed Translation
2. S – attributed and L – attributed SDTs in Syntax directed translation

> Quiz on Parsing and Syntax Directed Translation

Quiz on Parsing and Syntax Directed Translation

## Code Generation and Optimization

Transform intermediate code into efficient target code.

1. Code Optimization
2. Intermediate Code Generation
3. [[issues-in-the-design-of-a-code-generator|Issues in the design of a code generator]]
4. [[three-address-code-in-compiler|Three address code in Compiler]]
5. [[detection-of-a-loop-in-three-address-code|Detection of a Loop in Three Address Code]]
6. [[Basics|Introduction]] of Object Code
7. Data flow analysis in Compiler

> Quiz on Code Generation and Optimization

Quiz on Code Generation and Optimization

## Runtime Environments

Deal with how programs are executed and managed at runtime.

1. Static and Dynamic Scoping
2. Runtime Environments
3. Linker
4. Loader in C/C++
5. [[developing-a-linux-based-shell|Developing a Linux based shell]]
6. Storage Allocation Strategies

## Quick Links

- Last Minute Notes
- GATE | Previous Years Questions
- Quiz on Compiler Design
- [[cd2|Compiler Design (CD) for GATE Exam]]