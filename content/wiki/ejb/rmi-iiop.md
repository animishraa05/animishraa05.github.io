---
concept: RMI-IIOP
aliases: [RMI over IIOP, Internet Inter-ORB Protocol]
tags: [dev, ejb, rmi]
sources_count: 1
last_source: ejb6.md
created: 2026-04-29
updated: 2026-04-29
---

# RMI-IIOP

## The Problem
RMI (Remote Method Invocation) originally used JRMP (Java Remote Method Protocol), which only works between Java objects. To integrate with CORBA (cross-language), we need RMI to use IIOP (Internet Inter-ORB Protocol) as its transport.

## Core Idea
RMI-IIOP is RMI extended to use the IIOP protocol, enabling CORBA integration. It's the official API used in J2EE (not plain RMI). EJB objects are fully networked RMI-IIOP objects callable from other JVMs.

## How It Works
1. **EJB Object**: Implements `javax.ejb.EJBObject` which extends `java.rmi.Remote`
2. **RMI-IIOP**: Uses IIOP protocol instead of JRMP
3. **Remote exceptions**: All remote methods must throw `java.rmi.RemoteException`
4. **Parameter passing**: Primitives, serializable objects, RMI-IIOP remote objects
5. **CORBA integration**: Can interoperate with CORBA objects via IIOP

Appendix A covers RMI-IIOP in detail.

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    "Client JVM" [style=filled, fillcolor=lightgreen];
    "EJB Object" [shape=diamond, style=filled, fillcolor=lightblue];
    "CORBA Object" [shape=box, style=filled, fillcolor=lightyellow];
    
    "Client JVM" -> "EJB Object" [label="RMI-IIOP"];
    "EJB Object" -> "CORBA Object" [label="IIOP"];
}
```

## Key Properties
- **IIOP protocol**: Standard CORBA wire protocol
- **Official J2EE**: Used instead of plain RMI in J2EE
- **RemoteException**: All remote methods must declare this
- **Parameter rules**: Only certain types can be passed (primitives, serializable, remote objects)
- **CORBA compatible**: Enables cross-language calls

## Connections
- Built from: [[rmi-remote-method-invocation|RMI]] — RMI-IIOP extends RMI
- Builds into: [[ejb-object|EJB Object]] — EJB objects are RMI-IIOP objects
- Related: [[java-idl|Java IDL]] — Java IDL also uses CORBA/IIOP
- Related: [[distributed-objects|Distributed Objects]] — RMI-IIOP enables distributed Java objects
- Contrasts with: [[rmi-registry|RMI Registry]] — RMI-IIOP uses IIOP, not JRMP

## Edge Cases & Gotchas
- **Parameter restrictions**: Not all objects can be passed (must be serializable or remote)
- **RemoteException**: Forgetting to declare it causes compile error
- **Firewall issues**: IIOP may be blocked (use HTTP tunneling if needed)
- **Appendix A**: See full RMI-IIOP details there

## Sources
- [[ejb6-summary|EJB6 Source Summary]]
