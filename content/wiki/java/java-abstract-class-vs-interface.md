---
title: Abstract Class vs Interface — Partial vs Full Abstraction
type: synthesis
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## What's Being Compared

Two mechanisms for achieving abstraction in Java: **Abstract Classes** and **Interfaces**. Both prevent direct instantiation and define methods that subclasses must implement, but they serve fundamentally different design purposes. Understanding when to use each is a key design decision in Java.

## The Core Tension

The choice comes down to **state vs contract**: abstract classes can hold state (fields, constructors) and provide partial implementation, making them suitable for sharing common code in a hierarchy. Interfaces define pure contracts (pre-Java 8) without state, making them suitable for defining capabilities across unrelated classes.

## Comparison

| Dimension | [[java-abstraction|Abstract Class]] | [[java-interfaces|Interface]] |
|-----------|-----------------|-------------|
| Abstraction level | Partial (0-100%) | Full (100%, pre-Java 8) |
| Instantiation | Cannot instantiate | Cannot instantiate |
| Fields | Can have instance fields | Only static final constants |
| Constructors | Can have constructors | No constructors |
| Access modifiers | All access modifiers allowed | public only (pre-Java 9) |
| Multiple inheritance | Single (extends one class) | Multiple (implements many) |
| Default methods | Allowed (any method) | Allowed (Java 8+, must use default keyword) |
| Static methods | Allowed | Allowed (Java 8+) |
| Private methods | Allowed | Allowed (Java 9+) |
| Keyword | abstract class | interface |
| Inheritance keyword | extends | implements |
| When to use | Shared state + behavior | Capability contract |

## When to Choose Abstract Class

- Subclasses share common state (fields) that should be inherited
- You need constructors to initialize shared state
- The classes form a clear "is-a" hierarchy
- You want to provide some default behavior but force subclasses to implement specific methods

## When to Choose Interface

- Unrelated classes need a common capability (e.g., Serializable, Comparable)
- You need multiple inheritance of type
- You want to define a pure contract without dictating implementation
- The abstraction crosses hierarchy boundaries

## The Insight

The line between abstract classes and interfaces has blurred significantly since Java 8 introduced default and static methods in interfaces. However, the fundamental distinction remains: **abstract classes carry state** (fields, constructors), making them about shared implementation within a hierarchy; **interfaces carry behavior contracts**, making them about shared capability across hierarchies. If you need shared state, use an abstract class. If you need shared capability, use an interface.

## Connections

- [[java-abstraction|Java Abstraction]] — the parent concept
- [[java-interfaces|Java Interfaces]] — interface mechanism in detail
- [[java-inheritance|Java Inheritance]] — both depend on inheritance for implementation
- [[java-polymorphism|Java Polymorphism]] — both enable polymorphic behavior

## Sources

- [[java2-summary|Java OOP Concepts — Source Summary]] — abstract class vs interface for abstraction
