---
concept: Browser Autocomplete
aliases: [address bar autocomplete, URL suggestions, predictive text]
tags: [dev, browser]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

When users type in the address bar, they want suggestions to speed up navigation. Without autocomplete, users would have to type full URLs manually every time.

## Core Idea

Browser autocomplete suggests URLs as you type, using history, bookmarks, cookies, and popular queries. It runs locally (no network needed at this stage) and updates in real-time.

## How It Works

1. **Input detected**: User types character in address bar
2. **Local search**: Check against:
   - Browsing history
   - Bookmarks
   - Cookies (visited sites)
   - Popular/common URLs
3. **Display**: Show dropdown with matching suggestions
4. **No network**: This happens before any DNS/HTTP

Modern browsers also use AI/ML for smarter suggestions.

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Input [label="User types 'goo'"];
    Sources [label="Local Sources\nHistory, Bookmarks, Cookies"];
    Suggestions [label="Suggestions\ngoogle.com\ngoogle.co.in"];
    
    Input -> Sources -> Suggestions;
}
```

## Key Properties

- Runs locally—no network requests yet
- Uses history, bookmarks, cookies, popular queries
- Updates in real-time as user types
- Can be disabled in browser settings

## Connections

- **Built from:** [[url-parsing|URL Parsing]] — autocomplete works on URL input
- **Related:** [[browser-rendering|Browser Rendering]] — happens before rendering
- **Related:** [[history|Browser History]] — source for suggestions
- **Contrasts with:** [[dns-lookup|DNS Lookup]] — autocomplete is local, DNS is network

## Edge Cases & Gotchas

- Private/incognito mode limits autocomplete data
- Corrupt history database can break autocomplete
- Some browsers share data across devices (synced)
- Autocomplete can leak visited sites (privacy concern)