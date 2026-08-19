---
concept: Availability in Parallel vs Sequence
aliases: [series availability, parallel availability, combined availability]
tags: [systems, high-availability]
created: 2026-05-15
updated: 2026-05-15
---

## The Problem

When a system has multiple components, overall availability depends on how they are connected. Naively combining component availability gives misleading results.

## Core Idea

Components in sequence multiply their availability together (making total availability worse), while components in parallel multiply their unavailability together (making total availability dramatically better).

## How It Works

1. **Sequence formula:** `Avail(Total) = Avail(A) × Avail(B)`. Two 99.9% components in series yield 99.8% — worse than either alone.
2. **Parallel formula:** `Avail(Total) = 1 - (1 - Avail(A)) × (1 - Avail(B))`. Two 99.9% components in parallel yield 99.9999% — better than either alone.
3. Parallel systems only fail if both (or all) redundant components fail simultaneously.

## Visual Explanation

```dot
digraph availability_parallel_sequence {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  subgraph cluster_sequence {
    label="In Sequence (99.9% × 99.9% = 99.8%)"
    style=filled
    fillcolor="#ffe5cc"
    S1 [label="Component A\n99.9%"]
    S2 [label="Component B\n99.9%"]
    S1 -> S2
  }

  subgraph cluster_parallel {
    label="In Parallel (1 - 0.001² = 99.9999%)"
    style=filled
    fillcolor="#d4edda"
    P1 [label="Component A\n99.9%"]
    P2 [label="Component B\n99.9%"]
    P_IN [label="Input" shape=point]
    P_OUT [label="Output" shape=point]
    P_IN -> P1
    P_IN -> P2
    P1 -> P_OUT
    P2 -> P_OUT
  }
}
```

## Key Properties

- Sequential components multiply availability — total is always _worse_ than the worst component
- Parallel components multiply unavailability — total is always _better_ than the best component
- Fundamental principle underlying all reliability engineering and redundancy design

## Connections

- **Builds into:** [[availability-nines|Availability Nines]] — the formula behind nines calculations
- **Related:** [[active-passive-failover|Active-Passive Failover]] — parallel arrangement of servers for failover
- **Related:** [[active-active-failover|Active-Active Failover]] — parallel arrangement for load sharing and redundancy
- **Related:** [[horizontal-scaling|Horizontal Scaling]] — adding parallel nodes improves overall system availability

## Edge Cases & Gotchas

- Components are rarely perfectly independent — shared power supplies, network links, or data centers create common-mode failures that violate the parallel model
- The parallel formula assumes instant failover, but real failover has non-zero downtime that reduces effective availability
- Very long dependency chains (many sequential components) degrade availability drastically — a system with ten 99.9% components in series is only 99.0% available

## Sources

- [[readmemd-summary|System Design Primer Summary]] — availability section on combining component availability
