---
title: Big Endian vs Little Endian Comparison
type: comparison
tags: [systems, memory]
created: 2026-04-30
updated: 2026-04-30
---

## The Comparison

Big Endian and Little Endian are two conventions for storing multi-byte data in memory. The difference is which byte (Most Significant or Least Significant) gets stored at the lowest memory address.

## Side-by-Side Comparison

| Feature | Big Endian | Little Endian |
|---------|-------------|----------------|
| **Byte order** | MSB → LSB (MSB first) | LSB → MSB (LSB first) |
| **Human readability** | Easier (matches usual notation) | Harder (reversed in memory dumps) |
| **CPU examples** | Motorola 68k, SPARC (sometimes) | Intel x86, AMD64 |
| **Network order** | Standard (TCP/IP network byte order) | Not standard |
| **Arithmetic efficiency** | May need extra byte reordering | Efficient for x86 arithmetic (LSB first) |
| **Debugging** | Easier to read memory dumps | Harder to read memory dumps |

## Visual Example

For 32-bit number `0x12345678`:

**Big Endian** (MSB first):
```
Address:  1000h  1001h  1002h  1003h
Data:      12     34     56     78
```

**Little Endian** (LSB first):
```
Address:  1000h  1001h  1002h  1003h
Data:      78     56     34     12
```

## Key Insights

1. **Network byte order**: TCP/IP protocols mandate Big Endian (called "network byte order"). Little Endian systems must convert when sending data over network.

2. **No "right" answer**: Both have valid use cases. Big Endian matches human reading order; Little Endian is more efficient for x86 arithmetic.

3. **Data corruption risk**: Mixing systems with different endianness without conversion causes silent data corruption.

4. **Most systems are Little Endian today**: Intel x86 dominance made Little Endian the most common desktop/PC architecture.

## Connections
- [[big-endian|Big Endian]] — MSB first storage
- [[little-endian|Little Endian]] — LSB first storage
- [[endianness|Endianness]] — the concept of byte order
- [[network-byte-order|Network Byte Order]] — Big Endian for TCP/IP
- [[memory|Memory]] — where bytes are stored
- [[multi-byte-data|Multi-Byte Data]] — what endianness applies to

## Sources
- [[computer-architecture-summary|Computer Architecture Source Summary]]
