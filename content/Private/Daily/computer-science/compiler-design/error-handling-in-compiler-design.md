---
title: "Error Handling in Compiler Design"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Error Handling in Compiler Design
During program translation, a compiler may encounter different types of errors. Even if the compiler cannot always determine the exact cause of an error, it can still detect and analyze the issues present in the source code. The main goal of error handling is to assist programmers by identifying and reporting problems in their code. Consists of three main components: error detection, error reporting, and error recovery.

## Sources of Error in Error Handling

Errors can occur at different stages of the compilation process such as lexical, syntax, semantic, and code generation phases. The parser mainly detects syntax errors, but semantic errors like undeclared variables may also occur. For example, using an undeclared identifier can result in a missing entry in the symbol table. Error handling detects errors, reports them clearly, and applies recovery techniques. A good error handling mechanism allows the compiler to continue processing without significantly increasing compilation time.

### There are two main types of errors:

In programming and compiler design, errors are broadly classified into two main types:

### 1. Run-Time Errors

These errors happen while the program is running. They usually occur because of issues like incorrect system settings or invalid input data. Examples of run-time errors include:

- Lack of memory to run the program.
- Memory conflicts with other programs.
- Logical errors, does not produce the expected output.

### 2. Compile-Time Errors

These errors occur before the program starts running, during the compilation process. They stop the program from compiling successfully. Examples of compile-time include:

- Syntax errors (like missing semicolons or incorrect statements).
- Missing file references ( compiler cannot locate required files needed during compilation).

## Finding error or reporting an error

Viable-prefix is the property of a parser that allows early detection of syntax errors.

- A viable prefix is a property of a parser that helps in detecting syntax errors at an early stage during parsing. The main goal is to identify errors as soon as possible without consuming unnecessary input symbols.
- An error is detected when the prefix of the input string does not match the prefix of any valid string in the language grammar. When this happens, the parser reports a syntax error immediately.

Example: for(;), report an error due to having two semicolons inside braces.

## Error Recovery

There are several methods that a compiler uses to recover from errors. These methods help the compiler continue processing the code instead of stopping immediately.Common recovery methods include:

- Panic Mode Recovery – Skips erroneous code and resumes from the next valid statement.
- Phase-Level Recovery – Replaces small incorrect code segments with valid ones.
- Error Productions – Recognizes common errors and provides specific suggestions.
- Global Correction – Makes multiple changes to fix errors optimally.