---
concept: Java Object Class
aliases: [Root Class, equals, hashCode, toString, clone]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Every object in Java needs a basic set of operations — comparing with other objects, generating a hash code, producing a string representation, and being cloneable. Without a common base class, each class would redefine these fundamental behaviors inconsistently.

## Core Idea

`java.lang.Object` is the root of the Java class hierarchy. Every class implicitly extends `Object`. It provides a set of core methods that all objects inherit: `equals()`, `hashCode()`, `toString()`, `clone()`, `finalize()`, `getClass()`, `notify()`, `wait()`, and `notifyAll()`.

## How It Works

When a class is defined without an explicit `extends` clause, the compiler adds `extends Object`. All inherited methods can be overridden. The default `equals()` uses reference equality (`==`); `hashCode()` returns the memory address (typically); `toString()` returns `ClassName@hashCode`.

## Visual Explanation

```dot
digraph java_object_class {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Object [label="java.lang.Object\n(Root of Hierarchy)" fillcolor="#ffe5cc"]
  Str [label="toString()"]
  Eq [label="equals() / hashCode()"]
  Clone [label="clone()"]
  Thread [label="wait() / notify()"]
  Final [label="finalize()"]
  Class [label="getClass()"]

  Object -> Str
  Object -> Eq
  Object -> Clone
  Object -> Thread
  Object -> Final
  Object -> Class
}
```

## Semantic Network

```dot
graph semantic_object_class {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Object Class" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  INHER [label="Inheritance" fillcolor="#cce5ff"]
  STR [label="Strings" fillcolor="#d4edda"]
  COLL [label="Collections" fillcolor="#d4edda"]
  THREAD [label="Multithreading" fillcolor="#d4edda"]

  THIS -- INHER [label="built from"]
  THIS -- STR [label="builds into"]
  THIS -- COLL [label="builds into"]
  THIS -- THREAD [label="builds into"]
}
```

## Key Properties

- **equals/hashCode contract**: If two objects are equal, they must have the same hash code
- **Thread methods**: `wait()` and `notify()` are defined here, making every object a monitor
- **getClass()**: Returns the runtime class — final, cannot be overridden
- **finalize()**: Called by GC before reclaiming memory (deprecated in Java 9+)

## Connections

- **Built from:** [[java-inheritance|Java Inheritance]] — Object is the ultimate parent of all classes
- **Builds into:** [[java-strings|Java Strings]] — String overrides equals() and hashCode() for value comparison
- **Builds into:** [[java-collections-framework|Java Collections Framework]] — hashCode() is used by HashMap, HashSet
- **Related:** [[java-polymorphism|Java Polymorphism]] — Object reference can hold any type (polymorphism)

## Edge Cases & Gotchas

- **equals() without hashCode()**: Breaking the contract causes HashMap/HashSet to malfunction
- **clone() is tricky**: It performs a shallow copy; overriding requires implementing `Cloneable`
- **finalize() is unreliable**: Not guaranteed to run; use try-with-resources or Cleaner instead
- **toString() default**: `ClassName@1a2b3c4d` is usually not human-readable

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — Object class
