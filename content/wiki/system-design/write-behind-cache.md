---
concept: Write-Behind Cache
aliases: [Write-Back Cache, Background Write Cache]
tags: [systems, caching]
created: 2026-05-15
updated: 2026-05-15
---

## The Problem

Synchronous writes (write-through) add database write latency to every write operation, reducing throughput for write-heavy workloads.

## Core Idea

Write-behind (write-back) cache acknowledges the write to the application immediately and asynchronously persists the data to the database. This decouples write latency from database performance, dramatically improving throughput at the cost of potential data loss if the cache fails before the DB write completes.

## How It Works

1. Application adds or updates an entry in the cache.
2. Cache immediately acknowledges success to the application.
3. Cache asynchronously batches and writes data to the database in the background.
4. The cache may coalesce multiple updates to the same key into a single DB write.

Write performance is greatly improved, but the window between cache acknowledgement and DB persistence creates a risk of data loss.

## Visual Explanation

```dot
digraph WriteBehind {
    rankdir=LR;
    node [shape=box, style=rounded];

    App [label="Application"];
    Cache [label="Cache\n(Writes batched)"];
    DB [label="Database"];

    App -> Cache [label="1. Write(key, data)"];
    Cache -> App [label="2. Immediate ACK"];
    Cache -> DB [label="3. Async batched write"];
    DB -> Cache [label="4. Write OK (async)"];

    App -> Cache [label="5. Read(key)"];
    Cache -> App [label="6. Data (may be dirty)"];
}
```

## Key Properties

- Asynchronous writes decouple application latency from database performance
- Risk of data loss if the cache fails before the DB write completes
- More complex to implement than write-through (needs durability guarantees)
- Ideal for write-heavy workloads that can tolerate temporary inconsistency
- Can batch and coalesce writes for better DB efficiency



## Semantic Network

```dot
graph semantic_Write_Behind_Cache {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Write Behind Cache" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Contrasts with: [[cache-aside|Cache-Aside]] -- app initiates vs cache initiates DB write
- Contrasts with: [[write-through-cache|Write-Through Cache]] -- async vs sync DB write
- Related: [[message-queues|Message Queues]] -- similar async processing and buffering pattern
- Related: [[eventual-consistency|Eventual Consistency]] -- write-behind creates a window of temporary inconsistency

## Edge Cases & Gotchas

- **Data loss on cache failure**: If the cache node crashes before flushing writes to the database, unpersisted data is lost. Requires replication or persistent caching layers to mitigate.
- **Inconsistency window**: Readers may see data in the cache that hasn't yet been written to the database. Downstream systems querying the DB directly will not see the update.
- **Write ordering**: If the cache reorders or coalesces writes, the database may receive updates in a different order than the application issued them.