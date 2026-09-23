---
concept: Layered Model
aliases: [network layering, protocol layering, OSI model, TCP/IP model]
tags: [networking, theory]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
Networking is complex with many functions (addressing, routing, reliability, applications). Without organization, protocols would be monolithic and impossible to modify independently.

## Core Idea
A conceptual framework that divides network functionality into layers, where each layer provides services to the layer above and uses services from the layer below.

## How It Works
1. Each layer has a specific responsibility (e.g., physical, link, network, transport, application)
2. Data is encapsulated with headers as it moves down layers
3. Data is decapsulated as it moves up layers
4. Peer entities at the same layer communicate using protocols
5. Adjacent layers interact through service interfaces (SAPs)

## Visual Explanation
```dot
digraph G {
    rankdir=TB;
    node [shape=box, style=rounded];
    
    App [label="Application Layer\n(HTTP, DNS, FTP)"];
    Trans [label="Transport Layer\n(TCP, UDP)"];
    Net [label="Network Layer\n(IP, ICMP)"];
    Link [label="Link Layer\n(Ethernet, Wi-Fi)"];
    Phys [label="Physical Layer\n(Bits on wire)"];
    
    App -> Trans -> Net -> Link -> Phys [label="Encapsulation"];
    Phys -> Link -> Net -> Trans -> App [label="Decapsulation", style=dashed];
}
```

## Key Properties
- Modular: each layer can be modified independently
- Encapsulation: each layer adds its header
- Service abstraction: upper layers don't need to know lower layer details
- Two main models: OSI (7 layers) and TCP/IP (4-5 layers)



## Semantic Network

```dot
graph semantic_Layered_Model {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Layered Model" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections
- Built from: [[encapsulation|Encapsulation]] -- wrapping data with headers
- Built from: [[service|Service]] -- what each layer provides
- Built from: [[protocol|Protocol]] -- how peers communicate at each layer
- Related: [[tcp-ip-model|TCP/IP Model]] -- practical 4-layer model
- Related: [[osi-model|OSI Model]] -- conceptual 7-layer model

## Edge Cases & Gotchas
- Strict layering can reduce efficiency (extra headers, processing)
- Some modern protocols blur layer boundaries (e.g., MPLS)
- TCP/IP model is descriptive (how internet works), OSI is prescriptive (how it should work)