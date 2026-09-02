---
concept: GPU Rendering
aliases: [hardware acceleration, GPU acceleration, graphics rendering]
tags: [dev, browser]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

The CPU can draw pixels, but it's slow for animations, scrolling, and complex visual effects. Without GPU acceleration, web pages would feel sluggish and janky.

## Core Idea

GPU rendering uses the Graphics Processing Unit (GPU) to accelerate painting and compositing. GPUs are designed for parallel pixel operations, making scrolling and animations smooth (60+ FPS).

## How It Works

1. **CPU paints**: Initial painting may happen on CPU
2. **Layers to GPU**: Painted layers uploaded to GPU memory
3. **GPU composites**: GPU combines layers, applies transforms/opacity
4. **Result**: Smooth animations without CPU involvement

GPU excels at:
- Transforming layers (translate, scale, rotate)
- Adjusting opacity
- Compositing multiple layers

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    CPU [label="CPU\nPainting"];
    GPU [label="GPU\nCompositing & Transform"];
    Screen [label="Screen\n60 FPS"];
    
    CPU -> GPU -> Screen;
}
```

## Key Properties

- Parallel processing: GPU has thousands of small cores
- Off-main-thread: doesn't block JavaScript
- Used for: transforms, opacity, scrolling, video
- Layers must be uploaded to GPU memory (costly first time)

## Connections

- **Built from:** [[compositing|Compositing]] — GPU does the compositing
- **Related:** [[painting|Painting]] — CPU may do initial paint
- **Related:** [[browser-rendering|Browser Rendering]] — GPU rendering is step 6
- **Contrasts with:** [[cpu-rendering|CPU Rendering]] — GPU is faster for graphics

## Edge Cases & Gotchas

- Uploading layers to GPU has initial cost
- GPU memory is limited—too many layers cause issues
- Not all CSS properties are GPU-accelerated
- `transform` and `opacity` are the best for animations