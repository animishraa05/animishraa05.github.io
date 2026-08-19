---
concept: Function-Based Views
aliases: [FBV, Function View, django.views]
tags: [dev, django]
sources_count: 1
last_source: Django.md
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

A Function-Based View (FBV) is a Python callable that accepts an `HttpRequest` object as its first parameter and returns an `HttpResponse` object, implementing request-handling logic directly in a function body with explicit control over HTTP methods, status codes, and response content.

## Explanation

FBVs are Django's original and most direct view pattern — a plain Python function that receives a request and returns a response. They provide complete control over the request/response cycle, making them ideal for simple endpoints, custom logic that doesn't fit generic patterns, and developers who prefer explicit over implicit behavior. Each HTTP method (GET, POST, etc.) is handled with explicit `if request.method == 'POST':` checks.

## How It Works

1. **URL pattern matches** — URL dispatcher resolves path to view function
2. **Request object created** — Django builds `HttpRequest` with `GET`, `POST`, `FILES`, `COOKIES`, `session`, `user`
3. **View function called** — `view_func(request, *args, **kwargs)` executed
4. **Business logic runs** — Query models, process forms, call services, etc.
5. **Response returned** — `HttpResponse`, `JsonResponse`, `render()`, `redirect()`, or `HttpResponseNotFound`
6. **Middleware processes response** — Response middleware modifies headers, compresses, etc.

## Visual Explanation

```dot
digraph function_based_view {
  rankdir=TB;
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=10];

  Request [label="HttpRequest\nGET /hello/" fillcolor="#ffe5cc"];
  ViewFunc [label="def hello(request):\n    return HttpResponse('Hello!')"];
  Logic [label="Business Logic\n(optional Model access)"];
  Response [label="HttpResponse\n'Hello!'" fillcolor="#d4edda"];

  Request -> ViewFunc [label="1. Called with request"];
  ViewFunc -> Logic [label="2. Execute logic"];
  Logic -> ViewFunc [label="3. Return data"];
  ViewFunc -> Response [label="4. Return response"];
}
```

## Semantic Network

```dot
graph semantic_function_based_views {
  layout=neato;
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled];
  edge [fontname="Helvetica" fontsize=9];

  THIS [label="Function-Based\nViews (FBV)" fillcolor="#ffd700" fontsize=13 style="filled,bold"];

  PRE1 [label="URL\nDispatcher" fillcolor="#cce5ff"];
  PRE2 [label="HttpRequest\nObject" fillcolor="#cce5ff"];
  PRE3 [label="HttpResponse\nClasses" fillcolor="#cce5ff"];

  OUT1 [label="Django Forms\nProcessing" fillcolor="#d4edda"];
  OUT2 [label="Model CRUD\nOperations" fillcolor="#d4edda"];
  OUT3 [label="Template\nRendering" fillcolor="#d4edda"];
  OUT4 [label="JSON API\nEndpoints" fillcolor="#d4edda"];

  CON1 [label="Class-Based\nViews (CBV)" fillcolor="#ffe5cc"];

  REL1 [label="Decorators\n(@login_required)" fillcolor="#f0f0f0"];
  REL2 [label="Middleware\n(Request/Response)" fillcolor="#f0f0f0"];

  THIS -- PRE1 [label="built from" style=dashed];
  THIS -- PRE2 [label="built from" style=dashed];
  THIS -- PRE3 [label="built from" style=dashed];
  THIS -- OUT1 [label="builds into"];
  THIS -- OUT2 [label="builds into"];
  THIS -- OUT3 [label="builds into"];
  THIS -- OUT4 [label="builds into"];
  THIS -- CON1 [label="contrasts with" style=dotted];
  THIS -- REL1 [label="related"];
  THIS -- REL2 [label="related"];
}
```

## Key Properties

- **Explicit control**: Every line of logic visible; no hidden inheritance chains
- **Method handling**: Manual `if request.method == 'POST':` branching
- **Decorator composition**: `@require_http_methods`, `@login_required`, `@csrf_exempt` stack cleanly
- **Testability**: Easy to unit test — call function with mock request, assert response
- **Flexibility**: Can return any `HttpResponse` subclass; stream, file, JSON, redirect

## Connections

- Built from: [[url-dispatcher|URL Dispatcher]] — Receives matched requests
- Built from: [[http-request|HttpRequest Object]] — Input parameter
- Built from: [[http-response|HttpResponse Classes]] — Return types
- Builds into: [[forms-modelforms|Forms/ModelForms Processing]] — Handle form submission
- Builds into: [[models-orm|Model CRUD Operations]] — Create/read/update/delete
- Builds into: [[template-engine|Template Rendering]] — `render(request, template, context)`
- Contrasts with: [[class-based-views|Class-Based Views]] — Implicit behavior via inheritance
- Related: [[view-decorators|View Decorators]] — Cross-cutting concerns (auth, CSRF, methods)
- Related: [[middleware|Middleware]] — Global request/response processing

## Edge Cases & Gotchas

- **CSRF protection**: POST forms need `{% csrf_token %}` or `@csrf_exempt` (dangerous)
- **Method safety**: Forgetting to check `request.method` leads to GET-side effects
- **Code duplication**: Similar CRUD views repeat boilerplate; CBVs/DRF reduce this
- **Large functions**: Complex views become hard to maintain; split into services/helpers

## Sources

- [[django-summary|Django Learning Roadmap]]