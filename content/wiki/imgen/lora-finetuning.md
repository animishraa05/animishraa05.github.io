---
title: LoRA Fine-tuning for Brand Consistency
concept: lora-finetuning
aliases: [low-rank adaptation, adapter weights]
tags: [ai, ml]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do you make a diffusion model produce outputs in a specific client's brand style (colors, lighting, composition) without retraining the entire model from scratch? Full fine-tuning is expensive, slow, and requires massive GPU resources.

## Core Idea

LoRA (Low-Rank Adaptation) adds small "adapter" weights to a pre-trained model. Instead of updating all 12B parameters, LoRA adds ~100MB of new weights that modify the model's behavior. The base model stays frozen -- you just load different adapters for different clients.

## How It Works

### Low-Rank Decomposition

LoRA adds two small matrices (rank r, typically 8-16) that approximate the weight change. Instead of updating a W matrix directly, you learn W + BA where B and A are small.

### Training

- Freeze the base model (Flux.1-dev)
- Add LoRA layers in parallel to attention weights
- Train on 20-50 brand images for a few hours
- Result: ~100MB .safetensors file

### Inference

- Load base Flux.1-dev (one time)
- Hot-swap LoRA files per client
- Merge at runtime -- no model reload needed

### Three LoRA Types in Our Pipeline

1. **Base Aesthetic LoRA** -- Trained on LAION-Art, gives professional photography look
2. **Brand-Specific LoRA** -- Trained on each client's 20-50 images
3. **Client LoRA** -- Hot-swapped per job

## Key Properties

- ~100MB per LoRA (vs 12GB for full model)
- Training takes hours, not days
- Hot-swappable at inference time
- Can merge multiple LoRAs (base + brand)



## Visual Explanation

```dot
digraph lora_finetuning {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Lora Finetuning\nInput"]
  B [label="Lora Finetuning\nCore Mechanism"]
  C [label="Lora Finetuning\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_lora_finetuning {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Lora Finetuning" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[diffusion-models]], [[neural-networks]]
- Used in: [[hybrid-pipeline]], [[flux-architecture]]
- Related: [[ip-adapter]]

## Edge Cases & Gotchas

- LoRA good for style, weak for exact product shapes
- Need quality training data (20-50 consistent images)
- Too many LoRAs = management overhead