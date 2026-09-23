# Compiler Design

**Course Code:** IC 901A  
**Course Type:** Advanced  
**Course Credits:** 4  

## Course Objective
The course aims at understanding the working of compiler in detail so as to have knowledge of whole spectrum of language processing technology.

## Course Outcomes
After completion of the course, student will:
- **CO1:** Know concepts related to compilers and develop ability to deploy knowledge of compiler design in various related fields.
- **CO2:** Have an understanding of the translation process from High Level Languages to Machine Level Language and apply these concepts in processing structured input.
- **CO3:** Know the syntax and semantic analysis approaches for efficient code/program verification to be able to write efficient code.
- **CO4:** Learn code optimization and runtime code synthesis and apply these concepts in real world applications.

## Course Contents

### Unit 1: Introduction to Compilers
- **Contents:** Language Processing System, Translators - Interpreters, Assemblers, Compilers. Types of Compilers, Model of a compiler, phases of a compilation process, pass structure of compiler, Cousins of the compiler.
- **Hours:** 6
- **Targeted Levels of Bloom's Taxonomy:** 1 and 2*
- **Learning Outcomes (LO):**
  - **LO1:** Describe the concepts of compilation method and structure of compiler.
  - **LO2:** Able to distinguish between compiler and interpreter.
- **Resources:** Book 1, Book 2 & Book 3 (Lecture), Online Resources 1 & 2
- **Assignment:** Discussion on language processing and compilation process

### Unit 2: Lexical Analysis
- **Contents:** Lexical Analysis, Tokens, Patterns, and Lexemes, Lexical analyzer design, The role of Lexical Analyzer, Input Buffering, Specification of tokens, and Recognition of tokens, Lexical Analyzer Generator Lex.
- **Hours:** 4
- **Targeted Levels of Bloom's Taxonomy:** 1, 2 and 3*
- **Learning Outcomes (LO):**
  - **LO1:** Able to perform lexical analysis and apply the concept to process structured input in any application.
- **Resources:** Book 1 & Book 3 (Lecture), Online Resources 1 & 2
- **Assignment:** Discussion on Lexical Analyzer and Assignment regarding Lex Tool.

### Unit 3: Syntax-Analysis
- **Contents:** Role of Parser, Top-down Parsing- Brute-force approach, recursive descent parser and algorithms, Simple LL (1) grammar, LL (1) with null and without null rules grammars, predictive parsing. Bottom-up parsing- Handle of a right sentential form, Shift-reduce parsers, operator precedence parsing, LR parsing. Parser Generator YACC.
- **Hours:** 10
- **Targeted Levels of Bloom's Taxonomy:** 1, 2, 3, and 6*
- **Learning Outcomes (LO):**
  - **LO1:** Student will have an understanding of parsing the structured input using grammatical rules.
  - **LO2:** Implement different parsing algorithms.
  - **LO3:** At this level, students will be able to perform lexical analysis and parsing to create applications like word processors and editors.
- **Resources:** Book 1 & Book 3 (Lecture, illustration, and implementation), Online Resources 1 & 2
- **Assignment:** Discussion and practice session on developing parser programs for different grammars. Assignment to develop programs for different parsing techniques.

### Unit 4: Syntax Directed Translation & Intermediate Code Generation
- **Contents:** Syntax-directed definition, Implementation of Syntax directed Translators Translation schemes, Design of Translation Schemes, Implementation of Syntax directed Translators. Intermediate code, postfix notation, Parse trees & syntax trees, three address codes, quadruple & triples, translation of assignment statements, Boolean expressions, statements that alter the flow of control, postfix translation.
- **Hours:** 8
- **Targeted Levels of Bloom's Taxonomy:** 1, 2, 3 and 4*
- **Learning Outcomes (LO):**
  - **LO1:** Understand semantic analysis (type checking and type casting) phase of compilation process
  - **LO2:** Understand intermediate code generation and use different mechanisms for representing intermediate code.
- **Resources:** Book 1 (Lecture & illustration), Online Resources 1 & 2
- **Assignment:** Discussion on Syntax Directed Translation & Intermediate Code Generation. Practice session on intermediate code generation using different representations.

### Unit 5: Symbol Table Management
- **Contents:** Symbol table contents, organization for block structured languages-stack symbols tables. Mechanisms to implement symbol table, Source Language issues - Scope and Binding information, Stack implemented hash structured symbol tables.
- **Hours:** 4
- **Targeted Levels of Bloom's Taxonomy:** 1, 2, 3 and 4*
- **Learning Outcomes (LO):**
  - **LO1:** Know the significance of symbol table in compilation process and use different data structures to implement it.
- **Resources:** Book 1, Book 3 (Lecture and illustration), Online Resources 1 & 2
- **Assignment:** Discussion on symbol table design and Assignment on implementing symbol table.

### Unit 6: Code Generation & Optimization
- **Contents:** Machine Independent Code Optimization: - Definition, Local code optimization techniques, Elimination of local and global common sub Expressions, loop optimization. Code Generation: - Definition, machine model, simple code generation method. Peephole optimization.
- **Hours:** 4
- **Targeted Levels of Bloom's Taxonomy:** 1 to 5*
- **Learning Outcomes (LO):**
  - **LO1:** Know code optimization and code generation phase of compilation process.
  - **LO2:** Apply code optimization techniques for generating efficient code.
- **Resources:** Book 1 & Book 3 (Lecture, illustration and tutorial), Online Resources 1 & 2
- **Assignment:** Discussion and practice session on code generation and code optimization.

### Unit 7: Error Handling
- **Contents:** Error Detection & Recovery, Lexical Phase errors, syntactic phase errors and semantic errors. Recovery from different phases of compilation process.
- **Hours:** 4
- **Targeted Levels of Bloom's Taxonomy:** 1 to 5*
- **Learning Outcomes (LO):**
  - **LO1:** Know different types of errors and acquaintance with different types of errors will help students to write code with minimum errors.
  - **LO2:** Use different error detection and error recovery methods.
- **Resources:** Book 1 & Book 3 (Lecture), Online Resources 1 & 2
- **Assignment:** Discussion on types of errors and error handling techniques.

*\* 1- Remember, 2- Understand, 3- Apply, 4- Analyze, 5- Evaluate, 6- Create*

## Books and Reading
1. Alfred V. Aho, Ravi Sethi, Jeffery D. Ullman, *Compilers: Principles, Techniques, and Tools*, Addison Wesley Longman
2. *Compiler Construction Theory & Practice*, Barrett, Bates, Gustafson, Couch
3. *The Theory & Practice of Compiler Writing*, Jean Paul Tremblay, Paul G. Sorenson
