---
title: "Phases of a Compiler"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Phases of a Compiler
The compilation process is divided into several phases. Each phase performs a specific task to transform the source code step by step into machine code.

There are 6 major phases in the compilation process.

![compiler](images_compiler.webp)

### 1. Lexical Analysis

First phase of the compiler that converts raw source code into a sequence of tokens, where a token is the smallest meaningful unit in a programming language. The lexical analyzer scans the code character by character and groups the characters into tokens according to the language rules. These tokens may represent keywords, identifiers, constants, operators, or punctuation symbols. By transforming the source code into tokens, lexical analysis makes it easier for the compiler to understand and process the program in later stages of compilation.

Example: int x = 10;

The lexical analyzer would break this line into the following tokens:

- int - Keyword token (data type)
- x - Identifier token (variable name)
- = - Operator token (assignment operator)
- 10 - Numeric literal token (integer value)
- ; - Punctuation token (semicolon, used to terminate statements)

### 2. Syntax Analysis or Parsing

Phase of the compiler that ensures the source code follows the grammatical rules of the programming language. It verifies that the sequence of tokens produced by the lexical analyzer is arranged correctly according to the language’s syntax. This phase checks the proper use of operators, keywords, parentheses, and statements. If the code is not structured according to the language rules, the syntax analyzer generates appropriate error messages.

To represent the structure of the source code, syntax analysis uses parse trees or syntax trees.

- Parse Tree: A parse tree is a tree-like structure that represents the syntactic structure of the source code. It shows how the tokens relate to each other according to the grammar rules. Each branch in the tree represents a production rule of the language, and the leaves represent the tokens.

- Syntax Tree: A syntax tree is a more abstract version of the parse tree. It represents the hierarchical structure of the source code but with less detail, focusing on the essential syntactic structure. It helps in understanding how different parts of the code relate to each other.

![phases](images_phases.webp)

### 3. Semantic Analysis

Semantic analysis is the phase of the compiler that ensures the source code is logically meaningful. While syntax analysis checks the structure of the program, semantic analysis checks its meaning.

This phase identifies semantic errors such as type mismatches, undeclared variables, and invalid operations. It verifies that the operations performed in the program are logically correct and follow the rules of the programming language in terms of data types and variable usage.

Some key checks performed during semantic analysis include:

- Type Checking: The compiler ensures that operations are performed on compatible data types. For example, trying to add a string and an integer would be flagged as an error because they are incompatible types.

- Variable Declaration: It checks whether variables are declared before they are used. For example, using a variable that has not been defined earlier in the code would result in a semantic error.

> Example: int a = 5;float b = 3.5;a = a + b;Type Checking:a is int and b is float. Adding them (a + b) results in float, which cannot be assigned to int a.Error: Type mismatch: cannot assign float to int.

Example:

int a = 5;float b = 3.5;a = a + b;

Type Checking:

- a is int and b is float. Adding them (a + b) results in float, which cannot be assigned to int a.
- Error: Type mismatch: cannot assign float to int.

`a`

`int`

`b`

`float`

`a + b`

`float`

`int a`

`Type mismatch: cannot assign float to int.`

### 4. Intermediate Code Generation

Intermediate Code Generation is the phase of the compiler in which the source code is converted into an intermediate representation (IR). This intermediate code lies between the high-level source code and the final machine code.

Intermediate code is not made for any specific machine. This makes the program more portable and easier to optimize before generating the final machine code. It acts as a bridge between the front end (analysis phases) and the back end (code generation phase) of the compiler.

Importance of Intermediate Code -:

Platform Independence: Since intermediate code is machine-independent, the same intermediate representation can be reused, but code generation must be performed again for each target platform.

Simplifying Optimization: Intermediate code provides a structured and simplified representation of the program, making it easier to apply optimization techniques such as:

- Dead Code Elimination: Removing parts of the code that don’t affect the program’s output.
- Loop Optimization: Improving loops to make them run faster or consume less memory.
- Common Subexpression Elimination: Reusing previously calculated values to avoid redundant calculations.

Easier Translation: Intermediate code is closer to machine code but not tied to a specific machine. This makes the final code generation process smoother and more efficient. This step is handled in the back end of the compile

> Example: a = b + c * d;t1 = c * dt2 = b + t1a = t2

Example: a = b + c * d;

t1 = c * dt2 = b + t1a = t2

