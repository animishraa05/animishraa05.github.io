---
concept: Service Access Point
aliases: [SAP, service interface]
tags: [networking, theory]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
Layers in a network stack need a well-defined point where they exchange data and control information. Without a clear interface, layer implementations would be tightly coupled and hard to modify independently.

## Core Idea
The interface point between two adjacent protocol layers where the upper layer requests services from the lower layer.

## How It Works
1. Each layer exposes a SAP for the layer above
2. Upper layer invokes service primitives at the SAP
3. Data and parameters are passed through the SAP
4. Lower layer delivers indications and confirmations through the SAP
5. The SAP abstracts the lower layer's implementation from the upper layer

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    App [label="Application Layer"];
    SAP [label="Socket API\n(Service Access Point)", shape=diamond, style=filled, fillcolor=yellow];
    Transport [label="Transport Layer (TCP)"];
    
    App -> SAP [label="socket(), connect(),\nsend(), recv()"];
    SAP -> Transport [label="Pass data +\nparameters"];
    Transport -> SAP [label="Data received,\nconnection events"];
    SAP -> App;
}
```

## Key Properties
- Layer boundary interface
- Implemented as API calls in practice (e.g., Berkeley sockets)
- Identified by a SAP address (e.g., port number for transport layer)
- Enables layer independence and modularity

## Connections
- Built from: [[service|Service]] — the service provided through the SAP
- Built from: [[service-primitives|Service Primitives]] — operations at the SAP
- Related: [[socket-api|Socket API]] — common SAP implementation
- Related: [[layered-model|Layered Model]] — SAPs exist between layers

## Edge Cases & Gotchas
- SAP exhaustion (e.g., running out of ports) prevents new connections
- SAP addressing must be unique within a system (e.g., IP+port combination)
- Some SAPs are connection-oriented, others connectionless