---
concept: Django Project
aliases: [Django Project Structure]
tags: [dev, django]
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

A Django Project is the entire application setup, encompassing a collection of settings, configurations, and apps that make up a single web site or web application.

## Explanation

The project is the outer shell of your application. It holds the global configurations, such as database connections, installed apps, middleware, and the root URL routing. A project does not usually contain business logic itself; instead, it delegates that to apps.

## How It Works

1. Created using `django-admin startproject <name>`.
2. Generates a directory containing `manage.py`.
3. Generates an inner configuration directory containing `settings.py`, `urls.py`, `wsgi.py`, and `asgi.py`.
4. Executes global commands via `manage.py`.

## Visual Explanation

```mermaid
graph TD
  A[Django Project] --> B(settings.py)
  A --> C(manage.py)
  A --> D(urls.py)
  A --> E[App 1]
  A --> F[App 2]
```

## Mental Model & Analogy

A Django Project is like a company. The company has a headquarters (settings, global rules) and a directory (root URLs). The company itself doesn't do the specialized work; it hires different departments (Django Apps) to handle billing, user management, and core services.

## Implementation & Examples

```bash
django-admin startproject config .
```

## Key Properties

- Contains `settings.py` for global configuration.
- Contains `manage.py` for project-level commands.
- Orchestrates multiple apps.



## Visual Explanation

```dot
digraph Django_Project {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Django Project\nInput"]
  B [label="Django Project\nCore Mechanism"]
  C [label="Django Project\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_Django_Project {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Django Project" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- **Built from:** [[django-web-framework|Django Web Framework]] -- instantiated framework.
- **Builds into:** [[django-app|Django App]] -- projects contain apps.
- **Contrasts with:** [[django-app|Django App]] -- project is the container, app is the feature.
- **Related:** [[django-project-vs-app|Django Project vs App]] -- detailed synthesis.

## Edge Cases & Gotchas

- Hardcoding logic inside the project's root URLs or settings is considered bad practice; logic belongs in apps.