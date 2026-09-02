---
title: T5 Text Encoder
concept: t5-encoder
aliases: [T5-XXL, character-aware encoding]
tags: [ai, ml]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

CLIP's semantic encoding can't distinguish between "Lakme" and "LAKME" or track exact spelling. For text rendering in images, we need a text encoder that actually understands character-level details, not just concepts.

## Core Idea

T5 (Text-to-Text Transfer Transformer) is a pure language model trained on massive text corpora — books, websites, code. Unlike CLIP which learned from image-text pairs, T5 learned from raw text and therefore maintains character-level information. "Lakme" and "LAKME" are different sequences that T5 encodes differently.

## How It Works

### Character-Level Processing

T5 tokenizes text at a sub-word level. "Made by Lakme" becomes a sequence of tokens that preserve the exact character information. The encoding captures letter sequences, not just overall meaning.

### Context Length

T5-XXL supports 4096 tokens — far more than CLIP's 77. This enables handling long, complex marketing briefs with many details.

### Dual Encoding in Flux

Flux uses BOTH CLIP and T5 simultaneously:

- CLIP provides semantic understanding (brand, style, mood)
- T5 provides character-level detail (spelling, exact words)
- Both projected to a joint 3072-dim space

## Key Properties

- 4096 token context (vs CLIP's 77)
- Character-aware: case, spelling, exact words matter
- Larger model (T5-XXL ~4B params) = slower than CLIP
- Used in Flux for text encoding

## Connections

- Built from: [[transformers]]
- Used in: [[flux-architecture]]
- Solves: [[text-rendering-problem]]
- Related: [[clip]]

## Edge Cases & Gotchas

- Slower than CLIP encoding
- Doesn't "understand" images — only text
- Need to pair with CLIP for best results