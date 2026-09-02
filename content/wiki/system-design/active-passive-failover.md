---
concept: Active-Passive Failover
aliases: [master-slave failover, hot standby]
tags: [systems, high-availability]
created: 2026-05-15
updated: 2026-05-15
---

## The Problem

A single server is a single point of failure — if it goes down, the service becomes unavailable. Unplanned downtime leads to revenue loss, user trust erosion, and SLA violations.

## Core Idea

Active-passive failover uses a standby server that takes over if the active server fails, with heartbeat monitoring detecting failure and triggering the switch.

## How It Works

1. The active server handles all production traffic while the passive server remains idle.
2. Heartbeat signals are sent between the active and passive servers at regular intervals.
3. If the passive server stops receiving heartbeats, it assumes the active has failed.
4. The passive server takes over the active server's IP address (via IP takeover or virtual IP).
5. The passive resumes service from the point the active left off (with shared storage).
6. Downtime depends on the standby type: hot standby (minutes) vs cold standby (hours).

## Visual Explanation

```dot
digraph active_passive_failover {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  LB [label="Load Balancer"]
  ACTIVE [label="Active Server" fillcolor="#d4edda"]
  PASSIVE [label="Passive Server" fillcolor="#ffe5cc"]
  STORAGE [label="Shared Storage"]

  LB -> ACTIVE [label="routes traffic"]
  ACTIVE -> PASSIVE [label="heartbeat"]
  PASSIVE -> ACTIVE [label="heartbeat (ack)"]
  ACTIVE -> STORAGE [label="reads/writes"]
  PASSIVE -> STORAGE [label="reads on takeover"]
}
```

## Key Properties

- Passive server sits on standby, handling zero traffic during normal operation
- Only the active server handles client requests
- Heartbeat-based failure detection triggers automatic failover
- Also called master-slave failover
- Failover time varies by standby type: hot (minutes) vs cold (hours)

## Connections

- **Contrasts with:** [[active-active-failover|Active-Active Failover]] — passive standby vs both serving traffic
- **Related:** [[availability-nines|Availability Nines]] — failover improves uptime percentage
- **Related:** [[layer4-load-balancing|Layer 4 Load Balancing]] — load balancers orchestrate failover routing
- **Related:** [[horizontal-scaling|Horizontal Scaling]] — adding passive nodes is a scaling concern

## Edge Cases & Gotchas

- Split-brain scenario: both servers think the other is dead and both become active, causing data corruption
- Heartbeat network itself can be a single point of failure — redundant heartbeat links recommended
- Stateful services (in-memory sessions) are lost on failover unless backed by shared storage