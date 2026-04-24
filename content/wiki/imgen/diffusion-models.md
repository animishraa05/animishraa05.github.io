---
title: Diffusion Models
concept: diffusion-models
aliases: [ddpm, ddims, generative models]
tags: [ai, ml]
sources_count: 1
last_source: imgen.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do you teach a neural network to generate entirely new images from scratch? Simple classification won't work — you need the model to learn the structure of images well enough to create novel ones.

## Core Idea

Diffusion models work by learning to reverse a gradual noising process. Start with an image, add noise step by step until it's pure random noise, then train the model to reverse this — going from noise back to a clean image. Once trained, you start with pure noise and run the reverse process to generate new images.

## How It Works

### Forward Process (noising)

```
Image → Add small noise → Add small noise → ... → Pure noise
```

This is fixed — no model needed. At each step a small amount of Gaussian noise is added.

### Reverse Process (denoising)

```
Pure noise ← Remove noise ← Remove noise ← ... ← Original image
```

This is learned. The model predicts how much noise to remove at each step.

### Sampling

In practice, you start with random noise and run 25-50 denoising steps. At each step, the model looks at the current noisy image and your text prompt, then predicts what the less-noisy version should look like.

### DDPM vs DDIM

- DDPM: Original approach, high quality but slow (many steps)
- DDIM: Faster sampling, fewer steps with comparable quality

## Key Properties

- State-of-the-art for photorealistic image generation
- Text-conditioned via cross-attention or joint attention
- Latent diffusion (LDM) runs in compressed space for efficiency
- Most open-source models (SDXL, Flux) use this approach

## Connections

- Built from: [[vae]], [[neural-networks]]
- Built into: [[flux-architecture]], [[lora-finetuning]]
- Related: [[text-rendering-problem]]

## Edge Cases & Gotchas

- Slow inference (25-50 steps per image)
- High-frequency details (like text) are hardest to generate
- Mode collapse possible if training data insufficient

## Sources

- [[imgen-summary]]
