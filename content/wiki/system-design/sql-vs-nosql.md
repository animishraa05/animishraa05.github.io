---
title: SQL vs NoSQL — Database Paradigm Comparison
type: synthesis
tags: [systems, database]
status: draft
created: 2026-05-15
updated: 2026-05-15
---

## What's Being Compared

SQL (relational) and NoSQL (non-relational) databases represent fundamentally different approaches to data storage. SQL databases enforce rigid schemas and support ACID transactions; NoSQL databases offer flexible schemas and horizontal scalability at the cost of consistency guarantees. The choice is not about which is better — it's about which fits the data and access patterns.

## The Core Tension

SQL optimizes for **data integrity and complex relationships** through normalization, joins, and transactions. NoSQL optimizes for **scale and flexibility** through denormalization, horizontal partitioning, and relaxed consistency. You trade relational power for operational simplicity at scale.

## Comparison

| Dimension | SQL (RDBMS) | NoSQL |
|-----------|-------------|-------|
| Data structure | Tables with rows and columns | Key-value, documents, wide columns, graphs |
| Schema | Strict, predefined | Dynamic, flexible |
| Relationships | Foreign keys + JOINs | Embedded documents or app-level joins |
| Transactions | ACID (Atomic, Consistent, Isolated, Durable) | BASE (Basically Available, Soft state, Eventual consistency) |
| Scaling | Vertical primarily (with replication/sharding) | Horizontal by design |
| Consistency | Strong consistency | Eventual consistency typical |
| Best for | Structured data, complex queries, transactions | Semi-structured data, massive scale, flexible schema |
| Examples | MySQL, PostgreSQL, Oracle | MongoDB, Cassandra, Redis, Neo4j |

## When to Choose SQL

- Data is highly structured with clear relationships
- You need complex JOINs and multi-row transactions
- Your workload has more reads than writes (typical 100:1 or 1000:1)
- You need strong consistency guarantees
- Your team is familiar with relational modeling

## When to Choose NoSQL

- Data is semi-structured or unstructured
- You need to store terabytes or petabytes of data
- Your schema changes frequently
- You need very high write throughput
- You're handling clickstreams, logs, leaderboards, or temporary data (shopping carts)

## The Insight

Many production systems use **both** (polyglot persistence). The relational database holds core business entities with transactional integrity, while NoSQL stores handle high-volume, flexible data like clickstream logs, session data, and user feeds. The question isn't which one, but which one for which part of the system.

## Connections

- [[nosql-database-types|NoSQL Database Types]] — the four categories of NoSQL databases
- [[cap-theorem|CAP Theorem]] — explains the consistency trade-offs in NoSQL
- [[sharding|Sharding]] — horizontal scaling technique used by NoSQL
- [[denormalization|Denormalization]] — SQL technique that mirrors NoSQL's approach
- [[master-slave-replication|Master-Slave Replication]] — SQL scaling technique
