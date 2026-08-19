---
concept: Java Single Inheritance
aliases: [One Parent One Child, Simple Inheritance, Single extends]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

A class often needs to extend the functionality of another class without modifying the original. The simplest form of reuse is one class inheriting from exactly one parent — a direct "is-a" relationship.

## Core Idea

**Single Inheritance** occurs when one subclass inherits from one superclass. It is the simplest and most common form of inheritance. A single chain `Parent → Child` exists where the child gains all accessible members of the parent and can add or override behavior.

## How It Works

The subclass uses `extends ParentClass`. All non-private fields and methods are inherited. The subclass can override methods, add new fields, and access parent members via `super`. Constructor chaining ensures parent construction happens first. The JVM's method dispatch walks up the single inheritance chain, making method resolution straightforward — at most one parent to check.

## Visual Explanation

```dot
digraph single_inheritance {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Parent [label="Parent Class\nAnimal\n- void eat()\n- void sleep()" fillcolor="#ffe5cc"]
  Child [label="Child Class\nDog\nextends Animal\n- void bark()" fillcolor="#d4edda"]

  Parent -> Child [label="extends"]
}
```

## Semantic Network

```dot
graph semantic_single_inheritance {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Single Inheritance" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  INHER [label="Inheritance" fillcolor="#cce5ff"]
  MULTI [label="Multilevel Inheritance" fillcolor="#d4edda"]
  HIER [label="Hierarchical Inheritance" fillcolor="#f0f0f0"]

  THIS -- INHER [label="built from"]
  THIS -- MULTI [label="builds into"]
  THIS -- HIER [label="contrasts with"]
}
```

## Key Properties

- **One parent, one child**: Each subclass has exactly one direct superclass
- **Simplest form**: The most basic inheritance relationship in Java
- **extends keyword**: Uses the standard Java extends mechanism
- **Constructor chaining**: Parent constructor runs before child constructor body
- **Predictable resolution**: Method lookup only has one parent to check, no ambiguity
- **implicit Object**: If no extends is specified, the class implicitly extends Object

## Edge Cases & Gotchas

- **No cyclic inheritance**: A class cannot extend itself, directly or indirectly
- **final classes**: A final class cannot be subclassed at all
- **Single chain guarantee**: You always know where a method comes from — only one parent to check, unlike multiple inheritance

## Connections

- **Built from:** [[java-inheritance|Java Inheritance]] — the basic inheritance mechanism
- **Builds into:** [[java-multilevel-inheritance|Multilevel Inheritance]] — single steps can be chained
- **Contrasts with:** [[java-hierarchical-inheritance|Hierarchical Inheritance]] — single vs multiple children from one parent
- **Related:** [[java-inheritance-types|Inheritance Types]] — the broader classification of which single is a part

## Sources

- [[java2-summary|Java OOP Concepts — Source Summary]] — single inheritance
