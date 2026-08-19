---
concept: Template Engine
aliases: [Django Templates, DTL, Django Template Language]
tags: [dev, django]
sources_count: 1
last_source: Django.md
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

The Django Template Engine is a text-based templating system that separates presentation logic from business logic using a syntax of variables (`{{ variable }}`), tags (`{% tag %}`), and filters (`{{ value|filter }}`), with support for template inheritance, inclusion, and automatic HTML escaping for security.

## Explanation

The template engine solves the problem of generating dynamic HTML (or any text format) without embedding business logic in presentation code. Templates contain only display logic — loops, conditionals, variable interpolation — while views prepare context data. The engine compiles templates to an intermediate representation, then renders them with a context dictionary, auto-escaping variables to prevent XSS unless explicitly marked safe.

## How It Works

1. **Template loaded** — `get_template('name.html')` or `render()` loads template from `TEMPLATES` dirs
2. **Template parsed** — Lexer tokenizes into `TextNode`, `VariableNode`, `BlockNode`, `IfNode`, `ForNode`
3. **Context created** — View builds context dict; context processors add global variables (`request`, `user`, `messages`)
4. **Template rendered** — `template.render(context)` walks node tree, resolves variables, executes tags
5. **Auto-escaping applied** — All `{{ variable }}` output passed through `escape()` unless `|safe` or `mark_safe()`
6. **Result returned** — Rendered string wrapped in `HttpResponse`

## Visual Explanation

```dot
digraph template_engine {
  rankdir=TB;
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=10];

  TemplateFile [label="template.html\n{% extends 'base.html' %}\n{% block content %}\n  {{ user.name }}\n{% endblock %}" fillcolor="#ffe5cc"];
  Lexer [label="Lexer/Parser\n→ Node Tree"];
  Context [label="Context Dict\n{user: User, request: ...}"];
  ContextProcessors [label="Context Processors\n+ request, user, messages"];
  Renderer [label="Renderer\nWalk nodes, resolve vars"];
  AutoEscape [label="Auto-Escape\n{{ var }} → escape(var)"];
  Output [label="Rendered HTML\n<!DOCTYPE html>..." fillcolor="#d4edda"];

  TemplateFile -> Lexer [label="1. Parse"];
  Lexer -> Renderer [label="2. Node tree"];
  Context -> ContextProcessors [label="3. Merge"];
  ContextProcessors -> Renderer [label="4. Full context"];
  Renderer -> AutoEscape [label="5. Variable nodes"];
  AutoEscape -> Output [label="6. Safe string"];
}
```

## Semantic Network

```dot
graph semantic_template_engine {
  layout=neato;
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled];
  edge [fontname="Helvetica" fontsize=9];

  THIS [label="Template\nEngine" fillcolor="#ffd700" fontsize=13 style="filled,bold"];

  PRE1 [label="View\n(Context Data)" fillcolor="#cce5ff"];
  PRE2 [label="Template\nFiles (.html)" fillcolor="#cce5ff"];
  PRE3 [label="Context\nProcessors" fillcolor="#cce5ff"];

  OUT1 [label="Template\nInheritance" fillcolor="#d4edda"];
  OUT2 [label="Template\nTags/filters" fillcolor="#d4edda"];
  OUT3 [label="Static Files\nIntegration" fillcolor="#d4edda"];
  OUT4 [label="Form\nRendering" fillcolor="#d4edda"];

  CON1 [label="Jinja2\n(Standalone)" fillcolor="#ffe5cc"];
  CON2 [label="React/Vue\n(Client-side)" fillcolor="#ffe5cc"];

  REL1 [label="CSRF\nToken Tag" fillcolor="#f0f0f0"];
  REL2 [label="I18n\nTranslation Tags" fillcolor="#f0f0f0"];

  THIS -- PRE1 [label="built from" style=dashed];
  THIS -- PRE2 [label="built from" style=dashed];
  THIS -- PRE3 [label="built from" style=dashed];
  THIS -- OUT1 [label="builds into"];
  THIS -- OUT2 [label="builds into"];
  THIS -- OUT3 [label="builds into"];
  THIS -- OUT4 [label="builds into"];
  THIS -- CON1 [label="contrasts with" style=dotted];
  THIS -- CON2 [label="contrasts with" style=dotted];
  THIS -- REL1 [label="related"];
  THIS -- REL2 [label="related"];
}
```

## Key Properties

- **Auto-escaping by default**: `{{ user_input }}` safe from XSS; opt-out with `|safe` or `mark_safe()`
- **Template inheritance**: `{% extends 'base.html' %}` + `{% block content %}` enables layout reuse
- **Custom tags/filters**: `@register.simple_tag`, `@register.filter` extend template language
- **Loader flexibility**: `TEMPLATES['loaders']` supports filesystem, app directories, cached loader
- **Debug integration**: `TEMPLATE_DEBUG` shows template source lines in error pages

## Connections

- Built from: [[function-based-views|Function-Based Views]] — Primary consumer via `render()`
- Built from: [[class-based-views|Class-Based Views]] — `TemplateView`, `DetailView` use templates
- Built from: [[context-processors|Context Processors]] — Inject global template variables
- Builds into: [[template-inheritance|Template Inheritance]] — Layout composition pattern
- Builds into: [[static-files|Static Files Integration]] — `{% static 'css/style.css' %}`
- Builds into: [[form-rendering|Form Rendering]] — `{{ form.as_p }}`, `{{ field }}`
- Contrasts with: [[jinja2|Jinja2]] — Faster, more Pythonic, standalone, similar syntax
- Contrasts with: [[client-side-templates|Client-Side Templates]] — SPA frameworks (React/Vue) render in browser
- Related: [[csrf-protection|CSRF Protection]] — `{% csrf_token %}` tag
- Related: [[i18n|Internationalization]] — `{% trans %}`, `{% blocktrans %}` tags

## Edge Cases & Gotchas

- **Variable lookup order**: Dict key → attribute → list index → callable (no args) → empty string
- **Silent failures**: Missing variables render as empty string (configurable via `string_if_invalid`)
- **`|safe` danger**: Marking user-controlled data as safe enables XSS; only use on trusted content
- **Performance**: Uncached template loading hits filesystem on every request; use `cached.Loader` in production

## Sources

- [[django-summary|Django Learning Roadmap]]