---
title: Vim Repetition
concept:
aliases: [dot command, repetition, counts, N<command>]
tags: [dev, vim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Repeating the same operation multiple times is inefficient. Manual replication wastes time and introduces inconsistency.

## Core Idea

Two repetition mechanisms: the dot command (`.`) repeats the last change; numeric prefixes repeat commands N times.

## How It Works

### Dot Command (`.`)

- Repeats the last Simple change
- Examples:
  - `100idesu [ESC]` writes "desu" 100 times
  - `.` repeats that 100 "desu"
  - `3.` repeats 3 times (300 total, not 300!)
- A Simple change = one command that makes one change

### Numeric Prefix (`N<command>`)

- Precedes any command with a count
- Examples:
  - `2dd` — delete 2 lines
  - `3p` — paste 3 times
  - `5 dw` — delete 5 words
  - `10j` — move down 10 lines

## Key Properties

- `.` only repeats simple changes, not complex sequences
- Numeric counts are multiplied, not added: `3.` × 3 = 9 not 6
- Operator + motion = repeat-able command: `d2w` is one command
- `u` undo is itself undo-able

## Edge Cases & Gotchas

- `.` doesn't repeat Ex commands (`:s/...`)
- `.` after `.` compounds: `2.` = 6 total
- Search/replace needs `:s///&` or `&` to repeat

## Connections

- [[vim-basic-commands|Survival Commands]] — `dd` and `p` are repeatable
- [[vim-modes|Vim Modes]] — Repetition works in Normal mode
- [[vim-search-navigation|Navigation]] — `N` prefix repeats search
- [[vim-macros|Macros]] — More complex repetition with recording