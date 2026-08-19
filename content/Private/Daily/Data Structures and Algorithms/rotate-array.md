---
title: "Rotate Array"
link: "https://leetcode.com/problems/rotate-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to rotate an array to the right by `k` steps in-place.
A classic approach is to use the **Reverse Array Trick**. 
If you reverse the entire array, then reverse the first `k` elements, and finally reverse the remaining `N-k` elements, the array ends up perfectly rotated.
Before doing anything, we must do `k = k % N` because rotating an array by its length results in the original array.

## Code

### Brute-Force Approach
Pop from the end and insert at the beginning `k` times. Or use an extra array.
```text
Pseudocode:
1. `k = k % N`
2. Create `new_arr` of size N.
3. For i in range(N):
4.   `new_arr[(i + k) % N] = nums[i]`
5. Copy `new_arr` to `nums`.
```

### Optimal Approach
Reverse array in 3 parts.
```text
Pseudocode:
1. `n = length of nums`
2. `k = k % n`
3. Reverse the entire array: `reverse(nums, 0, n - 1)`
4. Reverse the first k elements: `reverse(nums, 0, k - 1)`
5. Reverse the rest: `reverse(nums, k, n - 1)`
```

```cpp
class Solution {
public:
    void rotate(vector<int>& nums, int k) {
        int n = nums.size();
        k = k % n;
        
        reverse(nums.begin(), nums.end());
        reverse(nums.begin(), nums.begin() + k);
        reverse(nums.begin() + k, nums.end());
    }
};
```

## Complexity
- **Time Complexity:** O(N). Reversing the array takes O(N/2), doing it in parts takes another O(N/2). Total time is strictly linear.
- **Space Complexity:** O(1), entirely in-place.

## Edge Cases
- **k is 0 or multiple of N:** `k % N` becomes 0. The first reverse flips it, `reverse(0, 0)` does nothing, `reverse(0, N-1)` flips it back to original. Perfect.
- **k is very large:** Handled cleanly by `k % N`.

## Notes
**Thought Process & Recognition:**
When asked to shift or rotate elements in an array or string in-place (O(1) space), think of Reversals (`std::reverse`). It's a mathematical trick: rotating is just taking a suffix and moving it to the prefix. Reversing the whole string swaps prefix and suffix, and then localized reversals restore their internal ordering.
