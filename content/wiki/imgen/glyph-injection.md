---
title: Glyph Injection via ControlNet
concept: glyph-injection
aliases: [glyph control, text shape enforcement]
tags: [ai, diffusion]
sources_count: 1
last_source: imgen.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Even with T5 encoding and 16-channel VAE, pure diffusion models still struggle with exact text rendering. Semantic drift can override even character-level encoding when the model decides the "concept" of text matters more than its shape. For marketing use, where brand names must be pixel-perfect, this is unacceptable.

## Core Idea

Don't ask the model to generate letters — give it the exact letter shapes as a spatial constraint. Render the text as a clean image using standard font libraries, then use ControlNet to force the diffusion model to follow those exact strokes.

## How It Works

```
1. Extract text_to_render from LLM schema
2. Use PIL/Pillow to render text as black-on-white image at 1024x1024
3. Pass this glyph image to ControlNet as conditioning
4. During denoising, ControlNet enforces stroke geometry at every step
5. Flux applies style/color on top of exact stroke positions
```

### Why This Works

ControlNet operates at the pixel/spatial level — it doesn't "understand" letters, it just sees dark pixels and enforces dark pixels at the same locations. The model isn't generating "M", it's being told "there must be dark strokes at these specific coordinates."

### ControlNet Scale

The `controlnet_scale` parameter (0.0-1.0) controls how strongly ControlNet overrides Flux:

- 0.85: Exact brand names, logos
- 0.75: Taglines, product names (sweet spot)
- 0.60: Creative/artistic text

## Key Properties

- Zero training required — uses pre-trained ControlNet weights
- Works with any font (select based on brand guidelines)
- Multi-line text supported in single glyph image
- Font weight affects reliability (bold = more reliable)

## Connections

- Solves: [[text-rendering-problem]]
- Built from: [[controlnet]], [[vae]]
- Used in: [[hybrid-pipeline]]
- Related: [[flux-architecture]]

## Edge Cases & Gotchas

- Thin decorative fonts cause weak ControlNet signal → drift
- Position must be specified (center, top-left, etc.)
- Scale too high = text looks "pasted on", not integrated
- Scale too low = spell errors return

## Sources

- [[imgen-summary]]
