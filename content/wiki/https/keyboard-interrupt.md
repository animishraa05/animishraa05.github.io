---
concept: Keyboard Interrupt
aliases: [key press, scan code, keyboard controller]
tags: [systems, hardware]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

When you press a key, the computer needs to know about it immediately. Without interrupts, the CPU would have to constantly poll (check) the keyboard, wasting cycles.

## Core Idea

A keyboard interrupt is a hardware signal sent to the CPU when a key is pressed (or released). The keyboard controller converts the physical keypress into a scan code and triggers an interrupt for the OS to handle.

## How It Works

1. **Key press**: Physical switch closes in keyboard matrix
2. **Scan code**: Keyboard controller generates scan code (e.g., `g` = code 0x22)
3. **Interrupt**: Keyboard raises hardware interrupt (IRQ 1 on x86)
4. **OS handler**: CPU jumps to interrupt handler, reads scan code
5. **To application**: OS delivers key event to active app (browser)

USB keyboards poll at ~10ms instead of generating interrupts.

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Key [label="Key Press (g)"];
    Controller [label="Keyboard Controller\ngenerate scan code"];
    Interrupt [label="Hardware Interrupt\n(IRQ 1)"];
    OS [label="OS Handler\nread scan code"];
    App [label="Browser\nKeyDown: g"];
    
    Key -> Controller -> Interrupt -> OS -> App;
}
```

## Key Properties

- Scan codes are hardware-specific (not ASCII)
- USB polls at ~10ms (not true interrupts)
- OS converts scan codes to characters
- Interrupt Vector Table maps IRQ to handler



## Semantic Network

```dot
graph semantic_Keyboard_Interrupt {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Keyboard Interrupt" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- **Builds into:** [[os-interrupt-handler|OS Interrupt Handler]] -- OS handles the interrupt
- **Related:** [[keyboard-matrix|Keyboard Matrix]] -- physical circuit for keys
- **Related:** [[scan-code|Scan Code]] -- what keyboard controller generates
- **Contrasts with:** [[polling|Polling]] -- interrupts vs continuous checking

## Edge Cases & Gotchas

- Key repeat triggers multiple interrupts (hold key down)
- USB keyboards don't use hardware interrupts (polling)
- Some keys have two-byte scan codes (extended keys)
- Interrupt storms can overwhelm CPU (too many fast keypresses)