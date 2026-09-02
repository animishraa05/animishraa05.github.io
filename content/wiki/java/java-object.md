---
concept: Java Object
aliases: [Instance, Runtime Entity, State and Behavior, Heap Object]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

A class is just a blueprint — it defines what an entity looks like but has no concrete existence. To actually execute behavior and hold data, the program needs live instances that exist at runtime, each with its own unique state. Without objects, the program would be a collection of static methods with no persistent data.

## Core Idea

An **object** is a basic unit of Object-Oriented Programming that represents real-life entities. It is a runtime instance of a class. An object mainly consists of three things: **state** (attributes/fields representing properties), **behavior** (methods defining what the object can do), and **identity** (a unique name or reference that enables interaction with other objects).

## How It Works

When `new ClassName()` executes, the JVM allocates memory on the heap for the object's fields (with default values), then calls the constructor to initialize them. A reference to this memory location is returned as the object's identity. Multiple reference variables can point to the same object. Objects interact by invoking methods on each other's references — this is how a Java program performs its work.

## Visual Explanation

```dot
digraph java_object {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  ClassDef [label="Class: Dog\n(fields + methods)" fillcolor="#ffe5cc"]
  Object [label="Object: Tommy\n(Instance of Dog)" fillcolor="#d4edda" shape=box3d]

  State [label="State (Attributes)\nname = \"Tommy\"\nbreed = \"Labrador\"\nage = 3" fillcolor="#e8f4f8"]
  Behavior [label="Behavior (Methods)\nbark()\neat()\nsleep()" fillcolor="#e8f4f8"]
  Identity [label="Identity (Reference)\nheap address: 0x4F2A\nvariable: Dog tommy" fillcolor="#e8f4f8"]

  Object -> State
  Object -> Behavior
  Object -> Identity
  ClassDef -> Object [label="instantiated from"]

  AnotherObj [label="Object: Max\n(Another Instance)" fillcolor="#d4edda"]
  ClassDef -> AnotherObj [label="instantiated from"]
}
```

## Semantic Network

```dot
graph semantic_object {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Object" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  CLASS [label="Class" fillcolor="#cce5ff"]
  OBJCLASS [label="Object Class" fillcolor="#f0f0f0"]
  OOP [label="OOP in Java" fillcolor="#f0f0f0"]
  METHODS [label="Methods" fillcolor="#d4edda"]

  THIS -- CLASS [label="built from"]
  THIS -- OBJCLASS [label="related"]
  THIS -- OOP [label="related"]
  THIS -- METHODS [label="builds into"]
}
```

## Key Properties

- **State**: The fields/attributes that hold the object's data (what it knows)
- **Behavior**: The methods that operate on the object's data (what it does)
- **Identity**: The unique reference that distinguishes this object from others
- **Heap allocation**: All objects live on the heap, managed by the garbage collector
- **Reference semantics**: Variables hold references (pointers) to objects, not the objects themselves

## Connections

- **Built from:** [[java-class|Java Class]] — objects are runtime instances of a class blueprint
- **Builds into:** [[java-methods|Java Methods]] — objects interact by invoking methods on each other
- **Related:** [[java-object-class|Java Object Class]] — every object inherits from java.lang.Object
- **Contrasts with:** [[java-primitive-types|Java Data Types]] — primitives store values directly; objects use reference semantics

## Edge Cases & Gotchas

- **null reference**: An object variable set to null points to no object — calling methods on it throws NullPointerException
- **Object identity vs equality**: `==` compares references (identity); `.equals()` compares content (equality by default uses == unless overridden)
- **Mutable vs immutable objects**: Object state can be mutable (changeable) or immutable (unchangeable after construction)
- **Object lifespan**: Objects become eligible for garbage collection when no reachable references point to them