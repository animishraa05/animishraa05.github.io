---
concept: HTTP API
aliases: [HTTP API, web API]
tags: [dev, api]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Front end and back end need a contract to talk -- what format do requests and responses follow when a browser calls a server?

## Formal Definition

Per Wikipedia: "An HTTP API is an interface that exposes application functionality over HTTP using verbs, paths, headers and status codes."

## Explanation

Think of an API as a menu in a restaurant. The front end orders by calling a URL, the back end cooks and returns JSON. HTTP just defines how the waiter carries the order.

## How It Works

1. Client forms HTTP request with method and URL
2. Server routes request to handler
3. Handler runs business logic and queries data
4. Server formats JSON response with status code
5. Client parses response and updates UI

## Visual Explanation

```dot
digraph http_api {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Client Request"]
  B [label="Server Handler"]
  C [label="JSON Response"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_http_api {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="HTTP API" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Stateless -- each request carries its own auth and context
- Uses standard verbs GET POST PUT DELETE
- Versioned via URL or header
- Errors signaled via status codes

## Real-World Example

```python
# Minimal HTTP API call
import requests
resp = requests.get('https://api.example.com/users/1')
print(resp.status_code, resp.json())
```

## Connections

- **Built from:** [[client-server-model|Client-Server Model]] -- API is the contract inside that model
- **Built from:** [[api|API]] -- specialization of generic API for HTTP
- **Related:** [[server|Server]] -- server implements the API
- **Contrasts with:** [[front-end|Front End]] -- front end consumes the API

## Edge Cases & Gotchas

- Forgetting pagination on list endpoints paginates in client not server
- Mixing HTTP verbs -- GET should not change state
