---
title: imgen.md Source Summary
source: imgen.md
source_path: sources/imgen.md
content_hash:
ingested: 2026-04-12
concepts_count: 10
---

## Source Overview

This source is a conversation transcript covering the design of a production-grade marketing image generation pipeline. It covers architecture decisions, the text rendering problem in depth, solution approaches, and implementation guidance.

## Concepts Extracted

1. **Hybrid LLM-Guided Diffusion Pipeline** — Combining LLM for reasoning with diffusion for synthesis
2. **Text Rendering Problem** — Three-layer issue: character-blind encoder, semantic drift, VAE stroke destruction
3. **Flux Architecture** — DiT, dual encoders (CLIP + T5), 16-channel VAE, flow matching
4. **Glyph Injection via ControlNet** — Using font rendering + spatial conditioning to solve text rendering
5. **Diffusion Models** — Core generation mechanism (DDPM, DDIM, latent diffusion)
6. **VAE** — Compression/decompression in latent space
7. **CLIP** — Semantic text encoder with character-blindness
8. **T5 Encoder** — Character-aware alternative to CLIP
9. **LoRA Fine-tuning** — Low-rank adaptation for brand consistency
10. **ControlNet** — Spatial conditioning for generation control

## Key Takeaways

- The text rendering problem has THREE distinct root causes at three different layers
- Flux's architectural improvements (T5 + 16-channel VAE + DiT) address 2 of 3 natively
- ControlNet glyph injection provides the final layer of guarantee for exact text
- The hybrid pipeline approach is the best available open-source architecture for this use case
- Training burden is lighter than it appears: only 3 things need training (LLM, base LoRA, client LoRAs)

## Open Questions

- How to calibrate quality gate thresholds for marketing-specific quality?
- What's the best approach for multi-language (Hindi + English) text rendering?
- How to manage LoRA registry at scale with 50+ clients?

## Wiki Pages Created

- [[hybrid-pipeline]]
- [[text-rendering-problem]]
- [[flux-architecture]]
- [[glyph-injection]]
- [[diffusion-models]]
- [[vae]]
- [[clip]]
- [[t5-encoder]]
- [[lora-finetuning]]
- [[controlnet]]
