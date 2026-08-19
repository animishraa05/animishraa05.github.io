---
title: Variational Autoencoder (VAE)
concept: vae
aliases: [latent space, encoder-decoder]
tags: [ai, ml]
sources_count: 1
last_source: imgen.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Generating images at full pixel resolution (1024x1024 = 1M pixels) directly would be computationally infeasible — the model would need to reason about millions of values per image. Diffusion models need a more efficient representation to work with.

## Core Idea

A VAE compresses an image into a smaller "latent" representation (e.g., 128x128 = 16K values), works with that compressed version during generation, then decompresses back to full resolution. This compression is where the efficiency comes from, but it's also where fine details like text strokes can get lost.

## How It Works

### Encoder

Takes an input image and produces a compressed representation in latent space. Instead of outputting a single vector, it outputs a probability distribution (mean and variance) — this is what "variational" means.

### Latent Space

The compressed representation lives in a lower-dimensional space. Similar images end up close together in this space. The dimensionality is a tradeoff — smaller = faster but more information loss.

### Decoder

Takes a latent representation and reconstructs the original image. During generation, the diffusion model works in latent space, then the decoder converts the result back to pixels.

### 4-channel vs 16-channel

Standard SDXL uses 4 channels in latent space (R, G, B, plus one extra). Flux uses 16 channels. More channels = more capacity to preserve fine details like thin text strokes.

## Key Properties

- Lossy compression — some information is always lost
- Latent diffusion (LDM) runs the diffusion process in this compressed space
- 16-channel VAE preserves more high-frequency detail than 4-channel

## Connections

- Built from: [[neural-networks]]
- Built into: [[diffusion-models]], [[flux-architecture]]
- Related to: [[text-rendering-problem]]

## Edge Cases & Gotchas

- Fine details (text strokes, fine textures) blur during compression
- 4-channel VAEs lose more than 16-channel ones
- Decoder quality matters as much as encoder

## Sources

- [[imgen-summary]]
