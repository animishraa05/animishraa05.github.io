---
concept: Frequency Array
aliases: [counting array, occurrence array, "int freq[26]"]
tags: [dev, hashing]
created: 2026-07-03
updated: 2026-07-03
---

## Formal Definition

A frequency array is a fixed-size integer array where each index represents a distinct element from a known, finite domain, and the value at that index stores the count of occurrences of that element in a given dataset. For lowercase English letters, `int freq[26]` uses indices 0–25 to represent 'a'–'z'.

$$ \text{freq}[i] = \text{count of character } (i + \text{'a'}) \text{ in the input string} $$

## Explanation

A frequency array is the simplest possible hash-like structure: instead of hashing keys, you use the key itself (after a trivial transformation) as the array index. When the domain is small and known (like 26 lowercase letters), this gives you O(1) access with zero hashing overhead, zero collision handling, and minimal memory. It is the go-to data structure for character frequency problems in competitive programming and technical interviews.

## How It Works

1. Declare an array of size equal to the domain size (e.g., `int freq[26] = {0}` for lowercase letters)
2. Iterate through the input string character by character
3. Convert each character to its corresponding index using `ch - 'a'`
4. Increment `freq[index]` for each occurrence
5. To query, iterate indices 0 through size-1 and check non-zero values

## Mathematical Formulation

For a string $S$ of length $n$ over alphabet $\Sigma$ where $|\Sigma| = k$:

$$ \text{freq}[j] = \sum_{i=1}^{n} [S_i = \sigma_j] $$

where $[P]$ is the Iverson bracket (1 if $P$ true, 0 otherwise) and $\sigma_j$ is the $j$-th character of the alphabet.

## Visual Explanation

```dot
digraph frequency_array {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]

  S [label="Input: 'banana'"]
  FREQ [label="int freq[26] = {0}\nsized for a-z" fillcolor="#d4edda"]
  LOOP [label="Loop: for each char ch"]
  MAP [label="index = ch - 'a'"]
  INC [label="freq[index]++"]
  RESULT [label="freq[0]=3, freq[1]=1, freq[13]=2"]

  S -> LOOP
  LOOP -> MAP [label="per character"]
  MAP -> INC
  INC -> LOOP [label="next character"]
  LOOP -> RESULT [label="after loop"]
}
```

## Semantic Network

```dot
graph semantic_frequency_array {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Frequency Array" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Character-to-Index Mapping" fillcolor="#cce5ff"]
  PRE2 [label="Array Data Structure" fillcolor="#cce5ff"]
  OUT1 [label="Two-Phase Hashing" fillcolor="#d4edda"]
  OUT2 [label="Most Frequent Character" fillcolor="#d4edda"]
  OUT3 [label="Anagram Detection" fillcolor="#d4edda"]
  CON1 [label="Unordered Map (hash map)" fillcolor="#ffe5cc"]
  REL1 [label="Direct Array Access" fillcolor="#f0f0f0"]
  REL2 [label="Known Range Assumption" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from" style=dashed]
  THIS -- PRE2 [label="built from" style=dashed]
  THIS -- OUT1 [label="builds into"]
  THIS -- OUT2 [label="builds into"]
  THIS -- OUT3 [label="builds into"]
  THIS -- CON1 [label="contrasts with" style=dotted]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="related"]
}
```

## Key Properties

- O(1) time for both insertion and lookup — true constant time, no amortization
- Memory proportional to domain size ($O(|\Sigma|)$), not input size ($O(n)$)
- Zero hashing overhead — no hash function computation, no collision resolution
- Only works when the domain is known, finite, and contiguous (or near-contiguous)
- Access pattern is predictable — sequential memory access when iterating

## Connections

- Built from: [[character-to-index-mapping|Character-to-Index Mapping]] — the `ch - 'a'` conversion is required to map characters to array indices
- Builds into: [[two-phase-hashing|Two-Phase Hashing]] — frequency arrays are the storage mechanism in Phase 1
- Builds into: [[most-frequent-character|Most Frequent Character]] — traversing the array finds the max frequency
- Builds into: [[anagram-detection-via-hashing|Anagram Detection]] — comparing two frequency arrays checks anagrams
- Contrasts with: [[unordered-map-frequency|Unordered Map for Frequency]] — maps offer flexibility but with hashing overhead
- Related: [[direct-array-access|Direct Array Access]] — no hashing means truly direct memory access

## Edge Cases & Gotchas

- Forgetting to zero-initialize the array (`int freq[26] = {0}`) leads to garbage values
- Using `ch - 'a'` on uppercase letters or non-alphabetic characters produces negative indices or out-of-bounds access
- Array size must match the domain — `freq[26]` fails for extended ASCII or Unicode
- Iterating all 26 slots when only 3 characters appeared wastes time (minor but relevant for sparse data)
- The array stores frequencies, not positions — cannot directly answer "where does character X first appear?"