---
source: "System Design Primer (README.md)"
source_path: sources/readmemd.md
ingested: 2026-05-15
concepts_count: 38
---

## What This Source Is

The System Design Primer README (`readmemd.md`) is a comprehensive guide to large-scale system design, extracted from the GitHub repository by Donne Martin. It covers the full spectrum of system design topics — from foundational trade-offs (performance vs scalability, CAP theorem) through infrastructure components (DNS, CDNs, load balancers, reverse proxies), database strategies (replication, federation, sharding, NoSQL), caching patterns, asynchronous processing, and communication protocols (RPC, REST). It also includes study guides for system design interviews and back-of-the-envelope calculation references.

## Concepts Extracted

**Created (38 concept pages + 2 syntheses):**

Foundational Trade-offs:
- [[performance-vs-scalability|Performance vs Scalability]] — speed for one user vs consistent speed under load
- [[latency-vs-throughput|Latency vs Throughput]] — time per action vs actions per unit time
- [[cap-theorem|CAP Theorem]] — pick two: Consistency, Availability, Partition Tolerance
- [[cp-consistency-partition-tolerance|CP — Consistency and Partition Tolerance]] — consistency over availability during partitions
- [[ap-availability-partition-tolerance|AP — Availability and Partition Tolerance]] — availability over consistency during partitions
- [[weak-consistency|Weak Consistency]] — no guarantee reads see recent writes
- [[eventual-consistency|Eventual Consistency]] — reads eventually converge to latest write
- [[strong-consistency|Strong Consistency]] — all reads guaranteed to see latest write

Availability & Infrastructure:
- [[active-passive-failover|Active-Passive Failover]] — standby server takes over on failure
- [[active-active-failover|Active-Active Failover]] — both servers handle traffic simultaneously
- [[availability-nines|Availability Nines]] — uptime measured in 9s
- [[availability-parallel-vs-sequence|Availability in Parallel vs Sequence]] — how component arrangement affects total availability
- [[dns-system-design|DNS in System Design]] — hierarchical domain-to-IP translation
- [[cdn-push|Push CDN]] — server pushes content to CDN on change
- [[cdn-pull|Pull CDN]] — CDN pulls content on first request
- [[layer4-load-balancing|Layer 4 Load Balancing]] — transport-layer request distribution
- [[layer7-load-balancing|Layer 7 Load Balancing]] — application-layer content-aware routing
- [[horizontal-scaling|Horizontal Scaling]] — adding more commodity servers for scale
- [[reverse-proxy-pattern|Reverse Proxy]] — unified public interface to backend services

Architecture & Application Layer:
- [[microservices-architecture|Microservices Architecture]] — independently deployable modular services
- [[service-discovery|Service Discovery]] — dynamic service location via registry

Database:
- [[master-slave-replication|Master-Slave Replication]] — single write master, read replicas
- [[master-master-replication|Master-Master Replication]] — multi-write with coordination
- [[database-federation|Database Federation]] — splitting databases by function
- [[sharding|Sharding]] — distributing data across databases by key
- [[denormalization|Denormalization]] — redundant data to avoid joins
- [[sql-tuning|SQL Tuning]] — optimizing schema, indices, and queries
- [[nosql-database-types|NoSQL Database Types]] — key-value, document, wide column, graph

Caching:
- [[cache-aside|Cache-Aside]] — app loads cache on demand (lazy loading)
- [[write-through-cache|Write-Through Cache]] — cache synchronously updates DB
- [[write-behind-cache|Write-Behind Cache]] — cache asynchronously updates DB
- [[refresh-ahead-cache|Refresh-Ahead Cache]] — proactive cache refresh before expiry

Asynchronous Processing:
- [[message-queues|Message Queues]] — async message delivery between services
- [[task-queues|Task Queues]] — scheduled background computation
- [[back-pressure|Back Pressure]] — queue size limiting for system stability

Communication:
- [[rpc-remote-procedure-call|RPC]] — remote call that looks local
- [[rest-architectural-style|REST]] — resource-oriented architectural style

Estimation:
- [[back-of-envelope-estimates|Back-of-Envelope Estimates]] — quick capacity calculations

**Syntheses Created:**
- [[load-balancer-vs-reverse-proxy|Load Balancer vs Reverse Proxy]] — comparing traffic distribution vs backend abstraction
- [[sql-vs-nosql|SQL vs NoSQL]] — comparing relational vs non-relational database paradigms

## Key Takeaways

1. **Everything is a trade-off** — system design is about making informed trade-offs between performance, scalability, consistency, and complexity.
2. **CAP theorem is the foundation** — in distributed systems, partition tolerance is mandatory; the real choice is between consistency (CP) and availability (AP).
3. **Caching is the #1 performance technique** — four strategies (cache-aside, write-through, write-behind, refresh-ahead) address different read/write patterns.
4. **Scale out, not up** — horizontal scaling with commodity hardware is cheaper and more available than vertical scaling with expensive machines.
5. **Asynchronism decouples** — message queues and task queues let systems handle spikes gracefully and enable independent service scaling.
6. **REST vs RPC is about coupling** — REST minimizes client-server coupling for public APIs; RPC maximizes performance for internal services.
7. **Know your latency numbers** — L1 cache (0.5ns) → RAM (100ns) → SSD (150μs) → HDD (10ms) spans 4 orders of magnitude.

## Open Questions

- How does HTTP/2 multiplexing change the TCP connection overhead calculation?
- What real-world latencies do serverless functions add to system design?
- How do modern service meshes (Istio, Linkerd) change the reverse proxy vs load balancer distinction?
- What is the practical trade-off between refresh-ahead and cache-aside for different access patterns?
