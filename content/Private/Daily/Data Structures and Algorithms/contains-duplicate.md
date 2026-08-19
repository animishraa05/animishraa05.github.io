---
title: "Contains Duplicate"
link: "https://leetcode.com/problems/contains-duplicate/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
Given an integer array `nums`, return `true` if any value appears at least twice in the array, and return `false` if every element is distinct.
The most straightforward approach is to use a Hash Set. As we iterate through the array, we check if the element is already in the set. If it is, we've found a duplicate. Otherwise, we add it to the set.

## Code

### Brute-Force Approach
Compare every element with every other element.
```text
Pseudocode:
1. For i from 0 to N-1:
2.   For j from i+1 to N-1:
3.     If nums[i] == nums[j], return true
4. Return false
```

### Optimal Approach
Hash Set implementation.
```text
Pseudocode:
1. Initialize an empty Hash Set `seen`.
2. For each num in nums:
3.   If num is in `seen`, return true
4.   Add num to `seen`
5. Return false
```

```cpp
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        unordered_set<int> seen;
        for (int num : nums) {
            if (seen.count(num)) {
                return true;
            }
            seen.insert(num);
        }
        return false;
    }
};
```

## Complexity
- **Time Complexity:** O(N), as inserting and looking up in an `unordered_set` takes O(1) on average. We do this N times.
- **Space Complexity:** O(N), in the worst-case scenario (no duplicates), all elements will be stored in the hash set.

## Edge Cases
- **Empty Array:** `[]` -> Returns false safely.
- **One Element:** `[1]` -> Returns false safely.
- **Massive Array with one duplicate at the very end:** Will consume O(N) space and O(N) time but completes safely.

## Notes
**Thought Process & Recognition:**
Looking for duplicates or tracking "seen" states efficiently strongly hints at Hash Sets (`std::unordered_set`). Sorting is also a viable O(N log N) time and O(1) space alternative if modifying the array is allowed and space is extremely constrained.
