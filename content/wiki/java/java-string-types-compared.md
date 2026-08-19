---
title: String vs StringBuffer vs StringBuilder — Java String Types Compared
type: synthesis
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## What's Being Compared

Java provides three classes for working with character sequences: immutable `String`, thread-safe mutable `StringBuffer`, and non-thread-safe mutable `StringBuilder`. Understanding when to use each is critical for writing correct and performant code.

## The Core Tension

The tradeoff is between safety and performance. Immutability (String) is the safest but creates garbage under modification. Synchronization (StringBuffer) adds thread safety but incurs overhead. StringBuilder drops synchronization for speed but is unsafe in shared contexts.

## Comparison

| Dimension | [[java-strings|String]] | [[java-stringbuilder-stringbuffer|StringBuffer]] | [[java-stringbuilder-stringbuffer|StringBuilder]] |
|-----------|---------|-------------|-------------|
| Mutability | Immutable | Mutable | Mutable |
| Thread safety | Safe (immutable) | Safe (synchronized) | Unsafe |
| Performance | Slow for modification | Moderate (sync overhead) | Fastest |
| Use case | Fixed text, constants, keys | Legacy code (Java 1.0) | Dynamic building (Java 1.5+) |
| Concatenation in loops | O(n²) garbage | O(n) buffer | O(n) buffer |

## When to Use String

- The value never changes after creation
- As map keys (immutability guarantees hash stability)
- Thread-safe sharing without synchronization
- Short, fixed strings

## When to Use StringBuilder

- Building strings dynamically in a single-threaded context
- Inside methods (local variable, no sharing)
- String concatenation in loops (compiler translates `+` to StringBuilder anyway)

## When to Use StringBuffer

- Mutable string building in a shared, multi-threaded context
- Legacy code that already uses it
- Rare — `StringBuilder` is almost always preferred in modern code

## The Insight

The Java compiler itself prefers StringBuilder — `"a" + "b" + "c"` is compiled to `new StringBuilder().append("a").append("b").append("c").toString()`. There is almost never a reason to use StringBuffer in new code. The real choice is between String (immutable, safe) and StringBuilder (mutable, fast).

## Connections

- [[java-strings|Java Strings]] — the immutable baseline for comparison
- [[java-stringbuilder-stringbuffer|StringBuilder and StringBuffer]] — the mutable alternatives
- [[java-memory-management|Java Memory Management]] — immutability enables string pooling
- [[java-synchronization|Java Synchronization]] — StringBuffer's synchronized methods explained
