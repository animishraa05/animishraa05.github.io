---
concept: setEntityContext()
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

# setEntityContext()

## The Problem

When the EJB container creates a new entity bean instance for the pool, how does the bean gain access to container services and environment information?

## Core Idea

`setEntityContext()` is called by the container when a new entity bean instance is created. It provides the bean with its EntityContext, enabling access to container services like JNDI lookups and security information.

## How It Works

- Container instantiates a new entity bean class
- Container calls `setEntityContext(EntityContext ctx)` on the instance
- Bean stores the context in a member variable for later use
- Bean can now query environment info via JNDI (DataSource, etc.)
- Bean enters the pool—no specific data associated yet

## Key Properties

- Called exactly once when the bean instance is created
- Bean can retrieve resources and environment data here
- Context should be stored for use in lifecycle callbacks
- Bean is now in the pool but has no specific data

## Connections

- Built from: [[entity-bean|Entity Bean]], [[ejb-container|EJB Container]]
- Builds into: [[entity-context|Entity Context]], [[unsetentitycontext|unsetEntityContext()]]
- Related: [[instance-pooling|Instance Pooling]]

## Edge Cases & Gotchas

- Do NOT perform database operations here
- Do NOT assume the bean is associated with any data

## Sources

- [[ejb-continued-summary|EJbContinued]]