---
title: Flux Architecture
concept: flux-architecture
aliases: [FLUX.1-dev, flow matching, DiT]
tags: [ai, diffusion]
sources_count: 1
last_source: imgen.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Standard diffusion models (SDXL, Stable Diffusion) have architecture limitations that make text rendering and long-prompt handling difficult. SDXL uses a UNet-based architecture with CLIP-only encoding and 4-channel VAE — all contributing to the text rendering problem.

## Core Idea

Flux.1-dev is a modern diffusion model using DiT (Diffusion Transformer) architecture instead of UNet, dual text encoders (CLIP + T5), and a 16-channel VAE. These architectural choices directly address the three-layer text rendering problem.

## How It Works

### DiT Architecture (vs UNet)

Traditional UNet models process image and text information separately, with cross-attention only at specific layers. DiT processes both in a unified attention mechanism — text tokens and image tokens interact at every single layer throughout generation.

### Dual Text Encoders

Flux uses BOTH CLIP-L and T5-XXL:

- **CLIP-L**: Semantic understanding — "Lakme = luxury cosmetics brand"
- **T5-XXL**: Character-level encoding — "L-a-k-m-e = exact character sequence"

Both are projected into a joint 3072-dimensional space, giving the model both conceptual and character-level information.

### 16-Channel VAE

Previous models used 4-channel VAE. Flux's 16-channel VAE has 4x the information capacity in latent space, allowing fine strokes (letter details) to survive compression and decompression.

### Flow Matching

Flux uses flow matching training instead of traditional DDPM. This produces sharper results with fewer sampling steps.

## Key Properties

- 12B parameters
- Apache 2.0 license (schnell) / Proprietary (dev)
- T5-XXL context: 4096 tokens (vs CLIP's 77)
- Native 1024x1024 output
- ~24GB VRAM for full quality inference

## Connections

- Built from: [[diffusion-models]], [[transformers]], [[t5-encoder]], [[clip]], [[vae]]
- Part of: [[hybrid-pipeline]], [[text-rendering-problem]]
- Related: [[lora-finetuning]]

## Edge Cases & Gotchas

- VRAM intensive — needs A100 or equivalent for comfortable inference
- T5-XXL loading adds latency (~3 seconds)
- Quality degrades significantly below 16GB VRAM without optimization

## Sources

- [[imgen-summary]]
