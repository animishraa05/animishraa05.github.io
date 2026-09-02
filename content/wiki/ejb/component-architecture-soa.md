---
concept: "Component Architecture & SOA"
aliases: [SOA, Service-Oriented Architecture, component architecture]
tags: [dev, ejb]
created: 2026-04-29
updated: 2026-04-29
---

## The Problem
Monolithic applications mixed everything together—UI, business logic, and data access all in one codebase. This made code impossible to reuse across different applications and hard to maintain as the application grew.

## Core Idea
"Divide and Conquer" applied to software architecture. Break a large application into small, independent pieces (components/services), where each component handles a specific responsibility. These components can be reused across multiple applications.

## How It Works
1. **Decomposition**: Identify distinct responsibilities and split them into separate components
2. **Interface Definition**: Each component exposes a contract (interface) defining what it can do
3. **Independent Deployment**: Components can be developed, deployed, and updated independently
4. **Reusability**: Same component can serve multiple applications

In EJB, the component architecture manifests as:
- Enterprise Beans = business logic components
- Interfaces (Remote/Local) = contracts
- Container = runtime environment managing components

## Visual Explanation

```dot
digraph ComponentArchitecture {
    rankdir=TB;
    node [shape=box, style=filled, fillcolor=lightblue];

    App1 [label="Application A"];
    App2 [label="Application B"];
    App3 [label="Application C"];

    node [fillcolor=lightgreen];
    Comp1 [label="Payment Component"];
    Comp2 [label="Inventory Component"];
    Comp3 [label="Shipping Component"];

    node [fillcolor=lightyellow];
    DB [label="Database"];

    App1 -> Comp1;
    App1 -> Comp2;
    App2 -> Comp1;
    App2 -> Comp3;
    App3 -> Comp2;
    App3 -> Comp3;

    Comp1 -> DB;
    Comp2 -> DB;
    Comp3 -> DB;
}
```

## Key Properties
- Components are **independent** and **self-contained**
- Communication happens through **well-defined interfaces**
- Promotes **code reuse** across applications
- Enables **parallel development** by different teams
- **Scalability**: Scale individual components based on demand

## Connections
- **Built from:** [[session-bean|Session Bean]], [[entity-bean|Entity Bean]]
- **Builds into:** [[ejb-container|EJB Container]] (hosts components)
- **Contrasts with:** Monolithic architecture (all-in-one)
- **Related:** [[middleware|Middleware]] (infrastructure for component communication)

## Edge Cases & Gotchas
- Over-decomposition leads to **distributed monolith**—too many tiny components with complex dependencies
- Network overhead: Component calls cross process/JVM boundaries (unlike monolithic in-process calls)
- Versioning: Updating a component interface can break all dependent applications