---
concept: Java Methods
aliases: [Functions, Method Overloading, Static Methods, Instance Methods]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Without reusable code blocks, programs would be long, repetitive, and impossible to maintain at scale. Every operation — from calculating a value to processing input — would need to be written inline wherever it's needed, leading to massive code duplication and scattered logic.

## Core Idea

A **method** in Java is a named block of code that performs a specific task. Methods accept parameters, may return a value, and can be called from other parts of the program. They enable code reuse, modularity, and the DRY (Don't Repeat Yourself) principle. Java supports **method overloading** — multiple methods with the same name but different parameter lists.

## How It Works

When a method is called, the JVM creates a new stack frame with space for parameters and local variables. Arguments are evaluated and assigned to parameters (pass-by-value). The method body executes, and control returns to the caller with (or without) a return value. Overloaded methods are resolved at compile time based on the argument types.

## Visual Explanation

```dot
digraph java_methods {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Caller [label="Caller Method"]
  Call [label="Method Call\nadd(5, 3)"]
  Stack [label="Stack Frame\nCreated for Method" fillcolor="#ffe5cc"]
  Params [label="Parameters\nint a = 5, int b = 3"]
  Body [label="Method Body Executes\nint sum = a + b;"]
  Return [label="Return Value\n8"]
  Back [label="Caller Continues"]

  Caller -> Call
  Call -> Stack
  Stack -> Params
  Params -> Body
  Body -> Return
  Return -> Back
}
```

## Semantic Network

```dot
graph semantic_methods {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Methods" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  VAR [label="Variables" fillcolor="#cce5ff"]
  ACCESS [label="Access Modifiers" fillcolor="#cce5ff"]
  OOP [label="OOP in Java" fillcolor="#d4edda"]
  OVER [label="Method Overloading" fillcolor="#f0f0f0"]

  THIS -- VAR [label="built from"]
  THIS -- ACCESS [label="built from"]
  THIS -- OOP [label="builds into"]
  THIS -- OVER [label="related"]
}
```

## Key Properties

- **Method signature**: Method name + parameter types (not return type)
- **Overloading**: Same name, different parameters (compile-time polymorphism)
- **Pass-by-value**: All arguments are copied; primitives are safe, object references point to same object
- **Return type**: `void` for no return, or any valid type; must use `return` with a matching value

## Connections

- **Built from:** [[java-variables|Java Variables]] — methods use local variables and parameters
- **Built from:** [[java-access-modifiers|Access Modifiers]] — methods have visibility controls
- **Builds into:** [[java-constructors|Java Constructors]] — constructors are special methods that initialize objects
- **Builds into:** [[java-polymorphism|Java Polymorphism]] — method overriding is runtime polymorphism

## Edge Cases & Gotchas

- **Pass-by-value confusion**: Object references are passed by value — you can modify the object's state but not reassign the reference
- **Varargs overloading**: Calling `method(null)` with a varargs parameter is ambiguous
- **Return after finally**: A `return` in `finally` overrides any previous return
- **Recursive depth**: Deep recursion causes `StackOverflowError`