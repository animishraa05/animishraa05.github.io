---
concept: RMI Remote Method Invocation
aliases: [RMI, Remote Method Invocation]
tags: [dev, rmi]
created: 2026-04-28
updated: 2026-04-28
---

## The Problem
How can an object in one JVM call a method on an object in a different JVM (different machine)? Normal method calls only work within the same JVM. We need a mechanism that makes remote calls feel like local calls.

## Core Idea
RMI is a Java mechanism that allows an object in one JVM to invoke methods on an object located in another JVM. It creates the illusion of local method calls by handling all network communication transparently through stubs and serialization.

## How It Works
1. Remote Interface defines methods that can be called remotely (extends Remote)
2. Implementation class implements the interface (extends UnicastRemoteObject)
3. Server registers the object with RMI Registry using Naming.rebind()
4. Client looks up the object using Naming.lookup() and gets a stub
5. Client calls method on stub
6. Stub serializes parameters, sends request over network
7. Server receives, deserializes, executes method
8. Result is serialized and sent back
9. Client deserializes and returns result

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    "Client JVM" [shape=record, label="{Client|Stub}"];
    "Server JVM" [shape=record, label="{Skeleton|Remote Object}"];
    
    "Client JVM" -> "Server JVM" [label="Network (RMI-IIOP)"];
}
```

## Key Properties
- Location transparency: Client cannot tell if object is local or remote
- Object serialization: Parameters/returns converted to byte streams
- Stub/Skeleton: Client proxy and server proxy handle communication
- RMI Registry: Naming service to locate remote objects
- Garbage collection: Remote objects can be collected when no references exist
- Security: Can use SecurityManager to control remote code execution

## Connections
- Built from: [[object-serialization|Object Serialization]] — serializes data for network transfer
- Builds into: [[ejb-object|EJB Object]] — EJB uses RMI underneath
- Builds into: [[rmi-registry|RMI Registry]] — provides naming for RMI objects
- Related: [[jndi|JNDI]] — JNDI is a generalized naming system beyond RMI
- Contrasts with: [[socket-programming|Socket Programming]] — RMI is higher level

## Edge Cases & Gotchas
- Network failures can cause RemoteException
- Serialization has performance cost
- Pass-by-value for normal objects, pass-by-reference for Remote objects
- Class must be available on both client and server
- Not used much today — replaced by REST, gRPC, SOAP