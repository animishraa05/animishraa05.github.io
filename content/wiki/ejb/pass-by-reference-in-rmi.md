---
concept: Pass-by-Reference in RMI
aliases: [Pass by Reference, Remote Reference]
tags: [dev, rmi]
created: 2026-04-28
updated: 2026-04-28
---

## The Problem
Sometimes we need the server to actually act on the client's object, not a copy. How can RMI allow a remote method call to modify the original object on the client side?

## Core Idea
In RMI, objects that implement the Remote interface are passed by reference. Instead of serializing the object, Java sends a stub that acts as a network proxy. All method calls on the stub are forwarded to the original object in the client's JVM.

## How It Works
1. Client calls: remoteObj.method(remoteObject) where remoteObject implements Remote
2. RMI sends a stub for remoteObject instead of serializing it
3. Server receives stub as a reference
4. When server calls methods on this stub, the calls go back over network
5. The calls execute in the client's JVM on the original object
6. The server is actually modifying the client's object
7. This creates the illusion of shared memory across JVMs

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    "Client JVM" [label="Client JVM\nOriginal Object"];
    "Server JVM" [label="Server JVM\ncalls stub.method()"];
    
    "Client JVM" -> "Server JVM" [label="Stub sent", style=dashed];
    "Server JVM" -> "Client JVM" [label="Method calls forwarded", style=dashed];
}
```

## Key Properties
- Stub-based: A proxy is sent instead of the actual object
- Shared behavior: Server's actions affect original object
- Network calls: Every method call on stub goes over network
- Only for Remote objects: Regular objects cannot use this
- Identity preserved: Original object is shared, not copied
- Bidirectional: Communication can happen both ways

## Connections
- Built from: [[rmi-remote-method-invocation|RMI Remote Method Invocation]] — mechanism for remote calls
- Built from: [[ejb-object|EJB Object]] — is essentially a pass-by-reference stub
- Contrasts with: [[pass-by-value-in-rmi|Pass-by-Value in RMI]] — normal objects are copied

## Edge Cases & Gotchas
- Performance overhead: Every call on stub is a network call
- If client JVM goes down, stub becomes invalid
- Only Remote objects can be passed by reference
- Latency: Calls can fail or be slow
- Security: Remote object on client must be accessible