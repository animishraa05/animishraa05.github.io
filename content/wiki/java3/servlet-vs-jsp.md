---
title: Servlet vs JSP — Web Presentation Technologies Compared
type: synthesis
tags: [dev, web]
created: 2026-05-13
updated: 2026-05-13
---

## What's Being Compared

Servlets and JSP are both Java web technologies for generating dynamic content, but they differ fundamentally in their orientation: Servlets are Java-centric (HTML embedded in Java code), while JSP is content-centric (Java embedded in HTML). The choice affects development team composition, maintenance, and separation of concerns.

## The Core Tension

The tradeoff is between **control** (Servlets give full programmatic access to HTTP request/response) vs **separation** (JSP enables non-Java designers to maintain the view layer). Both compile to the same underlying servlet, but the development experience and team skill requirements differ.

## Comparison

| Dimension | [[servlets|Servlets]] | [[jsp|JSP]] |
|-----------|-------|-----|
| Nature | Java class with embedded HTML | HTML page with embedded Java |
| Best for | Request processing, business logic, API endpoints | Presentation, dynamic UI, form display |
| Java expertise | Required | Minimal (EL/JSTL) |
| Designer-friendly | No | Yes |
| Compilation | Direct .class | JSP→Servlet→.class |
| Performance | No translation overhead | First-access translation delay |
| Session management | HttpSession API | `session` implicit object |
| Error handling | try-catch in Java code | Error pages via `page` directive |
| Modern use | REST controllers (Spring MVC/Boot) | Template engines (Thymeleaf, React) |

## When to Use Servlets

- Building REST APIs or web services (return JSON/XML, not HTML)
- Request processing and routing logic
- When the team is Java-heavy and output format is non-HTML
- When you need full control over HTTP response headers and status codes

## When to Use JSP

- Generating dynamic HTML pages with complex layouts
- Teams with UI designers who don't write Java
- Prototyping view-heavy applications quickly
- Legacy enterprise applications with JSP-based views

## The Insight

Servlets and JSP solve the same problem from opposite directions. In modern Spring applications, the distinction is largely moot: `@RestController` replaces servlets for APIs, and template engines (Thymeleaf, FreeMarker) replace JSP for views. The underlying lesson — separation of presentation from logic — is what matters, not the specific technology.

## Connections

- [[servlets|Servlets]] — Java-centric web component, compiled directly
- [[jsp|JSP]] — HTML-centric web page, compiles to servlet
- [[dispatcher-servlet|DispatcherServlet]] — Spring's front controller unifying request handling
- [[spring-controller|Spring Controller]] — Modern equivalent of Servlet for request handling
- [[spring-mvc|Spring MVC]] — Modern web framework that subsumes both Servlet and JSP patterns
