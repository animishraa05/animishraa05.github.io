---
concept: Java Loops
aliases: [For Loop, While Loop, Do-While Loop, Iteration]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Many programming tasks require executing the same block of code repeatedly — processing each element of an array, reading lines from a file, or retrying an operation until it succeeds. Without loops, every repetition would require manual code duplication, leading to bloated, error-prone programs.

## Core Idea

Java provides three loop constructs: `for` (when the number of iterations is known), `while` (when iteration continues as long as a condition is true), and `do-while` (same as `while` but guarantees at least one execution). The enhanced `for-each` loop simplifies iteration over arrays and collections.

## How It Works

A loop consists of an initialization, a termination condition, an update expression (for `for` loops), and a body. The JVM evaluates the condition before (or after, for `do-while`) each iteration. If true, the body executes; if false, execution jumps past the loop. The `for-each` loop uses an iterator under the hood for collections.

## Visual Explanation

```dot
digraph java_loops {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Init [label="Initialization\nint i = 0"]
  Cond [label="Condition Check\ni < 5" fillcolor="#ffe5cc"]
  Body [label="Loop Body\nExecute statements"]
  Update [label="Update\ni++"]
  Exit [label="Exit Loop\nContinue after"]

  Init -> Cond
  Cond -> Body [label="true"]
  Body -> Update
  Update -> Cond
  Cond -> Exit [label="false"]
}
```

## Semantic Network

```dot
graph semantic_loops {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Loops" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  CTRL [label="Control Flow" fillcolor="#cce5ff"]
  JUMP [label="Jump Statements" fillcolor="#d4edda"]
  ARR [label="Arrays" fillcolor="#d4edda"]
  COLL [label="Collections" fillcolor="#f0f0f0"]

  THIS -- CTRL [label="built from"]
  THIS -- JUMP [label="builds into"]
  THIS -- ARR [label="builds into"]
  THIS -- COLL [label="builds into"]
}
```

## Key Properties

- **For-each syntax**: `for (Type var : iterable)` — cleaner, no index variable
- **While**: Zero or more iterations (condition checked first)
- **Do-while**: One or more iterations (condition checked after first run)
- **Nested loops**: Loops inside loops for multi-dimensional traversal

## Connections

- **Built from:** [[java-control-flow|Java Control Flow]] — loops use boolean conditions like if-statements
- **Built from:** [[java-operators|Java Operators]] — relational and arithmetic operators control iteration
- **Builds into:** [[java-arrays|Java Arrays]] — loops are the primary way to traverse arrays
- **Builds into:** [[java-collections-framework|Java Collections Framework]] — iteration over collections

## Edge Cases & Gotchas

- **Infinite loops**: `while(true)` or `for(;;)` without break conditions
- **Off-by-one errors**: Using `<=` instead of `<` in loop conditions
- **Concurrent modification**: Modifying a collection while iterating with for-each throws `ConcurrentModificationException`
- **Performance**: Enhanced for-each on arrays is identical to index-based loops after compilation