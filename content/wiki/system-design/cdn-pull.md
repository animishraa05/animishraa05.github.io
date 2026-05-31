---
concept: Pull CDN
aliases: [pull-based content delivery, lazy-load CDN, origin-pull CDN]
tags: [systems, infrastructure]
created: 2026-05-15
updated: 2026-05-15
---

## The Problem

Pre-pushing all content to a CDN is wasteful if much of the content is rarely accessed, filling CDN storage with cold data.

## Core Idea

Pull CDNs grab content from the origin server on the first user request, cache it at the edge with a TTL, and serve subsequent requests from cache.

## How It Works

1. A user requests content that is not yet cached at the nearest CDN edge.
2. The CDN edge pulls the content from the origin server.
3. The edge caches the content and serves it to the user.
4. Subsequent requests for the same content are served directly from the edge cache.
5. The cached content expires based on its TTL or is evicted by a cache replacement policy.
6. Best suited for high-traffic sites with long-tail content access patterns.

## Visual Explanation

```dot
digraph pull_cdn {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  USER1 [label="First User Request"]
  USER2 [label="Subsequent Users"]
  EDGE [label="CDN Edge Node" fillcolor="#d4edda"]
  ORIGIN [label="Origin Server" fillcolor="#ffe5cc"]

  USER1 -> EDGE [label="cache miss"]
  EDGE -> ORIGIN [label="pull from origin"]
  ORIGIN -> EDGE [label="serve content"]
  EDGE -> USER1 [label="serve & cache"]
  USER2 -> EDGE [label="cache hit"]
  EDGE -> USER2 [label="serve from cache"]
}
```

## Key Properties

- First-request-triggered caching — content is pulled on demand
- TTL-based expiration controls how long content stays cached
- Minimizes CDN storage costs — only accessed content is stored
- Slower first request (cache miss penalty) vs fast subsequent requests
- Best suited for high-traffic sites with diverse content

## Connections

- **Contrasts with:** [[cdn-push|Push CDN]] — lazy-pull vs proactive-push content delivery
- **Related:** [[dns-system-design|DNS in System Design]] — DNS routing directs users to the CDN edge
- **Related:** [[cache-aside|Cache-Aside]] — pull CDN follows the same lazy-loading pattern as cache-aside
- **Related:** [[reverse-proxy-pattern|Reverse Proxy]] — pull CDN is a geographically distributed reverse proxy

## Edge Cases & Gotchas

- Thundering herd problem: if popular content expires simultaneously, a flood of origin requests hits the server
- Pull CDNs contribute to origin traffic on first access — large content (videos) causes significant origin load on first requests
- TTL tuning is critical — too short defeats caching, too long serves stale content

## Sources

- [[readmemd-summary|System Design Primer Summary]] — CDN section in the Scalability chapter
