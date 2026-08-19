---
title: "Intermediate Code Generation in Compiler Design"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Intermediate Code Generation in Compiler Design
In the analysis-synthesis model of a compiler, the front end of a compiler translates a source program into an independent intermediate code, then the back end of the compiler uses this intermediate code to generate the target code (which can be understood by the machine). The benefits of using machine-independent intermediate code are:

- Because of the machine-independent intermediate code, portability will be enhanced. For example, suppose, if a compiler translates the source language to its target machine language without having the option for generating intermediate code, then for each new machine, a full native compiler is required. Because, obviously, there were some modifications in the compiler itself according to the machine specifications.
- Retargeting is facilitated.
- It is easier to apply source code modification to improve the performance of source code by optimizing the intermediate code.

![1-34](images_1-34.png)

## Process of Intermediate Code Generation

Intermediate Code Generation is a stage in the process of compiling a program, where the compiler translates the source code into an intermediate representation. This representation is not machine code but is simpler than the original high-level code. Here’s how it works:

- Translation: The compiler takes the high-level code (like C or Java) and converts it into an intermediate form, which can be easier to analyze and manipulate.
- Portability: This intermediate code can often run on different types of machines without needing major changes, making it more versatile.
- Optimization: Before turning it into machine code, the compiler can optimize this intermediate code to make the final program run faster or use less memory.

If we generate machine code directly from source code then for n target machine we will have optimizers and n code generator but if we will have a machine-independent intermediate code, we will have only one optimizer. Intermediate code can be either language-specific (e.g., Bytecode for Java) or language. independent (three-address code). The following are commonly used intermediate code representations:

### Postfix Notation

- Also known as reverse Polish notation or suffix notation.
- In the infix notation, the operator is placed between operands, e.g., a + b. Postfix notation positions the operator at the right end, as in ab +.
- For any postfix expressions e1 and e2 with a binary operator (+) , applying the operator yields e1e2+.
- Postfix notation eliminates the need for parentheses, as the operator's position and arity allow unambiguous expression decoding.
- In postfix notation, the operator consistently follows the operand.

Example 1: The postfix representation of the expression (a + b) * c is : ab + c *Example 2: The postfix representation of the expression (a - b) * (c + d) + (a - b) is : ab - cd + *ab -+Read more: Infix to Postfix

### Three-Address Code

- A three address statement involves a maximum of three references, consisting of two for operands and one for the result.
- A sequence of three address statements collectively forms a three address code.
- The typical form of a three address statement is expressed as x = y op z, where x, y, and z represent memory addresses.
- Each variable (x, y, z) in a three address statement is associated with a specific memory location.

While a standard three address statement includes three references, there are instances where a statement may contain fewer than three references, yet it is still categorized as a three address statement. Example: The three address code for the expression a + b * c + d : T1 = b * c T2 = a + T1 T3 = T2 + d; T 1 , T2 , T3 are temporary variables. There are 3 ways to represent a Three-Address Code in compiler design: i) Quadruplesii) Triplesiii) Indirect TriplesRead more: Three-address code

### Syntax Tree

- A syntax tree serves as a condensed representation of a parse tree.
- The operator and keyword nodes present in the parse tree undergo a relocation process to become part of their respective parent nodes in the syntax tree. the internal nodes are operators and child nodes are operands.
- Creating a syntax tree involves strategically placing parentheses within the expression. This technique contributes to a more intuitive representation, making it easier to discern the sequence in which operands should be processed.

The syntax tree not only condenses the parse tree but also offers an improved visual representation of the program's syntactic structure,Example: x = (a + b * c) / (a - b * c)

![Parse Tree](images_parse-tree.png)

### Key Points:

- Simplifies implementation by reducing the complexity of the input code.
- Enables code optimization for improved performance and efficiency.
- Provides platform independence, allowing the same intermediate code to be used across different machines.
- Facilitates code reuse for generating code for other platforms or languages.
- Makes debugging easier as it is closer to the original source code.
- Can increase compilation time, which may affect real-time or time-critical applications.
- Requires additional memory to store the intermediate representation.
- Adds complexity to the compiler design, making implementation and maintenance harder.
- The generated code may execute slightly slower than code produced directly from source code.