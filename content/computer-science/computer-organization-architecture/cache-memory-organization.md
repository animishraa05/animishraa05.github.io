---
title: "Cache Memory Organization"
topic: "computer-organization-architecture"
tags: [cache-memory, memory-hierarchy, gate-cse, coa]
scraped_date: 2026-03-29
---

# Cache Memory Organization

Cache memory is small, fast memory storing frequently accessed data.

## Memory Hierarchy

```
         Speed ↑    Cost ↑    Size ↓
        Registers (1 cycle)
            ↓
        L1 Cache (2-5 cycles)
            ↓
        L2 Cache (10-20 cycles)
            ↓
        L3 Cache (20-50 cycles)
            ↓
        Main Memory (50-100 cycles)
            ↓
        Disk Storage (100K+ cycles)
```

## Locality of Reference

**Temporal Locality:** Recently accessed items likely accessed again

**Spatial Locality:** Items near recently accessed items likely accessed

## AMAT (Average Memory Access Time)

```
AMAT = Hit_Time + (Miss_Rate × Miss_Penalty)
```

## Cache Mapping Techniques

### 1. Direct Mapped Cache

Each block maps to exactly one cache line.

```
Cache_Line = Block_Address mod Number_of_Cache_Lines

Address: | Tag (31-10) | Index (9-5) | Offset (4-0) |
```

**Pros:** Simple, fast
**Cons:** Conflict misses

### 2. Fully Associative Cache

Any block can go in any cache line.

```
Address: | Tag (31-4) | Offset (3-0) |
```

**Pros:** Minimum conflict misses
**Cons:** Complex hardware, slow

### 3. Set Associative Cache

Block maps to specific set, can go in any line of that set.

```
Set_Number = Block_Address mod Number_of_Sets

Address: | Tag (31-10) | Set_Index (9-4) | Offset (3-0) |
```

**Common:** 2-way, 4-way, 8-way

## Cache Miss Types (3Cs)

1. **Compulsory Miss** - First access (cold start)
2. **Capacity Miss** - Cache too small
3. **Conflict Miss** - Multiple blocks map to same location

## Write Policies

**Write Through:**
- Write to cache AND memory
- Simple, consistent, slow

**Write Back:**
- Write only to cache
- Update memory when replaced
- Fast, needs dirty bit

## Replacement Policies

- **Random** - Simple, unpredictable
- **FIFO** - Replace oldest
- **LRU** - Replace least recently used (best)
- **LFU** - Replace least frequently used

## Multi-Level Cache

```
CPU → L1 → L2 → L3 → Memory

AMAT = L1_Hit + L1_Miss × (L2_Hit + L2_Miss × L3_Hit + ...)
```

## Example Calculation

Given:
- L1 hit: 1 cycle, miss: 10%
- L2 hit: 10 cycles, miss: 2%
- Memory: 100 cycles

```
AMAT = 1 + 0.10 × (10 + 0.02 × 100)
     = 1 + 0.10 × 12
     = 2.2 cycles
```
