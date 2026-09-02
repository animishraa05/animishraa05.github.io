---
title: Overloading vs Overriding — Compile-Time vs Runtime Polymorphism
type: synthesis
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## What's Being Compared

Two forms of polymorphism in Java: **Method Overloading** (compile-time polymorphism) and **Method Overriding** (runtime polymorphism). Both allow multiple methods with the same name, but their mechanisms, purposes, and resolution times are fundamentally different.

## The Core Tension

The distinction is **when** the method call is resolved: overloading at compile time (compiler picks the version based on static types), overriding at runtime (JVM picks the version based on the actual object type). This affects everything from performance (compile-time is faster) to flexibility (runtime enables polymorphic behavior).

## Comparison

| Dimension | [[java-compile-time-polymorphism|Overloading (Compile-Time)]] | [[java-runtime-polymorphism|Overriding (Runtime)]] |
|-----------|----------------------|-------------------|
| Resolution time | Compile time | Runtime |
| Alternative name | Static polymorphism, early binding | Dynamic polymorphism, late binding |
| Parameter requirement | Must differ (different type/count) | Must be identical |
| Return type | Can differ freely | Must be same or covariant |
| Class requirement | Same class | Different classes (inheritance) |
| Keyword | None (automatic) | @Override (optional, recommended) |
| Can be static? | Yes | No (static methods are hidden, not overridden) |
| Can be private? | Yes | No (private methods are not inherited) |
| Can be final? | Yes | No (final methods cannot be overridden) |
| Performance | Faster (resolved at compile time) | Slightly slower (vtable lookup) |
| Use case | API convenience, type flexibility | Polymorphic behavior, substitution |

## When to Choose Overloading

- You want a convenient API where similar operations accept different types (print(int), print(String), print(boolean))
- The behavior variation is based on input types, not object type
- Performance matters and the variation is known at compile time

## When to Choose Overriding

- You need polymorphic behavior — code written against a base type should work with any subtype
- Different subclasses need different implementations of the same contract
- You're designing an interface or abstract class that subclasses will implement

## The Insight

Overloading and overriding serve completely different purposes despite both involving "same method name." Overloading is about **API convenience** — giving the developer a clean API that works with multiple input types. Overriding is about **behavioral substitution** — enabling the Liskov Substitution Principle where subtypes can replace their parent types. The only thing they share is the method name reuse, and they can coexist: a method can be both overloaded (in its class) and overridden (by subclasses).

## Connections

- [[java-compile-time-polymorphism|Compile-Time Polymorphism]] — overloading mechanism
- [[java-runtime-polymorphism|Runtime Polymorphism]] — overriding mechanism
- [[java-polymorphism|Java Polymorphism]] — the parent concept of both
- [[java-methods|Java Methods]] — the method declaration is the common foundation