---
concept: "Entity Bean Instance vs Data"
aliases: [entity bean in-memory vs persistent, entity bean terminology]
tags: [dev, ejb, entity-bean]
created: 2026-04-29
updated: 2026-04-29
---

## The Problem
The term "Entity Bean" is used loosely—sometimes it means the in-memory Java object, sometimes it means the database record. This confusion makes discussions about entity beans unclear. What's the difference?

## Core Idea
The EJB spec clarifies two distinct concepts:

1. **Entity Bean Instance**: The in-memory Java object (an instance of your entity bean class). It's the "view" into the database.
2. **Entity Bean Data**: The actual persistent data stored in the database (the record/row).

The instance loads data from the database (in `ejbLoad()`), modifies it in memory, and saves it back (in `ejbStore()`).

## How It Works

```
Database Record (Entity Bean Data)
    ↓ ejbLoad()
In-Memory Object (Entity Bean Instance)
    ↓ business methods modify fields
In-Memory Object (with changes)
    ↓ ejbStore()
Database Record (updated)
```

## Visual Explanation

```dot
digraph InstanceVsData {
    rankdir=TB;
    node [shape=box, style=filled];

    Data [label="Entity Bean Data\n(Database Row)\n| ID | Owner | Balance |\n| 1 | Ray | 1000 |", fillcolor=lightyellow, shape=cylinder];

    Instance [label="Entity Bean Instance\n(In-Memory Java Object)\naccountID=1, owner=\"Ray\", balance=1000", fillcolor=lightgreen];

    Data -> Instance [label="1. ejbLoad()\nRead from DB"];
    Instance -> Data [label="2. ejbStore()\nWrite to DB"];

    note [label="Client modifies balance\nInstance.balance = 2000", fillcolor=lightcoral, shape=note];
    Instance -> note;
}
```

## Key Properties
- **Instance is temporary**: Created when needed, may be pooled/reused for different data
- **Data is permanent**: Survives server crashes, lives in database
- **One-to-one mapping**: At any moment, one instance represents one data record
- **Container manages sync**: `ejbLoad()` and `ejbStore()` keep instance and data in sync

## Connections
- **Built from:** [[entity-bean|Entity Bean]], [[ejbload|ejbLoad()]], [[ejbstore|ejbStore()]]
- **Builds into:** [[bean-managed-persistence|BMP]], [[container-managed-persistence|CMP]]
- **Related:** [[persistence-concepts|Persistence Concepts]]
- **Contrasts with:** Session beans (no persistent data, only in-memory instances)

## Edge Cases & Gotchas
- **Stale data**: If another client modifies the DB directly, in-memory instance has old data (until next `ejbLoad()`)
- **Instance pooling**: The same Java instance might represent Ray's account now, Bob's account later (container reuses instances)
- **Transparent to client**: Client doesn't know or care about instance vs data distinction—they just call methods