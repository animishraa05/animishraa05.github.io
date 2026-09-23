---
concept: Django Caching
aliases: [django.core.cache, Redis caching]
tags: [dev, django]
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

Django Caching is a system that stores the results of expensive computational operations or database queries in a fast-access storage medium (like RAM via Redis or Memcached) so that subsequent requests can retrieve the data without repeating the heavy processing.

## Explanation

Web servers spend most of their time querying databases or rendering templates. If a page's content doesn't change often (like a blog's homepage), there is no need to query the database and render the HTML for every single visitor. Caching saves the finished HTML in memory, serving it instantly to the next visitor.

## How It Works

1. A request arrives for a resource.
2. Django checks the Cache Backend (e.g., Redis).
3. If data is found (Cache Hit), it is returned immediately.
4. If not found (Cache Miss), Django executes the view, queries the database, and renders the result.
5. Django stores the result in the cache with a time-to-live (TTL).
6. Django returns the response to the client.

## Visual Explanation

```mermaid
graph TD
  A[Request] --> B{In Cache?}
  B -->|Yes| C[Return from RAM]
  B -->|No| D[Query DB & Render]
  D --> E[Save to Cache]
  E --> F[Return to Client]
```

## Mental Model & Analogy

Caching is like memorizing the answer to a complex math problem. The first time someone asks, you have to work it out on paper (Cache Miss). But for the next 10 minutes, if someone asks the same question, you just give them the answer from memory (Cache Hit).

## Implementation & Examples

```python
from django.views.decorators.cache import cache_page
from django.shortcuts import render

# Cache this view for 15 minutes
@cache_page(60 * 15)
def homepage(request):
    return render(request, 'home.html')
```

## Key Properties

- Supports multiple backends (Redis, Memcached, File-based, Database).
- Can cache entire views, specific template fragments, or arbitrary Python objects (Low-level API).
- Requires invalidation strategies to prevent serving stale data.



## Visual Explanation

```dot
digraph Django_Caching {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Django Caching\nInput"]
  B [label="Django Caching\nCore Mechanism"]
  C [label="Django Caching\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_Django_Caching {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Django Caching" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- **Built from:** [[django-web-framework|Django Web Framework]] -- performance optimization layer.
- **Related:** [[django-view|Django View]] -- often applied via view decorators.

## Edge Cases & Gotchas

- Caching dynamic, user-specific data (like a shopping cart) globally will cause users to see other users' data.
- "Cache Invalidation is one of the two hard things in computer science." Knowing when to delete cache is harder than setting it.