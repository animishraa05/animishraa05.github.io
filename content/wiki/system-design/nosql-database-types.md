---
concept: NoSQL Database Types
aliases: [NoSQL databases, non-relational databases]
tags: [systems, database]
created: 2026-05-15
updated: 2026-05-15
---

## The Problem

Relational databases (RDBMS) enforce rigid schemas, require ACID transactions, and struggle with semi-structured data, massive scale, and flexible schemas. Many modern applications need faster writes, horizontal scalability, or specialized data models that SQL databases do not provide efficiently.

## Core Idea

NoSQL databases are categorized into four main types based on their data model: key-value stores (hash table), document stores (JSON/XML), wide column stores (nested maps of rows and columns), and graph databases (nodes and edges). Each type trades ACID guarantees for performance, scalability, or flexibility in a specific access pattern.

## How It Works

1. **Key-value stores** (Redis, Memcached, DynamoDB): data is stored as opaque blobs keyed by a unique identifier. O(1) reads/writes, in-memory or SSD-backed. Best for caching, session storage, and leaderboards.

2. **Document stores** (MongoDB, CouchDB): data is stored as self-describing documents (JSON, BSON, XML). Documents can have nested structures and varying schemas. Best for catalogs, content management, and event logging.

3. **Wide column stores** (BigTable, HBase, Cassandra): data is organized as `ColumnFamily<RowKey, Columns<ColKey, Value, Timestamp>>`. Rows can have different columns. Best for time-series data, IoT, and analytics.

4. **Graph databases** (Neo4j, Amazon Neptune): data is stored as nodes (entities) and edges (relationships) with properties on both. Best for social graphs, recommendation engines, and fraud detection.

## Visual Explanation

```dot
digraph NoSQLTypes {
    rankdir=TB;
    node [shape=box, style=rounded];

    NoSQL [label="NoSQL Databases"];

    KV [label="Key-Value Store\nRedis, Memcached\nO(1) lookups"];
    Doc [label="Document Store\nMongoDB, CouchDB\nJSON documents"];
    Wide [label="Wide Column Store\nCassandra, HBase\nColumn families"];
    Graph [label="Graph Database\nNeo4j, Neptune\nNodes + Edges"];

    UseKV [label="Caching\nSessions\nLeaderboards"];
    UseDoc [label="Catalogs\nCMS\nEvent logs"];
    UseWide [label="Time series\nIoT\nAnalytics"];
    UseGraph [label="Social graphs\nRecommendations\nFraud"];

    NoSQL -> KV;
    NoSQL -> Doc;
    NoSQL -> Wide;
    NoSQL -> Graph;

    KV -> UseKV;
    Doc -> UseDoc;
    Wide -> UseWide;
    Graph -> UseGraph;
}
```

## Key Properties

- **BASE semantics** — Basically Available, Soft state, Eventual consistency (instead of ACID)
- **Denormalized by nature** — data is stored in read-optimized shapes; joins happen in application code
- **No true ACID transactions** — most NoSQL databases do not support multi-document/row transactions
- **Designed for horizontal scaling** — built-in sharding and replication for massive scale
- **Each type optimized for specific access patterns** — choosing the wrong type leads to poor performance

## Connections

- **Builds into:** [[sql-vs-nosql|SQL vs NoSQL]] — a synthesis comparing relational and non-relational approaches
- **Related:** [[cap-theorem|CAP Theorem]] — NoSQL databases typically prioritize Availability and Partition tolerance over Consistency
- **Related:** [[denormalization|Denormalization]] — NoSQL databases are inherently denormalized; data duplication is by design
- **Related:** [[sharding|Sharding]] — most NoSQL databases have built-in sharding, making horizontal scaling straightforward
- **Related:** [[cache-aside|Cache-Aside]] — key-value stores (Redis, Memcached) are the most common caching layer

## Edge Cases & Gotchas

- **Wrong tool for the job** — using a document store for deeply relational data (e.g., accounting systems) leads to application-level join spaghetti and data inconsistency.
- **NoSQL does not mean no schema** — while schemas are flexible at write time, the application code implicitly defines a schema that must be managed; schema drift is a real problem.
- **Eventual consistency surprises** — reading your own write may return stale data; this breaks user expectations in applications like social media or e-commerce.

## Sources

- [[readmemd-summary|System Design Primer Summary]]
