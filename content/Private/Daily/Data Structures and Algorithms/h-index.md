---
title: "H-Index"
link: "https://leetcode.com/problems/h-index/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The H-Index is defined as the maximum value `h` such that the given researcher has published at least `h` papers that have each been cited at least `h` times.
To figure this out, we can sort the citations in descending order. Then, the H-index is simply the number of papers that have a citation count greater than or equal to their rank (1-indexed position in the sorted list).
Alternatively, we can use Counting Sort / Bucket Sort for an O(N) solution since the H-index cannot exceed the total number of papers `N`.

## Code

### Brute-Force Approach (Sorting)
```text
Pseudocode:
1. Sort citations in descending order.
2. Iterate `i` from 0 to length of citations.
3. If `citations[i] >= i + 1`, the paper contributes to an h-index of at least `i + 1`.
4. Return the maximum `h` found (which is just `i` when the condition fails).
```

### Optimal Approach (Bucket Sort)
```text
Pseudocode:
1. N = length of citations.
2. Create a vector `buckets` of size N + 1 initialized to 0.
3. Iterate over citations:
   a. If citation >= N, increment `buckets[N]`
   b. Else, increment `buckets[citation]`
4. Keep a running sum of papers from right to left (N down to 0).
5. When running sum >= index, return index as the h-index.
```

```cpp
class Solution {
public:
    int hIndex(vector<int>& citations) {
        int n = citations.size();
        vector<int> buckets(n + 1, 0);
        
        for (int c : citations) {
            if (c >= n) {
                buckets[n]++;
            } else {
                buckets[c]++;
            }
        }
        
        int count = 0;
        for (int i = n; i >= 0; --i) {
            count += buckets[i];
            if (count >= i) {
                return i;
            }
        }
        return 0;
    }
};
```

## Complexity
- **Time Complexity:** O(N) for the bucket sort approach. We iterate through the array to populate the buckets, and then iterate at most N+1 times to find the answer. The sorting approach takes O(N log N).
- **Space Complexity:** O(N) to store the buckets array. If we use the sorting approach, it could be O(1) or O(N) depending on the sorting algorithm space.

## Edge Cases
- **All 0s:** `[0, 0, 0]` -> Bucket 0 gets 3. Loop checks index 3 (count=0 < 3), index 2 (count=0 < 2), index 1 (count=0 < 1), index 0 (count=3 >= 0). Returns 0.
- **Very high citations:** `[100, 200, 300]` (N=3). All go to bucket 3. Count at index 3 becomes 3. 3 >= 3. Returns 3.
- **Single element:** `[0]` returns 0, `[1]` returns 1.

## Notes
**Thought Process & Recognition:**
When the answer `k` is strictly bounded by the size of the array `N` (an H-index cannot exceed the number of papers), this is a massive clue for Bucket Sort / Counting Sort. Instead of standard sorting `O(N log N)`, we group items into buckets and calculate from the top down.
