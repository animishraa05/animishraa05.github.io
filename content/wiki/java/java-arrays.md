---
concept: Java Arrays
aliases: [Array Declaration, Multi-Dimensional Arrays, Jagged Arrays, Array Initialization]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Storing and managing multiple values of the same type is a fundamental programming need. Without arrays, developers would need a separate variable for every data item — impractical for even a dozen values, impossible for thousands. Programs need a contiguous, indexable data structure for homogeneous collections.

## Core Idea

An **array** in Java is a container object that holds a fixed number of values of a single type. Arrays are indexed starting at 0, have a fixed length set at creation, and provide O(1) access to any element by index. Java supports single-dimensional arrays, multi-dimensional arrays (arrays of arrays), and jagged arrays (sub-arrays of different lengths).

## How It Works

Arrays are objects on the heap. When created, a contiguous block of memory is allocated: for primitives, the actual values; for objects, references. The length is stored in a header field. Access is bounds-checked at runtime — accessing index < 0 or ≥ length throws `ArrayIndexOutOfBoundsException`.

## Visual Explanation

```dot
digraph java_arrays {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Arr [label="Array Object\nint[5]" fillcolor="#ffe5cc"]
  Elem0 [label="[0]: 10"]
  Elem1 [label="[1]: 20"]
  Elem2 [label="[2]: 30"]
  Elem3 [label="[3]: 40"]
  Elem4 [label="[4]: 50"]

  Arr -> Elem0
  Arr -> Elem1
  Arr -> Elem2
  Arr -> Elem3
  Arr -> Elem4

  Note [label="Contiguous\nMemory" shape=plaintext]
  Elem0 -> Elem1 -> Elem2 -> Elem3 -> Elem4 [style=invis]
}
```

## Semantic Network

```dot
graph semantic_arrays {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Arrays" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  DT [label="Data Types" fillcolor="#cce5ff"]
  LOOP [label="Loops" fillcolor="#d4edda"]
  WRAP [label="Wrapper Classes" fillcolor="#d4edda"]
  COLL [label="Collections" fillcolor="#f0f0f0"]

  THIS -- DT [label="built from"]
  THIS -- LOOP [label="builds into"]
  THIS -- WRAP [label="related"]
  THIS -- COLL [label="related"]
}
```

## Key Properties

- **Fixed length**: Cannot grow or shrink after creation
- **Zero-indexed**: First element at index 0, last at length-1
- **.length**: Array length is accessed via the `length` field (not a method)
- **Multi-dimensional**: `int[][] matrix = new int[3][4]` — array of 3 arrays of 4 ints each

## Connections

- **Built from:** [[java-data-types|Java Data Types]] — arrays hold elements of a declared type
- **Built from:** [[java-loops|Java Loops]] — arrays are typically traversed with loops
- **Builds into:** [[java-collections-framework|Collections Framework]] — Java's collections provide dynamic alternatives to fixed-size arrays
- **Contrasts with:** [[java-arraylist|ArrayList]] — arrays are fixed-size, ArrayList is dynamic

## Edge Cases & Gotchas

- **Array covariance**: `String[]` is a subtype of `Object[]` — storing a non-String throws `ArrayStoreException` at runtime
- **Clone is shallow**: `array.clone()` on an object array copies references, not objects
- **Jagged arrays are arrays of arrays**: `int[][]` where each sub-array can have different lengths
- **Zero-length array is valid**: `new int[0]` is useful for returning empty results

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — arrays
