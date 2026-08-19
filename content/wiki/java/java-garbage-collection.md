---
concept: Java Garbage Collection
aliases: [GC, Automatic Memory Management, Young Generation, Old Generation, Mark-and-Sweep]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Manual memory management (like C's `malloc`/`free`) is error-prone — forgetting to free causes memory leaks, freeing too early causes dangling pointers, and double-freeing causes crashes. In large applications, tracking object lifetimes manually is nearly impossible.

## Core Idea

**Garbage Collection (GC)** automatically reclaims memory occupied by objects that are no longer reachable. The JVM identifies unused objects, reclaims their memory, and compacts the heap to prevent fragmentation. Developers are freed from manual memory management, at the cost of occasional GC pauses.

## How It Works

The heap is divided into generations: **Young** (Eden + Survivor spaces) and **Old** (Tenured). New objects are allocated in Eden. Minor GC collects the young generation — live objects are copied to Survivor, then eventually promoted to Old. Major GC collects the entire heap. Different collectors (Serial, Parallel, G1, ZGC) use different algorithms (mark-sweep, mark-compact, concurrent).

## Visual Explanation

```dot
digraph java_gc {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Heap [label="Heap" fillcolor="#ffe5cc"]
  Young [label="Young Generation"]
  Eden [label="Eden\n(new objects)"]
  S0 [label="Survivor 0"]
  S1 [label="Survivor 1"]
  Old [label="Old Generation\n(tenured objects)"]
  Meta [label="Metaspace\n(class metadata)"]

  Heap -> Young
  Heap -> Old
  Heap -> Meta
  Young -> Eden
  Young -> S0
  Young -> S1
  Eden -> S0 [label="minor GC (copied)"]
  S0 -> S1 [label="swap"]
  S0 -> Old [label="promoted after N cycles"]
}
```

## Semantic Network

```dot
graph semantic_gc {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Garbage Collection" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  MEM [label="Memory Management" fillcolor="#cce5ff"]
  PERF [label="Performance Tuning" fillcolor="#d4edda"]
  OOP [label="Object References" fillcolor="#d4edda"]
  LEAK [label="Memory Leaks" fillcolor="#f0f0f0"]

  THIS -- MEM [label="built from"]
  THIS -- PERF [label="builds into"]
  THIS -- OOP [label="related"]
  THIS -- LEAK [label="related"]
}
```

## Key Properties

- **Generational hypothesis**: Most objects die young — optimizing for this yields performance
- **GC pause**: "Stop-the-world" events freeze application threads (duration varies by collector)
- **Concurrent collectors**: ZGC, Shenandoah, G1 aim for sub-millisecond pause times
- **GC tuning**: JVM flags control heap sizes, collector selection, and GC behavior

## Connections

- **Built from:** [[java-memory-management|Java Memory Management]] — GC manages the heap portion of JVM memory
- **Builds into:** [[java-memory-management|Java Memory Management]] — GC tuning is critical for application throughput
- **Related:** [[java-multithreading|Java Multithreading]] — GC pauses affect all threads (stop-the-world)
- **Related:** [[java-object-class|Java Object Class]] — finalize() is called by GC before reclaiming (deprecated)

## Edge Cases & Gotchas

- **System.gc()**: Suggests GC but does not guarantee it runs — ignore this call in production
- **Finalization**: `finalize()` is deprecated (Java 9+) — use Cleaner or try-with-resources
- **GC logs**: Enable with `-Xlog:gc*` for tuning — critical for diagnosing memory issues
- **Object resurrection**: In finalize(), an object can make itself reachable again (avoid this pattern)

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — garbage collection
