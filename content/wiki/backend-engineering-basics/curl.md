---
concept: curl
aliases: [curl client, command line HTTP client, HTTP tool]
tags: [dev, tools]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do you test backend APIs directly without building a front end? How do you inspect what's actually sent over the wire? curl provides a CLI interface to speak HTTP directly—essential for backend development and debugging.

## Core Idea

curl is a command-line tool that sends HTTP requests and prints the response. It bypasses browsers—you can directly test endpoints, inspect headers, send POST data. It's the backend developer's direct connection to the server.

## How It Works

1. **Parse URL**: curl extracts protocol, domain, port, path from the URL
2. **DNS Lookup**: Resolves domain to IP address
3. **Socket Connection**: Opens TCP socket to IP:port
4. **TLS Handshake**: For HTTPS, establishes encrypted connection
5. **Send Request**: Writes raw HTTP request text to socket
6. **Receive Response**: Reads response from server and prints to terminal

Example: `curl https://example.com` sends `GET / HTTP/1.1` and prints the HTML response.

## Key Properties

- CLI tool available on all major operating systems
- Supports multiple protocols: HTTP, HTTPS, FTP, etc.
- Options: -X (method), -H (headers), -d (body), -v (verbose)
- Great for API testing: `curl -X POST -H "Content-Type: application/json" -d '{"name":"ani"}' https://api.example.com`
- -v flag shows full request/response headers and connection details
- Does not execute JavaScript like browsers do

## Connections

- **Built from:** [[socket|Socket]] — curl creates socket connections
- **Built from:** [[http-protocol|HTTP Protocol]] — curl sends HTTP requests
- **Built from:** [[tls-handshake|TLS Handshake]] — curl handles HTTPS automatically
- **Related:** [[dns|DNS]] — curl uses DNS to resolve domains
- **Related:** [[backend-as-program|Backend as Program]] — curl talks to backend servers

## Edge Cases & Gotchas

- Doesn't render HTML or execute JavaScript—just shows raw response
- Default timeout may be too long for failing servers
- Use -L to follow redirects
- For complex APIs, tools like Postman may be more convenient than curl