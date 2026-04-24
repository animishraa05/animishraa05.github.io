---
concept: Backend Framework
aliases: [web framework, application framework, backend library]
tags: [dev, framework]
sources_count: 1
last_source: Backend Engineering Basics.md
created: 2026-04-12
updated: 2026-04-12
---

# Backend Framework

## The Problem

Writing a web server from scratch (socket binding, HTTP parsing, routing, error handling) is time-consuming and error-prone. Every project would reinvent the same basics. Frameworks automate this.

## Core Idea

A backend framework is a library that provides the boilerplate for building web servers: HTTP server, routing, database connectors, middleware, and helpers. They automate the basics so developers focus on business logic. The key insight: frameworks are just abstractions over the fundamentals—if you know the fundamentals, any framework is learnable.

## How It Works

1. **HTTP Server**: Built-in server (or integrates with one)
2. **Routing**: Map URL paths to functions (e.g., `/users` → `getUsers()`)
3. **Middleware**: Chain of functions that process requests (auth, logging, CORS)
4. **Database Integration**: Connect to SQL/NoSQL databases with helper libraries
5. **Request/Response Objects**: Parsed objects with headers, body, params
6. **Helpers**: JSON parsing, validation, templating, sessions

When you write `app.get("/users", handler)`, the framework handles the socket, parses HTTP, calls your handler, formats the response.

## Key Properties

- Language-specific: Python (Django, FastAPI), JavaScript (Express, NestJS), Java (Spring Boot), Go (Gin), Rust (Actix)
- Opinionated (Django) vs unopinionated (Express)
- Includes batteries (Django) vs minimal (Express)
- Synchronous or asynchronous execution models
- Frameworks don't handle TLS in production—that's the reverse proxy's job

## Connections

- **Built from:** [[http-protocol|HTTP Protocol]] — frameworks parse and handle HTTP
- **Built from:** [[socket|Socket]] — frameworks abstract socket handling
- **Builds into:** [[backend-architecture|Backend Architecture]] — frameworks implement the API server layer
- **Related:** [[backend-skills|Backend Skills]] — skills needed beyond just knowing frameworks

## Edge Cases & Gotchas

- Don't confuse framework with runtime—Spring Boot runs on JVM, Express on Node.js
- Frameworks add abstraction cost—understand what's happening underneath
- Production deployments need reverse proxies (Nginx) for TLS, load balancing
- Framework choice affects performance but fundamentals transfer between them

## Sources

- [[backend-engineering-basics-summary|Backend Engineering Basics]]