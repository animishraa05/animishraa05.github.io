---
concept: Remote Interface
aliases: [Remote]
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

> Note: Also see [[local-home-interface|Local Home Interface]] for same-JVM version, and [[why-bean-doesnt-implement-interface|Why Bean Doesn't Implement Component Interface]] for design rationale.

## The Problem
What methods can a client actually call on an Enterprise Bean? The client needs to know the available business operations without having access to the implementation (bean class). The interface should be separate from implementation for loose coupling.

## Core Idea
The Remote Interface defines the business methods that clients can invoke on an Enterprise Bean. It declares WHAT the bean does, not HOW it does it. The container implements this interface and the client uses it to call bean methods.

## How It Works
1. Bean provider defines the Remote Interface (extends EJBObject in EJB 2.x)
2. Container implements the interface and creates an EJB Object
3. Client obtains reference to Remote Interface via Home Interface or dependency injection
4. Client calls methods on Remote Interface
5. Calls are forwarded through EJB Object to actual bean implementation
6. All remote communication is handled transparently

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    "Remote Interface" [shape=doubleoctagon];
    "Client" -> "Remote Interface" [label="1. calls business method"];
    "Remote Interface" -> "EJB Object" [label="2. Delegates"];
    "EJB Object" -> "Bean Class" [label="3. Execute"];
    
    "Bean Class" [style=dashed];
}
```

## Key Properties
- Declares business methods: What operations the bean exposes
- Extends EJBObject: Inherits infrastructure like remove(), getPrimaryKey()
- One-per-bean-type: Each bean type has its own Remote Interface
- Local variant: Local interface for same JVM calls (optimization)
- In EJB 3.x: Annotations replace many interface requirements
- Method signatures only: No implementation logic here

## Connections
- Built from: [[ejb-object|EJB Object]] — container implements Remote on behalf of bean
- Builds into: [[session-bean|Session Bean]] — Remote interface defines session bean methods
- Builds into: [[entity-bean|Entity Bean]] — Remote interface defines entity bean methods
- Related: [[home-interface|Home Interface]] — Home creates, Remote executes
- Related: [[local-interface|Local Interface]] — same JVM variant

## Edge Cases & Gotchas
- All methods in Remote Interface must throw RemoteException (checked)
- In local calls, Remote Interface overhead can be avoided by using Local Interface
- EJB 3.x uses POJOs with annotations — explicit interfaces less required
- The interface should only declare business methods, not lifecycle methods

## Sources
- [[ejb3-summary|EJB3 Source Summary]]