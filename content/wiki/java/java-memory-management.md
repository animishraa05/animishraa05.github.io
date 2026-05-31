---
concept: Java Memory Management
aliases: [Stack Memory, Heap Memory, Method Area, JVM Memory Areas]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Every running Java program needs memory for code, objects, method calls, and metadata. Without a well-defined memory model, different JVM implementations would allocate and organize memory differently, breaking the platform independence promise and making performance unpredictable.

## Core Idea

The JVM divides memory into several runtime areas: **Heap** (all objects and arrays), **Stack** (each thread has its own stack for method calls and local variables), **Method Area** (class metadata, static variables, constant pool), and native areas (program counter register, native method stacks).

## How It Works

When a method is called, a stack frame is pushed onto the thread's stack containing local variables, operand stack, and frame data. New objects are allocated on the heap (Eden space in young generation). Class structures are stored in the method area (meta space in Java 8+). The JVM's memory manager coordinates allocation and garbage collection.

## Visual Explanation

```dot
digraph java_memory {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  JVM [label="JVM Memory Areas" fillcolor="#ffe5cc"]
  Heap [label="Heap\n- Objects\n- Arrays\n- Shared by all threads" fillcolor="#d4edda"]
  Stack [label="Stack (per thread)\n- Local variables\n- Method calls\n- Operand stacks"]
  MethodArea [label="Method Area\n- Class metadata\n- Static variables\n- Constant pool"]
  PC [label="PC Register\n(per thread)"]
  Native [label="Native Method\nStack"]

  JVM -> Heap
  JVM -> Stack
  JVM -> MethodArea
  JVM -> PC
  JVM -> Native
}
```

## Semantic Network

```dot
graph semantic_memory {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Memory Management" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  GC [label="Garbage Collection" fillcolor="#cce5ff"]
  OBJ [label="Object Allocation" fillcolor="#d4edda"]
  THREAD [label="Multithreading" fillcolor="#d4edda"]
  PERF [label="Performance" fillcolor="#f0f0f0"]

  THIS -- GC [label="builds into"]
  THIS -- OBJ [label="builds into"]
  THIS -- THREAD [label="related"]
  THIS -- PERF [label="related"]
}
```

## Key Properties

- **Heap shared**: All threads share the same heap; objects are visible across threads
- **Stack is thread-private**: Each thread has its own stack, isolated from others
- **Automatic management**: The JVM handles allocation and garbage collection — no manual free()
- **Configurable sizes**: Heap and stack sizes are set via JVM flags (-Xmx, -Xms, -Xss)

## Connections

- **Built from:** [[java-platform-independence|Java Platform Independence]] — the JVM's memory model is part of its portable runtime
- **Builds into:** [[java-garbage-collection|Java Garbage Collection]] — GC reclaims heap memory automatically
- **Builds into:** [[java-multithreading|Java Multithreading]] — each thread has its own stack, but shared heap requires synchronization
- **Related:** [[java-wrapper-classes|Java Wrapper Classes]] — wrappers live on the heap; primitives can live on stack

## Edge Cases & Gotchas

- **StackOverflowError**: Infinite recursion or deep call chains exhaust the stack
- **OutOfMemoryError**: Heap is full and GC cannot reclaim enough space
- **Metaspace** (Java 8+): Replaces PermGen — grows dynamically by default, but can still exhaust native memory
- **Memory leak**: Objects held by unintended references prevent GC — common with collections, listeners, caches

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — memory management
