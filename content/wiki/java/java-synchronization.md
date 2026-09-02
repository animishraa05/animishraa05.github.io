---
concept: Java Synchronization
aliases: [synchronized keyword, Thread Safety, Mutex, Lock, Monitor]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

When multiple threads access shared mutable data simultaneously, race conditions occur — two threads reading and writing the same variable can interleave in unpredictable ways, producing incorrect results. Without coordination, concurrent programs are unreliable.

## Core Idea

**Synchronization** coordinates access to shared resources among threads. Java provides the `synchronized` keyword (which uses intrinsic locks/monitors), the `volatile` keyword (for visibility guarantees), and the `java.util.concurrent.locks` package (explicit Lock, ReentrantLock, ReadWriteLock).

## How It Works

Every Java object has an intrinsic lock (monitor). When a thread enters a `synchronized` block or method, it acquires the object's lock. Other threads attempting to enter any synchronized block on the same object block until the lock is released. `synchronized` guarantees both mutual exclusion and visibility (happens-before).

## Visual Explanation

```dot
digraph java_sync {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Counter [label="Shared Object\nCounter { int value; }" fillcolor="#ffe5cc"]
  Lock [label="Intrinsic Lock\n(Acquired by Thread 1)" fillcolor="#f0f0f0"]
  T1 [label="Thread 1\nsynchronized(counter) {\n  counter.value++;\n}" fillcolor="#d4edda"]
  T2 [label="Thread 2\nBLOCKED\n(waiting for lock)" fillcolor="#ffcccc"]
  T1Done [label="Thread 1 releases lock"]

  T1 -> Lock [label="acquires"]
  Counter -> Lock
  Lock -> T1Done [label="released"]
  T2 -> Lock [label="waiting..."]

  T1Done -> T2 [label="Thread 2 acquires lock"]
}
```

## Semantic Network

```dot
graph semantic_synchronization {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Synchronization" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  THREAD [label="Multithreading" fillcolor="#cce5ff"]
  DEAD [label="Deadlock" fillcolor="#d4edda"]
  COLL [label="Concurrent Collections" fillcolor="#d4edda"]
  PERF [label="Performance" fillcolor="#f0f0f0"]

  THIS -- THREAD [label="built from"]
  THIS -- DEAD [label="builds into"]
  THIS -- COLL [label="builds into"]
  THIS -- PERF [label="related"]
}
```

## Key Properties

- **Intrinsic locks**: Every Java object has a built-in monitor
- **synchronized methods**: `synchronized` on an instance method locks `this`
- **synchronized blocks**: More granular — specify the lock object explicitly
- **volatile**: Guarantees visibility (reads see latest write) but not atomicity

## Connections

- **Built from:** [[java-multithreading|Java Multithreading]] — synchronization only matters when multiple threads exist
- **Builds into:** [[java-deadlock|Java Deadlock]] — improper synchronization ordering causes deadlock
- **Builds into:** [[java-executor-framework|Java Executor Framework]] — thread pools need synchronized task queues
- **Related:** [[java-stringbuilder-stringbuffer|StringBuilder and StringBuffer]] — StringBuffer uses synchronized methods for thread safety

## Edge Cases & Gotchas

- **Double-checked locking**: Famous bug pattern — volatile fixes it in Java 5+
- **Synchronized is reentrant**: The same thread can acquire the same lock multiple times without blocking
- **Performance cost**: Synchronized blocks have overhead — use for the smallest scope needed
- **Lock starvation**: Low-priority threads may never acquire a contended lock