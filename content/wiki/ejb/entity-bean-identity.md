---
concept: "Entity Bean Identity"
aliases: [entity bean primary key, EJB identity]
tags: [dev, ejb, entity-bean]
created: 2026-04-29
updated: 2026-04-29
---

## The Problem
Session beans are all equivalent (especially stateless)—there's no way to distinguish one from another. But entity beans represent specific data records (like a specific bank account). How do you identify which entity bean instance represents which record?

## Core Idea
Entity beans have an **identity**—a primary key that uniquely distinguishes each instance. This allows:
- Comparing two entity beans ("Are they the same account?")
- Clients referring to specific entities by their primary key
- Sharing entities across multiple clients (unlike session beans which are client-dedicated)

The identity is typically the primary key of the database row the entity represents.

## How It Works
1. **Define primary key class**: `AccountPK` with fields matching the table's primary key
2. **`getPrimaryKey()` method**: Entity beans implement this to return their primary key
3. **Finder methods**: `ejbFindByPrimaryKey(PK)` locates the correct database record
4. **Client reference**: Client can pass primary keys to other clients, enabling shared access

## Visual Explanation

```dot
digraph Identity {
    rankdir=LR;
    node [shape=box, style=filled];

    subgraph cluster_entities {
        E1 [label="Entity Bean A\nPK = 1\n(Ray's Account)", fillcolor=lightgreen];
        E2 [label="Entity Bean B\nPK = 2\n(Bob's Account)", fillcolor=lightyellow];
        E3 [label="Entity Bean C\nPK = 3\n(Monty's Account)", fillcolor=lightblue];
    }

    Client1 [label="Client 1\nAsks for PK=1", fillcolor=lightcoral];
    Client2 [label="Client 2\nAlso asks for PK=1", fillcolor=lightcoral];

    Client1 -> E1 [label="Both clients can\nshare same entity!"];
    Client2 -> E1;
}
```

## Key Properties
- **Primary key = identity**: Two entity beans with same PK represent the same data
- **Shared across clients**: Unlike session beans, multiple clients can use the same entity
- **Not just for databases**: Identity concept applies even if using object databases
- **`getPrimaryKey()` in BMP**: Bean uses PK to know which record to load/store in `ejbLoad()`/`ejbStore()`

## Connections
- **Built from:** [[entity-bean|Entity Bean]], [[primary-key-class|Primary Key Class]]
- **Builds into:** [[finder-methods|Finder Methods]] (locate entities by identity)
- **Related:** [[ejbcreate|ejbCreate()]], [[ejbload|ejbLoad()]], [[ejbstore|ejbStore()]]
- **Contrasts with:** [[session-bean|Session Bean]] (no identity—anonymous workers)

## Edge Cases & Gotchas
- **Composite primary keys**: Sometimes PK has multiple fields—need a custom `PK` class
- **Identity crisis in pool**: Pooled entity beans can represent different records at different times (container swaps the data)
- **`getPrimaryKey()` not for clients**: It's for BMP beans to know which record to access