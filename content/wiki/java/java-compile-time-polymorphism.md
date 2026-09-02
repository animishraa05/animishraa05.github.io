---
concept: Java Compile-Time Polymorphism
aliases: [Method Overloading, Static Polymorphism, Static Dispatch, Early Binding]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

A class often needs multiple versions of the same operation that differ only in their inputs. A `print()` method should work with integers, strings, and booleans. Without overloading, each variant would need a distinct method name (printInt, printString, printBool), making the API inconsistent and hard to remember.

## Core Idea

**Compile-time Polymorphism** (also called **Method Overloading**) allows multiple methods in the same class to share the same name but have different parameter lists. The compiler determines which version to call based on the number, type, and order of arguments. This decision is made at compile time — hence the name. Overloading improves code readability by using consistent names for logically similar operations.

## How It Works

The compiler uses the method signature (name + parameter types) to select the correct overload. It applies widening conversions, autoboxing, and varargs in that order of preference. If no matching overload is found, a compile error occurs. Overloaded methods can differ in parameter count, parameter types, or both. Return type alone is NOT sufficient for overloading — the compiler needs parameter differences.

## Visual Explanation

```dot
digraph compile_time_polymorphism {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Call [label="add(2, 3)\nadd(2, 3, 4)\nadd(2.5, 3.5)"]
  Compiler [label="Compiler\n(Compile Time)" fillcolor="#ffe5cc"]
  Resolved1 [label="add(int a, int b)\n→ returns 5" fillcolor="#d4edda"]
  Resolved2 [label="add(int a, int b, int c)\n→ returns 9" fillcolor="#d4edda"]
  Resolved3 [label="add(double a, double b)\n→ returns 6.0" fillcolor="#d4edda"]

  Call -> Compiler
  Compiler -> Resolved1 [label="match: 2 ints"]
  Compiler -> Resolved2 [label="match: 3 ints"]
  Compiler -> Resolved3 [label="match: 2 doubles"]
}
```

## Semantic Network

```dot
graph semantic_compile_time_poly {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Compile-Time Poly" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  POLY [label="Polymorphism" fillcolor="#cce5ff"]
  METHODS [label="Methods" fillcolor="#d4edda"]
  RUNTIME [label="Runtime Poly" fillcolor="#f0f0f0"]

  THIS -- POLY [label="built from"]
  THIS -- METHODS [label="builds into"]
  THIS -- RUNTIME [label="contrasts with"]
}
```

## Key Properties

- **Same name, different parameters**: Number, type, or order of parameters must differ
- **Compile-time resolution**: Which method to call is decided when code is compiled
- **Return type alone is insufficient**: Methods differing only in return type cause compile error
- **Widening preferred over boxing**: Java prefers widening (int → double) over autoboxing (int → Integer)
- **Varargs is last resort**: If no exact match is found, varargs is used as fallback

## Connections

- **Built from:** [[java-polymorphism|Java Polymorphism]] — compile-time polymorphism is one of two polymorphism types
- **Contrasts with:** [[java-runtime-polymorphism|Runtime Polymorphism]] — compile-time vs runtime resolution
- **Related:** [[java-methods|Java Methods]] — overloading is a method-level feature
- **Related:** [[java-overloading-vs-overriding|Overloading vs Overriding]] — synthesis comparing the two

## Edge Cases & Gotchas

- **Ambiguous call**: If two overloads are equally applicable (e.g., `method(Integer)` and `method(String)` with `null`), the compiler reports ambiguity
- **Widening + boxing chain**: Widening followed by boxing is not supported — `int` cannot widen then autobox to `Long`
- **Varargs ambiguity**: Overloading with varargs can create ambiguous calls — the compiler cannot distinguish `method(int...)` from `method(Integer...)` with `null`