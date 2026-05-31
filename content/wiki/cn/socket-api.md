---
concept: Socket API
aliases: [socket, Berkeley sockets, Winsock]
tags: [networking, application-layer]
created: 2026-04-30
updated: 2026-04-30
---

# Socket API

## The Problem
Applications need a way to access network services (TCP, UDP) without implementing protocol internals. An interface is needed to allow applications to send/receive data over the network.

## Core Idea
An application programming interface that provides a set of functions for applications to use network services, acting as the Service Access Point between the application and transport layers.

## How It Works
1. Application calls `socket()` to create a socket endpoint
2. Calls `bind()` to assign local address/port (server) or `connect()` to initiate connection (client)
3. Uses `send()`/`recv()` (or `write()`/`read()`) to exchange data
4. Calls `close()` to terminate the connection
5. Server uses `listen()` and `accept()` to handle incoming connections

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    App [label="Application"];
    API [label="Socket API\nsocket(), connect(),\nsend(), recv(), close()"];
    Transport [label="Transport Layer\n(TCP/UDP)"];
    
    App -> API [label="Service Primitives"];
    API -> Transport [label="Layer Interface"];
}
```

## Key Properties
- Standardized interface across operating systems (Berkeley sockets, Winsock)
- Hides protocol details from applications
- Supports both connection-oriented (TCP) and connectionless (UDP) sockets
- File descriptor-based (sockets behave like files)

## Connections
- Built from: [[service-access-point|Service Access Point]] — concrete implementation of SAP
- Built from: [[service-primitives|Service Primitives]] — API calls are primitives
- Related: [[tcp|TCP]] and [[udp|UDP]] — accessed via socket API
- Related: [[application-layer|Application Layer]] — applications use sockets

## Edge Cases & Gotchas
- Blocking vs non-blocking sockets: blocking waits, non-blocking returns immediately
- Socket descriptor leaks if `close()` isn't called (resource exhaustion)
- Different socket types: stream (TCP), datagram (UDP), raw sockets

## Sources
- [[cn-summary|Computer Networks Gemini Conversation]]
