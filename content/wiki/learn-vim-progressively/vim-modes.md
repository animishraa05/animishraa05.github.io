---
title: Vim Modes
concept:
aliases: [mode, normal mode, insert mode, visual mode, command mode]
tags: [dev, vim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Standard text editors map most keystrokes directly to characters on screen. Vim is a modal editor where keystrokes have different meanings depending on the current mode. This design allows efficient keyboard-driven editing without modifier keys, but requires learning mode switching.

## Core Idea

Vim uses modal editing — different keystrokes do different things depending on the current mode. The main modes are Normal (for commands), Insert (for typing), and Visual (for selection).

## How It Works

- **Normal mode**: Default mode. Keystrokes are commands (move, delete, yank, etc.). Press `ESC` to return here from other modes.
- **Insert mode**: Type characters literally. Press `i` from Normal to enter, `ESC` to exit.
- **Visual mode**: Select text for operations. Enter with `v` (character-wise), `V` (line-wise), or `<C-v>` (block-wise).

Key mappings:
| Key | Action |
|-----|--------|
| `i` | Enter Insert mode before cursor |
| `a` | Enter Insert mode after cursor |
| `ESC` | Return to Normal mode |

## Key Properties

- Vim starts in Normal mode by default
- Mode switching is explicit — no hold-to-edit like Ctrl in conventional editors
- Visual mode has three variants: character, line, and block
- `:` 进入 Ex 命令行 mode (also considered a mode)

## Edge Cases & Gotchas

- Accidental key presses in Normal mode can cause unintended edits (e.g., `i` in the middle of a word inserts before it, not split it — use `s` or `a` instead)
- Caps Lock matters: `i` is insert, `I` is different command
- `:help mode` shows current mode help

## Connections

- [[vim-basic-commands|Survival Commands]] — Five commands that work in Normal mode
- [[vim-text-objects|Text Objects]] — Selection commands that require Visual mode
- [[vim-visual-selection|Visual Selection]] — Modes for selecting text blocks
- [[vim-macros|Macros]] — Recording in Normal mode