### 5. Code Optimization

Code Optimization is the process of improving the intermediate or target code to make the program run faster, use less memory, or be more efficient, without altering its functionality.

- Involves techniques like removing unnecessary computations, reducing redundancy, and reorganizing code to achieve better performance.
- Optimization is classified broadly into two types Machine-Independent & Dependent

Common Techniques:

- Constant Folding: Precomputing constant expressions.
- Dead Code Elimination: Removing unreachable or unused code.
- Loop Optimization: Improving loop performance through invariant code motion or unrolling.
- Strength Reduction: Replacing expensive operations with simpler ones.

Example:

| Code Before Optimization | Code After Optimization |
| --- | --- |
| for ( int j = 0 ; j < n ; j ++){x = y + z ;a[j] = 6 * j;} | x = y + z ;for ( int j = 0 ; j < n ; j ++){a[j] = 6 * j;} |

x = y + z ;

a[j] = 6 * j;

for ( int j = 0 ; j < n ; j ++)

a[j] = 6 * j;

### 6. Code Generation

Code Generation is the final phase of a compiler, where the intermediate representation of the source program (e.g., three-address code or abstract syntax tree) is translated into machine code or assembly code.

The source code written in a higher-level language is transformed into a lower-level language that results in a lower-level object code, which should have the following minimum properties:

- It should carry the exact meaning of the source code.
- It should be efficient in terms of CPU usage and memory management.

Example:

| Three Address Code | Assembly Code |
| --- | --- |
| t1 = c * dt2 = b + t1a = t2 | LOAD R1, c ; Load the value of 'c' into register R1LOAD R2, d ; Load the value of 'd' into register R2MUL R1, R2 ; R1 = c * d, store result in R1LOAD R3, b ; Load the value of 'b' into register R3ADD R3, R1 ; R3 = b + (c * d), store result in R3STORE a, R3 ; Store the final result in variable 'a' |

Three Address Code

Assembly Code

t1 = c * d

t2 = b + t1

a = t2

LOAD R1, c ; Load the value of 'c' into register R1

LOAD R2, d ; Load the value of 'd' into register R2

MUL R1, R2 ; R1 = c * d, store result in R1

LOAD R3, b ; Load the value of 'b' into register R3

ADD R3, R1 ; R3 = b + (c * d), store result in R3

STORE a, R3 ; Store the final result in variable 'a'

Symbol Table - It is a data structure being used and maintained by the compiler, consisting of all the identifier's names along with their types. It helps the compiler to function smoothly by finding the identifiers quickly.

## Error Handling in Phases of Compiler

Error Handling refers to the mechanism used by the compiler in each phase to detect, report, and recover from errors without stopping the entire compilation process.

Each phase of the compiler handles specific types of errors:

### Lexical Analysis

Detects errors in the character stream and ensures valid token formation.

Example Errors:

- Illegal characters
- Invalid tokens (e.g., @var as an identifier)

`@var`

### Syntax Analysis

Checks for grammatical or structural errors based on language rules.

Example Errors:

- Missing semicolon
- Unmatched parentheses
- Incorrect statement structure

### Semantic Analysis

Ensures the program has correct meaning and follows language semantics.

Example Errors:

- Undeclared variables
- Type mismatch (e.g., adding a string and an integer)
- Incorrect function arguments

### Intermediate Code Generation

Ensures correctness of the intermediate representation.

Example Errors:

- Compile-time detectable errors
- Division by constant zero

### Code Optimization

Ensures optimization does not change the program’s meaning.

Example Issues:

- Unreachable code
- Redundant expressions

### Code Generation

Handles errors related to machine-level translation.

Example Errors:

- Insufficient registers
- Invalid [[machine-instructions|machine instructions]]

## Two Part of the Compilation Process

The compiler is broadly divided into two main parts:

| Feature | Front-End (Analysis Phase) | Back-End (Synthesis Phase) |
| --- | --- | --- |
| Main Work | Analyzes source code | Generates target code |
| Input | Source Program | Intermediate Code |
| Output | Intermediate Representation | Machine Code |
| Phases Included | Lexical, Syntax, Semantic, Intermediate Code Generation | Code Optimization, Code Generation |
| Error Handling | Detects most errors | Handles machine-level errors |
| Purpose | Understand and verify program | Produce optimized executable |

![1](Daily/computer-science/compiler-design/images/1.webp)