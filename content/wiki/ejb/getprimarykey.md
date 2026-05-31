---
concept: getPrimaryKey()
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

# getPrimaryKey()

## The Problem

When an entity bean instance is pooled and reused to represent different database records, how does the bean know which specific record it is currently handling during callbacks like `ejbLoad()` or `ejbRemove()`?

## Core Idea

`getPrimaryKey()` is a method on EntityContext that returns the primary key of the entity currently associated with the bean instance. This lets a BMP bean identify the exact database row to load, store, or delete.

## How It Works

- Bean calls `ctx.getPrimaryKey()` to get its current identity
- Container sets the primary key in the context when assigning a data instance to the bean
- Bean must query this in `ejbLoad()` to know which record to SELECT
- Bean must query this in `ejbRemove()` to know which record to DELETE
- In `ejbStore()`, the bean already has data in memory, so not needed

## Key Properties

- Returns a Primary Key object (e.g., AccountPK) uniquely identifying the entity
- Required in BMP implementations; optional in CMP
- Called right after activation and before passivation
- Bean instance may switch data instances multiple times during lifecycle

## Connections

- Built from: [[entity-context|Entity Context]], [[entity-bean|Entity Bean]]
- Builds into: [[ejbload|ejbLoad()]], [[ejbremove|ejbRemove()]], [[bean-managed-persistence|Bean-Managed Persistence]]
- Related: [[finder-methods|Finder Methods]], [[primary-key|Primary Key]]

## Edge Cases & Gotchas

- Do NOT call in `ejbStore()`—data is already in memory
- Must be called on the EntityContext, not on `this`
- Pooled beans don't have an identity until activated
- If called when context is null, throws IllegalStateException

## Sources

- [[ejb-continued-summary|EJbContinued]]