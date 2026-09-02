---
concept: Java Exception Hierarchy
aliases: [Checked Exceptions, Unchecked Exceptions, Throwable, RuntimeException, Error]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Programs encounter unexpected situations — file not found, network down, invalid input, out of memory. Without a structured error handling mechanism, every method would need to check and propagate error codes manually, cluttering business logic and making error paths inconsistent and incomplete.

## Core Idea

Java's exception hierarchy is rooted in `Throwable`, with two main branches: **Exception** (recoverable conditions) and **Error** (serious JVM problems). Exceptions are further divided into **checked** (must be handled or declared) and **unchecked** (`RuntimeException`, may occur anywhere).

## How It Works

When an exceptional condition occurs, the JVM (or user code) creates an exception object and "throws" it. The runtime searches the call stack for a matching `catch` block. If none is found, the thread terminates. Checked exceptions are enforced at compile time — the compiler verifies they are handled or declared.

## Visual Explanation

```dot
digraph java_exceptions {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Throwable [label="java.lang.Throwable" fillcolor="#ffe5cc"]
  Error [label="Error\n(Serious JVM issues)\nOutOfMemoryError\nStackOverflowError" fillcolor="#ffcccc"]
  Exception [label="Exception\n(Recoverable)" fillcolor="#d4edda"]
  Checked [label="Checked Exception\nIOException\nSQLException\nClassNotFoundException" fillcolor="#f0f4ff"]
  Runtime [label="RuntimeException\n(Unchecked)\nNullPointerException\nArrayIndexOutOfBounds\nIllegalArgumentException" fillcolor="#ffe5cc"]

  Throwable -> Error
  Throwable -> Exception
  Exception -> Checked
  Exception -> Runtime
}
```

## Semantic Network

```dot
graph semantic_exception_hierarchy {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Exception Hierarchy" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  TC [label="Try-Catch-Finally" fillcolor="#cce5ff"]
  TT [label="Throw and Throws" fillcolor="#d4edda"]
  CUST [label="Custom Exceptions" fillcolor="#d4edda"]
  NPE [label="NullPointerException" fillcolor="#f0f0f0"]

  THIS -- TC [label="builds into"]
  THIS -- TT [label="builds into"]
  THIS -- CUST [label="builds into"]
  THIS -- NPE [label="related"]
}
```

## Key Properties

- **Throwable root**: Only Throwable subclasses can be thrown and caught
- **Checked exceptions**: Must be caught or declared in the method signature (`throws`)
- **RuntimeException**: Not checked — can be ignored (programmer error: null checks, bounds checks)
- **Error**: Not meant to be caught (JVM in trouble)

## Connections

- **Built from:** [[java-try-catch-finally|Try-Catch-Finally]] — catching exceptions is the handling mechanism
- **Builds into:** [[java-throw-throws|Throw and Throws]] — declaring and propagating exceptions
- **Builds into:** [[java-custom-exceptions|Custom Exceptions]] — user-defined exceptions extend the hierarchy
- **Related:** [[java-object-class|Java Object Class]] — Throwable inherits from Object and overrides toString()

## Edge Cases & Gotchas

- **Checked exception abuse**: Over-declaring checked exceptions couples callers to implementation details
- **Catching Exception**: Catches RuntimeException too — can hide bugs
- **Exception swallowing**: Empty catch blocks silently discard errors
- **Finally vs return**: finally block executes even if try has a return statement