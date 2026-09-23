---
title: Stateful vs Stateless Session Beans
type: comparison
tags: [dev, ejb, session-bean]
created: 2026-04-11
updated: 2026-04-11
---

## Overview

Session beans are business process objects in EJB. They come in two flavors--stateful and stateless--each designed for different types of conversations with clients.

## Comparison

| Feature                  | Stateful Session Bean                                  | Stateless Session Bean                               |
| ------------------------ | ------------------------------------------------------ | ---------------------------------------------------- |
| **Conversational State** | Retained across multiple method calls                  | None retained between calls                          |
| **Client Relationship**  | Dedicated one-to-one bean per client                   | Shared pool, any instance can serve any client       |
| **Lifetime**             | Matches client session                                 | Single method call                                   |
| **Memory Management**    | Passivation/Activation for memory savings              | No passivation needed                                |
| **Instance Pooling**     | Not pooled (each is unique)                            | Pooled and reused                                    |
| **Scalability**          | Heavy, limited scalability                             | Lightweight, highly scalable                         |
| **Use Cases**            | Shopping carts, multi-step forms, banking transactions | Credit card verification, calculations, web services |

## When to Use

### Use Stateful When:

- Business process spans multiple method invocations
- Must remember client data across requests
- Examples: e-commerce shopping cart, multi-step loan application

### Use Stateless When:

- Each request is independent
- Need high scalability
- Examples: rate calculation, data validation, report generation

## Key Insight

The fundamental difference is whether the conversation spans one request or multiple requests. Stateless beans are like stateless HTTP--they don't remember previous interactions. Stateful beans maintain the conversation state, like a logged-in user's session.



## Visual Explanation

```dot
digraph stateful_vs_stateless_session_beans {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Stateful Vs Stateles\nInput"]
  B [label="Stateful Vs Stateles\nCore Mechanism"]
  C [label="Stateful Vs Stateles\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_stateful_vs_stateless_session_beans {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Stateful Vs Stateles" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- [[stateful-session-bean|Stateful Session Bean]]
- [[stateless-session-bean|Stateless Session Bean]]
- [[session-bean|Session Bean]]
- [[passivation|Passivation]]
- [[activation|Activation]]
- [[instance-pooling|Instance Pooling]]