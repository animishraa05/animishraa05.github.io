---
title: API
concept: api
aliases: [application programming interface, web api]
tags: [networking, api]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How does the front end communicate with the back end? How do different software components exchange data and functionality?

## Core Idea

API (Application Programming Interface) is the interface through which software components communicate. In web development, APIs allow front end to request data and services from back end, typically over HTTP.

## How It Works

1. **Request**: Front end sends HTTP request (GET, POST, PUT, DELETE) to API endpoint
2. **Processing**: Server processes request, applies business logic, accesses database
3. **Response**: Server returns data (JSON, XML) or status code
4. **Consumption**: Front end receives response and updates UI
5. **REST/GraphQL**: Common architectural styles for web APIs

APIs can also reduce front-end processing load using different back-end services for different front-end interfaces, known as the BFF (Backend for Frontend) pattern.

## Key Properties

- Defines how components interact
- Standardized request/response format
- HTTP-based for web (REST, GraphQL)
- Can be internal or external (public APIs)
- Authentication/authorization for security
- Versioning for backward compatibility

## Connections

**Builds into:**

- [[front-end|Front End]] — Consumes APIs to get data from back end
- [[back-end|Back End]] — Implements and exposes APIs

**Related:**

- [[http|HTTP]] — Protocol underlying most web APIs
- [[http-methods|HTTP Methods]] — Define API operations
- [[bff-pattern|BFF Pattern]] — API architecture pattern for front end optimization

## Edge Cases & Gotchas

- API versioning is critical when changing interfaces
- Rate limiting prevents abuse
- Error handling must be consistent
- Documentation essential for API consumers