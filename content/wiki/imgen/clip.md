---
title: CLIP Text Encoder
concept: clip
aliases: [contrastive learning, vision-language]
tags: [ai, ml]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do you connect text (language) to images (vision) in a way that lets a diffusion model "understand" what you want when you type a prompt? You need a text encoder that maps language to the same representation space as images.

## Core Idea

CLIP (Contrastive Language-Image Pre-training) uses contrastive learning — it looks at millions of image-text pairs and learns to align the vector representation of an image with its corresponding text description. Once trained, CLIP can encode any text into a vector that "makes sense" to image-based models.

## How It Works

### Training

Show the model many (image, text) pairs. For each batch, the model tries to match the correct image-text pairs while distinguishing incorrect ones. This creates aligned embedding spaces.

### Text Encoding

When you type a prompt, the text encoder converts each word/token into a vector. These vectors live in the same space as image features — so "a dog" and an image of a dog have similar vectors.

### Limitations for Text Rendering

CLIP was trained on natural image-text pairs (captions, descriptions). It learned semantic meaning — "dog" means the animal concept. It did NOT learn to distinguish between "Lakme" and "LAKME" or track exact character sequences. For CLIP, these are all the same concept.

## Key Properties

- 77 token context limit
- Semantic understanding (concepts, not characters)
- Used in SDXL, some Flux components
- Fast inference

## Connections

- Built from: [[transformers]], [[neural-networks]]
- Built into: [[flux-architecture]], [[hybrid-pipeline]]
- Related to: [[text-rendering-problem]], [[t5-encoder]]

## Edge Cases & Gotchas

- Character-blind: "Lakme", "LAKME", "lakme" = same vector
- 77 token limit = struggles with very long prompts
- Semantic focus misses fine details like letter shapes