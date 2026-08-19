---
title: Two-Phase Hashing Patterns — A Catalog of Phase 2 Strategies
type: deep-dive
tags: [dev, hashing]
created: 2026-07-05
updated: 2026-07-05
---

## Framing

The two-phase hashing paradigm separates frequency problems into Phase 1 (store) and Phase 2 (use). While Phase 1 is nearly identical across all problems, Phase 2 varies based on what the problem asks for. This deep-dive catalogs the distinct Phase 2 patterns, showing how the same data structure supports fundamentally different queries.

## The Five Phase 2 Patterns

### Pattern 1: Traverse for Extremum (Most Frequent Character)

Walk the entire structure, tracking a running maximum. For arrays, this means iterating indices 0–25. For maps, iterating key-value pairs.

```
maxCount = 0
maxChar = ''
for each entry (key, count) in structure:
    if count > maxCount:
        maxCount = count
        maxChar = key
return maxChar
```

**Used by:** most frequent character, least frequent character, character with maximum occurrences

### Pattern 2: Re-traverse Input for Order (First Non-Repeating Character)

Iterate the original string a second time and check each character's frequency in the structure. This preserves the original insertion order.

```
for each ch in originalString:
    if freq[ch] == 1:
        return ch
return sentinel
```

**Used by:** first non-repeating character, first repeating character, first character with frequency K

### Pattern 3: Compare Two Structures (Anagram Detection)

Build two frequency structures (Phase 1 for each input), then compare entry by entry. For arrays this means element-wise comparison; for maps, checking all key-value pairs match.

```
if len(S1) != len(S2): return false
freq1 = build(S1)
freq2 = build(S2)
return freq1 == freq2
```

**Used by:** anagram detection, string permutation check, isomorphic strings

### Pattern 4: Constraint Check (Palindrome Rearrangement)

Check if frequencies satisfy a condition without finding a specific character. The condition often involves the parity of counts.

```
oddCount = 0
for each count:
    if count % 2 == 1:
        oddCount++
return oddCount <= 1
```

**Used by:** palindrome rearrangement possible? string can be made palindrome, at most K swaps

### Pattern 5: Structure Comparison with Difference (Edit Distance for Anagrams)

Compute the difference between two frequency structures to determine how many changes are needed to make two strings anagrams.

```
diff = 0
for i in 0..25:
    diff += abs(freq1[i] - freq2[i])
return diff / 2
```

**Used by:** minimum steps to make anagram, character deletions to make strings equal

## Insights

The key insight is that **Phase 1 is invariant across all these problems.** You can write the frequency-building code once and reuse it. The only thing that changes is the Phase 2 loop. This is why recognizing the pattern is more important than memorizing the solution: once you identify which Phase 2 pattern a problem uses, you can write the solution from first principles.

A second insight is that **some problems combine multiple patterns.** For example, finding the most frequent character in the first string that also appears at least twice in the second string: Pattern 3 (compare) + Pattern 1 (extremum).

## Connections

- [[two-phase-hashing|Two-Phase Hashing Paradigm]] — the overarching model
- [[hashing-store-phase|Hashing Store Phase]] — Phase 1, invariant across patterns
- [[hashing-retrieval-phase|Hashing Retrieval Phase]] — Phase 2, the pattern catalog
- [[most-frequent-character|Most Frequent Character]] — implements Pattern 1
- [[first-non-repeating-character|First Non-Repeating Character]] — implements Pattern 2
- [[anagram-detection-via-hashing|Anagram Detection]] — implements Pattern 3
- [[character-hashing-use-cases|Character Hashing Use Cases]] — the full set of problems
- [[frequency-array|Frequency Array]] — the structure used in Phase 1
- [[unordered-map-frequency|Unordered Map for Frequency Counting]] — alternative Phase 1 structure
