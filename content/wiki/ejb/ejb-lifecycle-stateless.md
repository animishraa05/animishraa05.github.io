---
concept: EJB Lifecycle -- Stateless
aliases: [Stateless Session Bean Lifecycle]
tags: [dev, ejb, lifecycle]
created: 2026-04-11
updated: 2026-04-11
---

## The Problem

What happens to a stateless session bean from creation to destruction?

## Core Idea

The stateless session bean lifecycle has three states: Does Not Exist, Method-Ready Pool, and being removed. The container manages all transitions.

## How It Works

### 1. Does Not Exist

- Bean instance does not exist in memory

### 2. Creation (Entering Pool)

- Container calls Class.newInstance() to create instance
- Container calls setSessionContext() to associate bean with container
- Container calls ejbCreate() to initialize bean
- Bean enters the "Method-Ready Pool" of equivalent instances

### 3. Method Ready (In Pool)

- Container can call any business method
- Any instance can serve any client
- Each method call may be handled by a different instance

### 4. Destruction

- Container calls ejbRemove() when bean is destroyed
- Bean returns to Does Not Exist state
- ejbRemove() is a cleanup method--release resources

## Key Properties

- No passivation/activation (stateless has no state to serialize)
- All instances in pool are equivalent
- Container controls creation and destruction
- ejbCreate() takes no parameters (no client-specific init data)



## Visual Explanation

```dot
digraph EJB_Lifecycle____Stateless {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Ejb Lifecycle    Sta\nInput"]
  B [label="Ejb Lifecycle    Sta\nCore Mechanism"]
  C [label="Ejb Lifecycle    Sta\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_EJB_Lifecycle____Stateless {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Ejb Lifecycle    Sta" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[stateless-session-bean|Stateless Session Bean]]
- Related: [[instance-pooling|Instance Pooling]], [[ejbcreate|ejbCreate()]], [[ejbremove|ejbRemove()]]

## Edge Cases & Gotchas

- Don't rely on ejbRemove()--it may never be called if container crashes
- Stateless beans can be pre-created at startup (not lazily created)