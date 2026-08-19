---
title: "Introduction of Lexical Analysis"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Introduction of Lexical Analysis
Lexical analysis, also known as scanning, is the first phase of a compiler. In this phase, the compiler reads the source code character by character from left to right and groups them into meaningful units called tokens. These tokens are then passed to the next phase of compilation, known as syntax analysis.

![lexical_analysis](images_lexical_analysis.jpg)

## Token

Sequence of characters that represents a basic unit of meaning in a programming language. Tokens are defined by the grammar of the language and are used by the parser to understand program structure.

## Categories of Tokens

### Keywords

Reserved words that have predefined meanings in a programming language.

- Examples in C: if, else, for, while, int, void
- They cannot be used as identifiers
- C language has 32 keywords

`if`

`else`

`for`

`while`

`int`

`void`

### Identifiers

Identifiers are names given to variables, functions, arrays, or other user-defined elements.

Rules:

- Must start with a letter or underscore _
- Can contain letters, digits, and underscores
- Case-sensitive
- Cannot be a keyword

`_`

Examples: count, _sum, totalValue

`count`

`_sum`

`totalValue`

### Constants

Fixed values whose value does not change during program execution.

Examples:

- Integer: 10
- Floating-point: 3.14
- Character: 'a'
- String: "Hello"

`10`

`3.14`

`'a'`

`"Hello"`

### Operators

Perform operations on operands.

Examples:

- Arithmetic: +, -, *, /
- Relational: <, >, ==
- Logical: &&, ||

`+`

`-`

`*`

`/`

`<`

`>`

`==`

`&&`

`||`

### Special Symbols

Used to structure programs.

Examples:

- ; → statement terminator
- , → separator
- { } → code blocks
- [ ] → arrays

`;`

`,`

`{ }`

`[ ]`

Read more about Tokens.

## Lexeme

Actual sequence of characters in the source code that matches a token pattern.

Example

float → KEYWORD

`float`

abs_zero_Kelvin → IDENTIFIER

`abs_zero_Kelvin`

= → OPERATOR

`=`

273 → INTEGER

`273`

; → SEMICOLON

`;`

### Lexemes and Tokens Representation

| Lexemes | Tokens | Lexemes Continued... | Tokens Continued... |
| --- | --- | --- | --- |
| while | WHILE | a | IDENTIEFIER |
| ( | LAPREN | = | ASSIGNMENT |
| a | IDENTIFIER | a | IDENTIFIER |
| >= | COMPARISON | - | ARITHMETIC |
| b | IDENTIFIER | 2 | INTEGER |
| ) | RPAREN | ; | SEMICOLON |

## How Lexical Analyzer Works?

Tokens in a programming language are defined using regular expressions. The lexical analyzer (scanner) uses a Deterministic Finite Automaton (DFA) to recognize these tokens because DFAs can identify regular languages efficiently.

Each final state of the DFA represents a specific token type. The process of converting regular expressions into a DFA can be automated, making token recognition fast and systematic.

The lexical analyzer can also detect errors such as:

- Invalid characters
- Incorrect identifiers

It reports errors along with the line number and column number.

Read more about Working of Lexical Analyzer in Compiler.

### Example 1

Input:

```
a = b + c;
```

Token sequence:

```
id = id + id ;
```

Each id refers to an entry in the symbol table containing details about the variable.

`id`

### Example 2

Program:

```
int main(){  int a, b;  a = 10;  return 0;}
```

Valid tokens:

```
'int' 'main' '(' ')' '{' 'int' 'a' ',' 'b' ';''a' '=' '10' ';''return' '0' ';''}'
```

Comments and extra spaces are ignored by the lexical analyzer. Only meaningful tokens are identified and passed to the next phase of compilation.

### Exercise 1: Count number of tokens:

> int main(){ int a = 10, b = 20; printf("sum is:%d",a+b); return 0;}Answer: Total number of token: 27.

int main(){ int a = 10, b = 20; printf("sum is:%d",a+b); return 0;}Answer: Total number of token: 27.

### Exercise 2: Count number of tokens:

> int max(int i);Lexical analyzer first read int and finds it to be valid and accepts as token.max is read by it and found to be a valid function name after reading (int is also a token , then again I as another token and finally ;Answer: Total number of tokens 7: int, max, ( ,int, i, ), ;

#### int max(int i);

- Lexical analyzer first read int and finds it to be valid and accepts as token.
- max is read by it and found to be a valid function name after reading (
- int is also a token , then again I as another token and finally ;

Answer: Total number of tokens 7: int, max, ( ,int, i, ), ;