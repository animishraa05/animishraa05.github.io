---
concept: Java Multiple Inheritance
aliases: [Multiple Interfaces, Implementing Multiple Types, Interface Multiple Inheritance]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Some classes need to fulfill multiple contracts simultaneously — a class might need to be both `Comparable` (for sorting) and `Runnable` (for threading). Single class inheritance would force a choice between the two, or require a deep hierarchy to combine them.

## Core Idea

**Multiple Inheritance** in Java is the ability of a class to inherit from multiple types. Java supports this **only through interfaces**, not classes. A class can `implement` multiple interfaces, thereby inheriting method contracts from all of them. This avoids the diamond problem because interfaces provide no state (pre-Java 8) and default methods have resolution rules.

## How It Works

A class declares `class C implements I1, I2`. The class must provide implementations for all abstract methods from both interfaces. If two interfaces define default methods with the same signature, the class must override the method to resolve ambiguity. The class IS-A `I1` and IS-A `I2` simultaneously, enabling polymorphic assignment to either interface type. Interface method dispatch uses the `itable` (interface method table), resolved differently from class vtables.

## Visual Explanation

```dot
digraph multiple_inheritance {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  I1 [label="Interface\nFlyable\nvoid fly()" fillcolor="#ffe5cc"]
  I2 [label="Interface\nSwimmable\nvoid swim()" fillcolor="#ffe5cc"]
  Class [label="Class Duck\nimplements Flyable, Swimmable\nfly() { ... }\nswim() { ... }" fillcolor="#d4edda"]

  Class -> I1 [label="implements" style=dashed]
  Class -> I2 [label="implements" style=dashed]
}
```

## Semantic Network

```dot
graph semantic_multiple_inheritance {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Multiple Inheritance" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  INTER [label="Interfaces" fillcolor="#cce5ff"]
  INHER [label="Inheritance" fillcolor="#cce5ff"]
  HYBRID [label="Hybrid Inheritance" fillcolor="#d4edda"]

  THIS -- INTER [label="built from"]
  THIS -- INHER [label="contrasts with"]
  THIS -- HYBRID [label="builds into"]
}
```

## Key Properties

- **Interface-only in Java**: Java does not support multiple inheritance of classes — only interfaces
- **Multiple contracts**: A class can implement any number of interfaces
- **Diamond problem avoided**: Since interfaces have no state (pre-Java 8), there is no state ambiguity
- **Default method rules**: If two interfaces define the same default method, the class must override
- **IS-A multiple types**: A class implementing I1 and I2 is both an I1 and an I2

## Connections

- **Built from:** [[java-interfaces|Java Interfaces]] — interfaces enable multiple type inheritance
- **Built from:** [[java-inheritance-types|Inheritance Types]] — multiple inheritance through interfaces
- **Contrasts with:** [[java-inheritance|Java Inheritance]] — class inheritance is single; interface inheritance is multiple
- **Builds into:** [[java-hybrid-inheritance|Hybrid Inheritance]] — multiple is a building block for hybrid

## Edge Cases & Gotchas

- **Default method conflict**: If two interfaces define the same default method, the class must override it
- **Static methods in interfaces**: Interface static methods are not inherited, avoiding ambiguity

## Sources

- [[java2-summary|Java OOP Concepts — Source Summary]] — multiple inheritance through interface
