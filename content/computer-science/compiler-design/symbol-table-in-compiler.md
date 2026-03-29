---
title: "Symbol Table in Compiler"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Symbol Table in Compiler
A symbol table is a data structure used by a compiler to store information about identifiers such as variables, functions, constants, and parameters in a program.

- Stores information such as the name, type, scope, and memory location of each identifier.
- The symbol table is built during the early phases of compilation and is used throughout all compiler phases for error detection, scope resolution, optimization, and code generation.

## Role of Symbol Table in Compiler Phases

It is used by various phases of the compiler as follows:-

### Lexical Analysis

- Inserts identifiers into the symbol table.
- Records token attributes like identifier names.

### Syntax Analysis

- Updates attribute information such as scope and structure.
- Maintains hierarchical scope information.

### Semantic Analysis

- Performs type checking.
- Verifies declarations before use.
- Validates function parameters and return types.

### Intermediate Code Generation

- Uses type and size information.
- Adds temporary variables into the symbol table.

### Code Optimization

- Uses scope and type information.
- Assists in memory and register optimization.

### Target Code Generation

- Uses memory location and offset information.
- Generates correct [[machine-instructions|machine instructions]].

### Example of Using Symbol Table

Let us consider the following program

```
# include <stdio.h>
 
const float pi = 3.14159f;

float calculateArea(float radius, float pi) {
    return pi * radius * radius;
}

int main() {
    float distance;             
    
    printf("Enter the distance (radius): ");
    if (scanf("%f", &distance) != 1) {
        printf("Invalid input!\n");
        return 1;
    }
    
    float area = calculateArea(distance, pi);
    printf("Area of circle with radius %.2f = %.5f\n", distance, area);
    
    return 0;
}

```

Key identifiers involved:

- distance (variable in main)
- pi (constant)
- radius (parameter in calculateArea)
- calculateArea (function)

`main`

`calculateArea`

A symbol table of this program would look like the following.

| Name | Type | Scope | Category | Additional Info |
| --- | --- | --- | --- | --- |
| pi | float | Global | Constant | Read-only |
| calculateArea | float | Global | Function | Returns float |
| radius | float | Local (Function) | Parameter | Scope: calculateArea |
| distance | float | Local (main) | Variable | Stack allocated |
| area | float | Local (main) | Variable | Stack allocated |

## Implementation of Symbol table

Symbol tables can be implemented using various data structures, each with its trade-offs:

- Hash Tables: Offer fast lookup times, making them suitable for large programs.
- [[binary-search|Binary Search]] Trees: Maintain sorted order, which can be beneficial for certain compiler operations.
- Linear Lists: Simpler to implement but less efficient for large numbers of identifiers.

## Applications of Symbol Table

- Name Resolution: Identifies variables and functions with their types and memory locations.
- Scope Management: Resolves naming conflicts and manages local/global scopes.
- Code Optimization: Provides information useful for improving execution efficiency.
- Code Generation: Supplies data types and storage details for machine code generation.
- Error Detection: Helps detect undeclared variables, type mismatches, and duplicate declarations.