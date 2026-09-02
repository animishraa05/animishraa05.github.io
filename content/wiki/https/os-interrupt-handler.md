---
concept: OS Interrupt Handler
aliases: [interrupt handler, interrupt service routine, ISR]
tags: [systems, os]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

When hardware interrupts arrive (keyboard, mouse, network), the CPU needs to know what to do. Without an interrupt handler, the interrupt would be ignored or crash the system.

## Core Idea

The OS interrupt handler is a function that runs when a hardware interrupt fires. It reads the scan code (for keyboard) or data (for other devices) and dispatches it to the appropriate driver or application.

## How It Works

1. **Interrupt fires**: Hardware raises IRQ (e.g., IRQ 1 for keyboard)
2. **CPU jumps**: Looks up handler in Interrupt Vector Table
3. **Handler runs**:
   - Read data from device (scan code from keyboard)
   - Convert to character (`g` = scan code 0x22)
   - Determine target application (active window = browser)
4. **Deliver event**: Send key event to application

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    IRQ [label="IRQ 1 (Keyboard)"];
    IVT [label="Interrupt Vector Table\nIRQ 1 → Handler"];
    Handler [label="OS Interrupt Handler"];
    Browser [label="Browser\nKeyDown: g"];
    
    IRQ -> IVT -> Handler -> Browser;
}
```

## Key Properties

- Interrupt Vector Table maps IRQ numbers to handler functions
- Handlers run in kernel mode (privileged)
- Must be fast—blocking handler blocks entire system
- After handler, CPU resumes previous task

## Connections

- **Built from:** [[keyboard-interrupt|Keyboard Interrupt]] — handler processes keyboard IRQs
- **Builds into:** [[browser-autocomplete|Browser Autocomplete]] — key events go to browser
- **Related:** [[interrupt-vector-table|Interrupt Vector Table]] — lookup table for handlers
- **Related:** [[kernel-mode|Kernel Mode]] — handlers run with full privileges

## Edge Cases & Gotchas

- Slow handlers cause system lag (handler blocks everything)
- Nested interrupts require careful handling
- Missing handler = interrupt ignored (or panic)
- Shared IRQs (multiple devices on one IRQ) need demultiplexing