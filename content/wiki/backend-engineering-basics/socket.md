---
concept: Socket
aliases: [network socket, TCP socket, socket connection]
tags: [networking, socket]
created: 2026-04-12
updated: 2026-04-30
---

## The Problem

How do two programs on different machines actually communicate? Without sockets, there's no way to establish a connection, send data, and receive responses—the foundation of all network communication is missing.

## Core Idea

A socket is a communication endpoint between two machines, uniquely identified by the 4-tuple: (client IP, client port, server IP, server port). It's the OS-managed channel that allows programs to send and receive data over a network.

## How It Works

1. **Server Side**: Server creates a socket, binds to an IP:port, and listens for connections
2. **Client Side**: Client creates a socket and connects to server's IP:port
3. **Connection**: TCP handshake establishes the connection (for TCP sockets)
4. **Communication**: Both sides can send() and receive() data through the socket
5. **Termination**: Connection closes when either side calls close()

The socket is essentially a file-like interface managed by the OS kernel. You read from it and write to it just like a file.

## Key Properties

- Unique 4-tuple identifies each connection: (client IP, client port, server IP, server port)
- Two main types: TCP (reliable, ordered) and UDP (fast, unreliable)
- Sockets have send and receive buffers to handle network timing differences
- Server has one listening socket per port, plus one connection socket per client
- Everything network-related runs on top of sockets—HTTP, TLS, WebSockets, databases

## Connections
- **Built from:** [[ip-address|IP Address]] — IP identifies the machine
- **Built from:** [[port|Port]] — port identifies the program
- **Built from:** [[mac-address|MAC Address]] — final delivery uses MAC on local network
- **Builds into:** [[tcp-handshake|TCP Handshake]] — TCP handshake creates socket connections
- **Builds into:** [[http|HTTP]] — HTTP runs over socket connections
- **Builds into:** [[tls-handshake|TLS Handshake]] — TLS runs over sockets
- **Related:** [[backend-as-program|Backend as Program]] — backend programs use sockets to receive requests

## Edge Cases & Gotchas

- Each client gets a NEW connection socket—server doesn't reuse the listening socket for data
- Socket buffers can overflow if data isn't consumed fast enough (backpressure)
- Network partitions can leave sockets in unclear states—timeouts matter
- Non-blocking sockets are used in high-performance servers (Node.js event loop)