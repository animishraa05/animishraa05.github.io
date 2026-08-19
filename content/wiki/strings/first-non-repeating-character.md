---
concept: First Non-Repeating Character via Hashing
aliases: [first unique character, first distinct character, first non-repeated]
tags: [dev, hashing]
created: 2026-07-05
updated: 2026-07-05
---

## Formal Definition

The first non-repeating character in a string is the character that appears exactly once and whose first occurrence has the smallest index in the original string. The hash-based solution uses Phase 1 to build frequencies, then re-traverses the original string in Phase 2 to find the first character with count 1.

$$ \text{first\_non\_repeat}(S) = S_i \text{ where } H[S_i] = 1 \text{ and } \forall j < i, H[S_j] \neq 1 $$

## Explanation

This problem is the first place where Phase 2 differs meaningfully from "traverse the structure." Instead of walking the frequency array, you walk the original string a second time and check each character's frequency. This preserves insertion order, which the frequency structure does not. It teaches that Phase 2 can re-traverse the input, not just the structure.

## How It Works

1. Phase 1: Build frequency array or hash map from the input string
2. Phase 2: Iterate through the original string character by character
3. For each character `ch`, check `freq[ch - 'a'] == 1` or `freq[ch] == 1`
4. Return the first character where count equals 1
5. If no character has count 1, return a sentinel (e.g., `'\0'` or `'$'`)

## Visual Explanation

```dot
digraph first_non_repeat {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]

  INPUT [label="Input:\n'banana'"]
  P1 [label="Phase 1:\nBuild Freq\n{a:3,b:1,n:2}"]
  P2 [label="Phase 2:\nRe-traverse string"]
  CHK_B [label="'b' → freq=1\nFirst with count 1!" fillcolor="#d4edda"]
  CHK_A [label="'a' → freq=3\nskip"]
  CHK_N [label="'n' → freq=2\nskip"]

  INPUT -> P1
  P1 -> P2
  P2 -> CHK_B
  P2 -> CHK_A
  P2 -> CHK_N
}
```

## Semantic Network

```dot
graph semantic_first_non_repeat {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="First Non-Repeating" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Hashing Retrieval Phase" fillcolor="#cce5ff"]
  PRE2 [label="Two-Phase Hashing" fillcolor="#cce5ff"]
  PRE3 [label="Frequency Array" fillcolor="#cce5ff"]
  OUT1 [label="Character Hashing Use Cases" fillcolor="#d4edda"]
  CON1 [label="Most Frequent Character" fillcolor="#ffe5cc"]
  REL1 [label="Unordered Map Frequency" fillcolor="#f0f0f0"]
  REL2 [label="Array vs Hash Map Tradeoffs" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from" style=dashed]
  THIS -- PRE2 [label="built from" style=dashed]
  THIS -- PRE3 [label="built from" style=dashed]
  THIS -- OUT1 [label="builds into"]
  THIS -- CON1 [label="contrasts with" style=dotted]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="related"]
}
```

## Key Properties

- O(n) Phase 1 + O(n) Phase 2 = O(n) total — two linear passes
- Preserves original string order in Phase 2 — this is why re-traversal is necessary
- The frequency structure alone cannot answer this question (it loses order information)
- Works with both arrays and hash maps — Phase 2 checks are O(1) in both
- Early termination possible — stop at the first match

## Connections

- Built from: [[hashing-retrieval-phase|Hashing Retrieval Phase]] — re-traversing input is a specific Phase 2 pattern
- Built from: [[two-phase-hashing|Two-Phase Hashing Paradigm]] — the canonical example of Phase 2 differing from Phase 1
- Built from: [[frequency-array|Frequency Array]] — one implementation choice
- Contrasts with: [[most-frequent-character|Most Frequent Character]] — same Phase 1, different Phase 2 strategy
- Related: [[anagram-detection-via-hashing|Anagram Detection]] — another Phase 2 variant
- Related: [[map-traversal-method|Hash Map Traversal Method]] — re-traversal works regardless of structure type

## Edge Cases & Gotchas

- All characters are repeating (e.g., "aabbcc"): no character has count 1 — must handle the no-solution case
- Empty string: return sentinel immediately
- Single character (e.g., "z"): that character is the answer — Phase 2 finds it on the first check
- Case sensitivity: 'A' and 'a' are different characters — the hash structure treats them separately
- For strings with only one unique character appearing once (e.g., "aaaabbbbccccd"): 'd' is the answer
- The naive solution without hashing is O(n²) — the hash structure reduces this to O(n)

## Sources

- [[strings-summary|Strings (Character Hashing in C++)]]
