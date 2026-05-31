---
concept: Java Executor Framework
aliases: [Thread Pool, ExecutorService, ThreadPoolExecutor, Callable, Future]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Creating a new thread for every task is expensive and unscalable — thread creation has overhead, too many threads cause contention and memory pressure, and managing thread lifecycles manually is error-prone. A better abstraction is needed for task execution.

## Core Idea

The **Executor framework** decouples task submission from task execution. The core interfaces are `Executor` (single task execution), `ExecutorService` (lifecycle management), and `ScheduledExecutorService` (delayed/periodic tasks). Common implementations include `ThreadPoolExecutor`, `Executors.newFixedThreadPool()`, and `Executors.newCachedThreadPool()`.

## How It Works

Tasks (Runnable or Callable) are submitted to an ExecutorService. The framework maintains a pool of worker threads and a task queue. When a task is submitted, it's either assigned to an available thread or queued. Callable tasks return a `Future` that can be queried for the result once computation completes.

## Visual Explanation

```dot
digraph java_executor {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Tasks [label="Submitted Tasks\nT1 T2 T3 T4 T5 T6"]
  Queue [label="Blocking Queue\n(holds pending tasks)"]
  Pool [label="Thread Pool\n(worker threads)" fillcolor="#ffe5cc"]
  W1 [label="Worker 1\n(executes T1)"]
  W2 [label="Worker 2\n(executes T2)"]
  W3 [label="Worker 3\n(executes T3)"]
  Result1 [label="Future<T1>"]
  Result2 [label="Future<T2>"]

  Tasks -> Queue [label="submit()"]
  Queue -> Pool
  Pool -> W1
  Pool -> W2
  Pool -> W3
  W1 -> Result1
  W2 -> Result2
}
```

## Semantic Network

```dot
graph semantic_executor {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Executor Framework" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  THREAD [label="Multithreading" fillcolor="#cce5ff"]
  SYNC [label="Synchronization" fillcolor="#cce5ff"]
  LAMB [label="Parallel Streams" fillcolor="#d4edda"]
  PERF [label="Performance" fillcolor="#f0f0f0"]

  THIS -- THREAD [label="built from"]
  THIS -- SYNC [label="built from"]
  THIS -- LAMB [label="related"]
  THIS -- PERF [label="related"]
}
```

## Key Properties

- **Thread reuse**: Worker threads are recycled, avoiding creation overhead
- **Bounded queues**: Prevents unbounded memory growth from pending tasks
- **Rejection policy**: What happens when the queue is full (abort, discard, caller-runs)
- **Lifecycle control**: `shutdown()` (no new tasks) and `shutdownNow()` (force stop)

## Connections

- **Built from:** [[java-multithreading|Java Multithreading]] — the framework manages threads internally
- **Built from:** [[java-synchronization|Java Synchronization]] — internal task queues are synchronized
- **Builds into:** [[java-lambda-and-streams|Streams & Lambdas]] — parallelStream() uses the common ForkJoinPool
- **Related:** [[java-deadlock|Java Deadlock]] — thread pools can deadlock if tasks depend on each other

## Edge Cases & Gotchas

- **Hidden thread leak**: Not shutting down an executor prevents JVM exit
- **Task submission inside tasks**: Tasks submitted from within running tasks can cause thread pool deadlock
- **CachedThreadPool unbounded**: `newCachedThreadPool()` creates threads without bound under load
- **ForkJoinPool work stealing**: Each worker has its own deque — steals from others when idle

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — executor framework and thread pools
