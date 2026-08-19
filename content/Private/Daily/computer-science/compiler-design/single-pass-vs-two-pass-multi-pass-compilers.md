---
title: "Single Pass vs Two-Pass (Multi-Pass) Compilers"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Single Pass vs Two-Pass (Multi-Pass) Compilers
The compilation process can be organized in different ways based on how the source program is analyzed and translated. One common classification depends on the number of times the compiler processes the source code during compilation. Each complete traversal of the source program or its intermediate representation is called a compiler pass. Based on the number of passes performed, compilers are categorized into :

- Single-pass compilers
- Multi-pass compilers

## Types of Compiler Passes

Compiler passes are classified based on how many times the source program is processed during compilation.

### 1. Single Pass Compiler

Reads the source code only once and performs all compilation phases in that single scan.

![1](Daily/computer-science/compiler-design/images/1.webp)

### Key Characteristics:

- Processes source code only once
- Faster compilation
- Simple design
- Less memory usage
- Limited optimization capability

### Limitations:

- Difficult to handle forward references
- Limited error detection
- Requires simpler grammar
- Poor optimization

### 2. Two-Pass compiler / Multi-Pass compiler

- A Two-Pass Compiler processes the source program twice.
- A Multi-Pass Compiler processes it more than two times.

Typically divided into:

![2](Daily/computer-science/compiler-design/images/2.webp)

First Pass (Front-End / Analysis Phase)

- Lexical Analysis
- Syntax Analysis
- Semantic Analysis
- Intermediate Code Generation
- Platform Independent

Second Pass (Back-End / Synthesis Phase)

- Code Optimization
- Code Generation
- Machine-dependent tasks
- Platform Dependent

### Problems that can be Solved With Multi-Pass Compiler

Case 1: Different Languages, Same Machine

If multiple programming languages target the same machine:

- Separate Front-End for each language
- Common Back-End for the same machine

![Problem 1](images_problem-1.png)

Case 2: Same Language, Different Machines

If one language targets multiple machines:

- One Front-End
- Multiple Back-Ends (one for each machine)

This modularity makes multi-pass compilers more flexible and reusable.

![Problem 2](images_problem-2.png)

## Difference Between One Pass and Two Pass Compiler

| One Pass Compiler | Two Pass Compiler |
| --- | --- |
| It performs Translation in one pass | It performs Translation in two pass |
| It scans the entire file only once. | It requires two passes to scan the source file. |
| It generates Intermediate code | It does not generate Intermediate code |
| It is faster than two pass assembler | It is slower than two pass assembler |
| A loader is not required | A loader is required. |
| No object program is written. | A loader is required as the object code is generated. |
| Perform some professing of assembler directives. | Perform processing of assembler directives not done in pass-1 |
| Data Structures Used are Symbol Table, Literal Table, Token Stream, etc. | Data Structures Used are Symbol Table, Literal Table, Abstract Syntax Tree, Intermediate Code, etc |
| These assemblers perform the whole conversion of assembly code to machine code in one go. | These assemblers first process the assembly code and store values in the opcode table and symbol table and then in the second step they generate the machine code using these tables. |
| Example: C and Pascal uses One Pass Compiler. | Example: Modula-2 uses Multi Pass Compiler. |

Data Structures Used are Symbol Table, Literal Table, Token Stream, etc.

Data Structures Used are Symbol Table, Literal Table, Abstract Syntax Tree, Intermediate Code, etc