---
title: "Move Zeroes"
link: "https://leetcode.com/problems/move-zeroes/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem requires us to move all `0`s to the end of an array while maintaining the relative order of the non-zero elements. Furthermore, this must be done in-place without making a copy of the array.
The underlying pattern here is the **Two-Pointer technique**, specifically the fast-and-slow pointer variant used for in-place array partitioning. 

Why this pattern? Because we need to iterate through the array (fast pointer) and keep track of where the next non-zero element should be placed (slow pointer). 
When we see a non-zero element, we swap it with the element at the slow pointer, then increment both. When we see a zero, we just increment the fast pointer.

## Code

### Brute-Force Approach
The naive approach is to create a new vector, loop through the original array, and add all non-zero elements to the new vector. Then, pad the rest of the vector with zeroes. Finally, copy the elements back to the original array.
```text
Pseudocode:
1. Create a new vector `ans` of the same length as `nums`, filled with zeroes.
2. Initialize an index `idx` = 0.
3. Iterate `num` in `nums`:
   a. If `num != 0`:
      i. `ans[idx] = num`
      ii. `idx += 1`
4. Copy elements from `ans` back to `nums`.
```

### Optimal Approach
The optimal approach does this in-place.
```text
Pseudocode:
1. Initialize `insert_pos = 0`.
2. Iterate `i` from 0 to length of `nums`:
   a. If `nums[i] != 0`:
      i. Swap `nums[insert_pos]` and `nums[i]`
      ii. Increment `insert_pos`
```

```cpp
class Solution {
public:
    void moveZeroes(vector<int>& nums) {
        int insert_pos = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] != 0) {
                swap(nums[insert_pos], nums[i]);
                insert_pos++;
            }
        }
    }
};
```

## Complexity
- **Time Complexity:** O(N), where N is the number of elements in the array. We iterate through the array exactly once, performing O(1) operations at each step.
- **Space Complexity:** O(1), because we only use a couple of variables (`insert_pos`, `i`) and modify the input array in-place.

## Edge Cases
- **All Zeroes:** `[0, 0, 0]` -> Swaps won't happen since `nums[i] != 0` is never met. `insert_pos` remains 0. Correct.
- **No Zeroes:** `[1, 2, 3]` -> Elements swap with themselves. Works perfectly but slightly redundant.
- **Single Element:** `[0]` or `[1]` -> Handled correctly.

## Notes
**Thought Process & Recognition:**
When a problem asks to modify an array "in-place" based on a condition (like separating items), always think of the Two-Pointer (read/write) pattern. The write pointer (`insert_pos`) waits at the location where the next valid item should go, while the read pointer (`i`) scans for valid items.
Practicing `Remove Element` and `Remove Duplicates from Sorted Array` will strengthen this exact pattern.
