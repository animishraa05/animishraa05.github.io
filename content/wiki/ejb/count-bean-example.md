---
concept: Count Bean Example
aliases: [Stateful Session Bean Example, CountBean]
tags: [dev, ejb]
sources_count: 1
last_source: ejb6.md
created: 2026-04-29
updated: 2026-04-29
---

## The Problem
Learning EJB concepts abstractly is hard. Students need a concrete, minimal example that demonstrates stateful session beans, passivation/activation, and the full EJB lifecycle in action.

## Core Idea
The Count Bean is a simple stateful session bean example that maintains a conversational state (an integer counter `val`). It demonstrates the full EJB development cycle: remote interface, home interface, bean class, deployment descriptor, and client code.

## How It Works
1. **Remote Interface (`Count`)**: Extends `EJBObject`, declares `count()` business method that throws `RemoteException`
2. **Bean Class (`CountBean`)**: Implements `SessionBean`, has `val` as conversational state, implements `count()` to increment and return `val`
3. **Lifecycle Callbacks**: `ejbCreate(int val)` initializes state, `ejbPassivate()` serializes to storage, `ejbActivate()` restores from storage
4. **Home Interface (`CountHome`)**: Extends `EJBHome`, declares `create(int val)` which maps to `ejbCreate()`
5. **Deployment Descriptor**: Declares `<session-type>Stateful</session-type>` in `ejb-jar.xml`
6. **Client**: Looks up Home via JNDI, calls `home.create(10)`, calls `count()` to increment

The example shows passivation when pool limit (2 beans) is reached, then activation when beans are reused.

## Visual Explanation
```dot
digraph G {
    rankdir=TB;
    node [shape=box, style=rounded];
    
    "Client" [style=filled, fillcolor=lightgreen];
    
    subgraph cluster_ejb {
        label = "EJB Container";
        "Home Object" [shape=diamond, style=filled, fillcolor=lightblue];
        "CountBean Instance 1" [label="CountBean\nval=10"];
        "CountBean Instance 2" [label="CountBean\nval=20"];
        "Pool" [shape=cylinder, label="Pool\n(empty or\nserialized beans)"];
    }
    
    "Client" -> "Home Object" [label="JNDI lookup"];
    "Home Object" -> "CountBean Instance 1" [label="create(10)"];
    "Client" -> "CountBean Instance 1" [label="count()"];
    "CountBean Instance 1" -> "Pool" [label="ejbPassivate()"];
    "Pool" -> "CountBean Instance 1" [label="ejbActivate()"];
}
```

## Key Properties
- **Stateful**: Maintains conversational state (`val`) across method calls
- **Passivation**: Bean serialized to storage when pool is full or idle
- **Activation**: Bean restored from storage when needed again
- **Serialiable state**: `val` is serialiable (primitive int)
- **JNDI lookup**: Client finds Home Object via JNDI, not `new`
- **No `this`**: Bean uses `SessionContext.getEJBObject()` to get self-reference

## Connections
- Built from: [[stateful-session-bean|Stateful Session Bean]] — CountBean is a stateful bean
- Built from: [[remote-interface|Remote Interface]] — Count interface extends EJBObject
- Built from: [[home-interface|Home Interface]] — CountHome is the factory
- Built from: [[passivation|Passivation]] — demonstrated when pool limit reached
- Built from: [[activation|Activation]] — demonstrated when bean reused
- Builds into: [[ejb-development-lifecycle|EJB Development Lifecycle]] — full example of the lifecycle
- Related: [[session-context|SessionContext]] — provides `getEJBObject()` for self-reference
- Related: [[instance-pooling|Instance Pooling]] — pool management triggers passivation

## Edge Cases & Gotchas
- **Stateful cannot be pooled**: Unlike stateless, each client gets dedicated bean
- **Passivation failure**: `val` must be serialiable, or passivation fails
- **`this` danger**: Never pass `this` to other beans—use `getEJBObject()`
- **Pool limit**: Container-specific setting controls when passivation occurs
- **Server crash**: Passivated state may be lost if server crashes

## Sources
- [[ejb6-summary|EJB6 Source Summary]]
