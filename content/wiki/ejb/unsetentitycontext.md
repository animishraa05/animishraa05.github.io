---
concept: unsetEntityContext()
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

## The Problem

When the EJB container needs to reduce the pool size and destroy a bean instance, how does the bean clean up its association with the EntityContext?

## Core Idea

`unsetEntityContext()` is called by the container right before destroying a bean instance. It allows the bean to release any resources acquired in `setEntityContext()`.

## How It Works

- Container decides to remove a bean instance from the pool
- Container calls `unsetEntityContext()` to disassociate the bean from its context
- Bean should release any resources (connections, references)
- Bean instance becomes eligible for garbage collection

## Key Properties

- Called when container wants to shrink the pool
- Bean should clean up resources acquired in `setEntityContext()`
- Context is set to null after this call



## Visual Explanation

```dot
digraph unsetEntityContext__ {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Unsetentitycontext()\nInput"]
  B [label="Unsetentitycontext()\nCore Mechanism"]
  C [label="Unsetentitycontext()\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_unsetEntityContext__ {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Unsetentitycontext()" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[setentitycontext|setEntityContext()]], [[entity-context|Entity Context]]
- Related: [[instance-pooling|Instance Pooling]], [[ejb-container|EJB Container]]

## Edge Cases & Gotchas

- Don't perform database operations--call `ejbRemove()` first if needed