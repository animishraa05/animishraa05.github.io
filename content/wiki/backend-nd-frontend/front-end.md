---
title: Front End
concept: front-end
aliases: [frontend, client-side, presentation layer]
tags: [dev, frontend]
sources_count: 1
last_source: front-end-and-back-end-wikipedia
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Users need to interact with software applications, but the underlying data management and processing logic is too complex to expose directly. How do you present a user-friendly interface while keeping the underlying system intact?

## Core Idea

Front end is the presentation layer of software that users interact with directly. It handles all user-facing tasks, providing an abstraction over the underlying components. In the client-server model, the front end typically resides on the client side.

## How It Works

1. **User Interface**: Renders information and captures user input through UI elements
2. **Input Handling**: Processes user actions (clicks, gestures, keyboard input)
3. **Communication**: Sends requests to the back end via APIs and displays returned data
4. **Rendering**: Transforms data into visual representations (HTML, CSS, images)
5. **Validation**: Performs client-side validation before sending data to the server

In web development, front end includes HTML, CSS, JavaScript, frameworks (React, Angular, Vue.js), and handles responsive design, cross-browser compatibility, and web performance optimization.

## Key Properties

- User-facing and interactive
- Handles presentation and UI logic
- Client-side execution (in browser or device)
- Abstracts underlying complexity from users
- Includes markup (HTML), styling (CSS), and behavior (JavaScript)
- Requires understanding of UI/UX design principles
- Must handle multiple devices and screen sizes

## Connections

**Built from:**

- [[client|Client]] — The front end typically runs on the client in client-server model
- [[server|Server]] — Front end typically connects to servers for back end services
- [[presentation-layer|Presentation Layer]] — Front end implements the presentation layer concept
- [[user-interface|User Interface]] — Front end implements UI components

**Builds into:**

- [[full-stack|Full Stack]] — Front end combined with back end forms full stack
- [[api|API]] — Front end consumes APIs to communicate with back end

**Related:**

- [[back-end|Back End]] — Complements front end as the server-side counterpart
- [[single-page-application|Single-Page Application]] — Modern front end architecture pattern

## Edge Cases & Gotchas

- Front end cannot securely store secrets; sensitive operations must go to back end
- Client-side validation can be bypassed—always validate on back end
- Browser differences require cross-browser testing and workarounds
- Performance optimization critical ( Largest Contentful Paint, Time to Interactive )

## Sources

- [[front-end-and-back-end-wikipedia-summary|Front End and Back End — Wikipedia]]
