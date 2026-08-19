---
concept: Transactions in EJB
aliases: [ACID, Transaction Properties, EJB Transactions]
tags: [dev, ejb]
sources_count: 1
last_source: EJb4.md
created: 2026-04-28
updated: 2026-04-28
---

## The Problem
Enterprise beans perform mission-critical tasks that must be reliable and robust. Without transactions, partial failures (e.g., debiting one account but not crediting the other) lead to data inconsistency. EJB abstracts low-level transaction systems so developers focus on business logic.

## Core Idea
Transactions in EJB provide ACID properties (Atomicity, Consistency, Isolation, Durability) for enterprise bean operations. The EJB container abstracts the underlying transaction system — beans only vote on commit/abort, never interact directly with transaction managers.

## How It Works
1. EJB uses **flat transactions** (all-or-nothing, no nested transactions in EJB spec)
2. Transaction boundaries are demarcated via: Programmatic (BMT), Declarative (CMT), or Client-Initiated
3. Container handles: begin, commit, rollback — bean signals success/failure
4. Entity beans: `ejbLoad()` acquires locks → business methods run → `ejbStore()` writes and releases locks (all within one transaction)
5. Transaction spans entire set of operations or per-method depending on demarcation style

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Bean [label="Enterprise Bean\nbusiness logic"];
    Container [label="EJB Container\ntransaction handling"];
    TX [label="Transaction\n(ACID properties)"];
    DB [label="Database"];
    
    Bean -> Container [label="votes commit/abort"];
    Container -> TX [label="begin/commit/rollback"];
    TX -> DB [label="consistent operations"];
}
```

## Key Properties
- **ACID:** Atomicity (all-or-nothing), Consistency (valid state), Isolation (concurrent tx don't interfere), Durability (committed data survives crashes)
- EJB uses flat transactions (nested transactions NOT supported)
- Container abstracts low-level transaction system (bean never touches transaction manager)
- Entity beans load/store per transaction, not per method call
- Transaction attributes (in deployment descriptor) control when transactions start/end

## Connections
- Built from: [[ejb-container|EJB Container]] — container manages transaction boundaries
- Builds into: [[transaction-demarcation|Transaction Demarcation]] — 3 ways to control transactions
- Builds into: [[entity-bean-transactions|Entity Bean Transaction Rules]] — entity beans must use CMT
- Builds into: [[flat-vs-nested-transactions|Flat vs Nested Transactions]] — EJB uses flat only
- Related: [[poison-message|Poison Message]] — MDB rollback in CMT causes poison messages
- Related: [[declarative-vs-programmatic-transactions|CMT vs BMT]] — comparison of demarcation styles

## Edge Cases & Gotchas
- Nested transactions are NOT supported in EJB (despite being described in the book)
- Entity beans transaction spans ejbLoad → methods → ejbStore (not per individual method)
- If each entity bean method is a separate transaction, performance suffers (too many DB reads/writes)
- Client-initiated transactions over network have higher rollback rates (network failures)

## Sources
- [[EJb4-summary|EJb4.md Source Summary]]
