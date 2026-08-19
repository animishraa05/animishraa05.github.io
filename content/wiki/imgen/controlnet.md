---
title: ControlNet
concept: controlnet
aliases: [spatial conditioning, control models]
tags: [ai, diffusion]
sources_count: 1
last_source: imgen.md
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do you tell a diffusion model exactly WHERE something should be in the image, or WHAT specific spatial structure to follow — not just what's in the prompt? Standard text-to-image only gives you coarse control through prompts.

## Core Idea

ControlNet is an additional neural network that runs in parallel with the diffusion model. It takes an extra input (edge map, depth map, pose skeleton, or glyph image) and adds spatial constraints to the generation process. The model must follow your control signal while still generating based on the text prompt.

## How It Works

### Architecture

ControlNet copies the UNet/DiT encoder layers and trains them separately on the control task. The trained ControlNet weights connect to the main model via "zero convolutions" that gradually merge the control signal.

### Control Types

- **Canny Edge**: Follow edges from an image
- **Depth**: Follow depth map structure
- **Pose**: Follow human pose skeleton
- **Segmentation**: Follow object layout
- **Glyph**: Follow exact text stroke positions (for text rendering)

### For Glyph Injection

When we render "Made by Lakme" as a black-on-white image and pass it to ControlNet, the model receives pixel-level spatial constraints: "there must be dark strokes at these coordinates." It doesn't need to understand letters — it just follows the stroke pattern.

## Key Properties

- Pre-trained weights available for all control types
- Zero training required for glyph control
- controlnet_scale (0-1) controls strength
- Works with Flux, SDXL, other diffusers

## Connections

- Built from: [[diffusion-models]], [[vae]]
- Used in: [[glyph-injection]], [[hybrid-pipeline]]
- Related to: [[flux-architecture]]

## Edge Cases & Gotchas

- Thin strokes = weak signal = drift
- Scale too high = looks pasted on
- Scale too low = doesn't follow constraints
- Additional VRAM needed

## Sources

- [[imgen-summary]]
