---
concept: Network Service
aliases: [service, layer service]
tags: [networking, theory]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
Layers in a network architecture need to provide capabilities to the layer above without exposing implementation details. The upper layer needs to know what functionality is available, not how it's implemented.

## Core Idea
An abstract description of the capabilities or operations that a lower layer provides to the layer directly above it -- the "what" of what a layer offers.

## How It Works
1. Lower layer defines a service interface (Service Access Point)
2. Upper layer makes requests through the interface (service primitives)
3. Lower layer performs the requested operation, possibly using its protocol
4. Lower layer returns responses or indications through the interface
5. The upper layer doesn't need to know protocol details -- just the service contract

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Upper [label="Layer N+1\n(Uses service)"];
    SAP [label="Service Access Point\n(Interface)", shape=diamond, style=filled, fillcolor=lightblue];
    Lower [label="Layer N\n(Provides service\nvia protocol)"];
    
    Upper -> SAP [label="Request"];
    SAP -> Lower [label="Process"];
    Lower -> SAP [label="Indication/Confirm"];
    SAP -> Upper;
}
```

## Key Properties
- Vertical relationship: between adjacent layers on the same system
- Abstract: describes "what" not "how"
- Accessed through service primitives (request, indication, response, confirm)
- Implemented by protocols at the same layer across systems



## Semantic Network

```dot
graph semantic_Network_Service {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Network Service" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections
- Contrasts with: [[protocol|Protocol]] -- service is "what", protocol is "how"
- Built from: [[service-access-point|Service Access Point]] -- the interface point
- Built from: [[service-primitives|Service Primitives]] -- the operations available
- Related: [[layered-model|Layered Model]] -- services exist between layers
- Related: [[connection-oriented-service|Connection-Oriented Service]] -- example of a service

## Edge Cases & Gotchas
- Service primitives are often implemented as API calls (e.g., socket API)
- Service changes require updating all upper layers that use it
- A single service can have multiple protocol implementations