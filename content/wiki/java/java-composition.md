---
concept: Java Composition
aliases: [Strong Association, Strong Has-A, Ownership, Part-Of, Whole-Part]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Some objects are inherently composed of parts that have no meaning outside the whole. A House is made of Rooms — if the house is destroyed, the rooms cease to exist as meaningful entities. Without composition, modeling these inseparable whole-part relationships would require manual lifecycle management across unrelated objects.

## Core Idea

**Composition** is a strong form of association where one class owns another class. If the parent object is destroyed, the child object also gets destroyed. It represents an **"is-part-of"** relationship with dependent lifecycles — the child cannot exist independently of the parent. Composition is the strongest form of class relationship in Java.

## How It Works

Composition is implemented by creating the contained object inside the container's constructor. The contained object is exclusively owned by the container — no external references to it exist. When the container is garbage collected, the contained object becomes unreachable and is also eligible for GC. In UML, composition is denoted by a filled diamond on the container side. The lifecycle is strictly bound: parent creates child, parent destroys child.

## Visual Explanation

```dot
digraph java_composition {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  House [label="House\n(Owner)\n- List<Room> rooms\n- Address address\nHouse() { rooms = new ArrayList<>() }" fillcolor="#ffe5cc" shape=box3d]

  Room1 [label="Room: LivingRoom\n(Dependent)" fillcolor="#d4edda"]
  Room2 [label="Room: Bedroom\n(Dependent)" fillcolor="#d4edda"]
  Room3 [label="Room: Kitchen\n(Dependent)" fillcolor="#d4edda"]

  Note [label="Strong Relationship\nRooms created inside House\nHouse destroyed → Rooms destroyed\nDependent lifecycle" fillcolor="#e8f4f8"]

  House -> Room1 [label="composed of" style=bold arrowhead=diamond]
  House -> Room2 [label="composed of" style=bold]
  House -> Room3 [label="composed of" style=bold]
  House -> Note [style=invis]
}
```

## Semantic Network

```dot
graph semantic_composition {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Composition" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  ASSOC [label="Association" fillcolor="#cce5ff"]
  AGG [label="Aggregation" fillcolor="#f0f0f0"]
  OOP [label="OOP in Java" fillcolor="#f0f0f0"]
  ENCAP [label="Encapsulation" fillcolor="#d4edda"]

  THIS -- ASSOC [label="built from"]
  THIS -- AGG [label="contrasts with"]
  THIS -- OOP [label="related"]
  THIS -- ENCAP [label="related"]
}
```

## Key Properties

- **Strong relationship**: Parent owns child exclusively
- **Dependent lifecycles**: Child cannot exist without parent
- **Exclusive ownership**: Child object is owned by exactly one parent
- **Internal creation**: Child objects are typically created inside the parent's constructor
- **UML notation**: Filled diamond on the container side

## Connections

- **Built from:** [[java-association|Java Association]] — composition is the strongest form of association
- **Contrasts with:** [[java-aggregation|Java Aggregation]] — aggregation has independent lifecycles; composition has dependent lifecycles
- **Related:** [[java-aggregation-vs-composition|Aggregation vs Composition]] — synthesis comparing the two
- **Related:** [[java-encapsulation|Java Encapsulation]] — composition relies on encapsulation to hide internal parts

## Edge Cases & Gotchas

- **Cloning and copy**: Deep cloning a composed object means cloning all child parts — shallow copy shares references to children
- **Circular composition**: A Room cannot contain a House that contains the same Room — this creates reference cycles
- **Composition vs Aggregation in code**: The difference is in object creation — if created externally and passed in, it's aggregation; if created in the constructor, it's composition
- **Serialization**: Serializing a composed object serializes all its parts; deserialization reconstructs the entire graph

## Sources

- [[java2-summary|Java OOP Concepts — Source Summary]] — composition as strong association, House/Rooms example
