---
title: "Sort Colors"
link: "https://leetcode.com/problems/sort-colors/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem requires us to sort an array containing only three distinct values: 0 (red), 1 (white), and 2 (blue). We must do this in-place without using the library's sort function.

**Why the Dutch National Flag Algorithm?**
This is a famous algorithm designed by Edsger Dijkstra specifically for this problem. The array is conceptually divided into four regions:
1. `[0, low - 1]`: strictly 0s.
2. `[low, mid - 1]`: strictly 1s.
3. `[mid, high]`: unknown, yet to be explored.
4. `[high + 1, n - 1]`: strictly 2s.

By maintaining three pointers (`low`, `mid`, `high`), we evaluate the `mid` pointer. If we see a 0, we swap it to the `low` region. If we see a 2, we swap it to the `high` region. If we see a 1, we just leave it and move `mid` forward. This partitions the array in a single pass.

**Specific questions to practice:**
- Wiggle Sort
- Move Zeroes
- Partition Array According to Given Pivot

## Code

### Brute-Force Approach (Counting Sort)
A simple two-pass approach.
*Pseudocode logic:*
1. First pass: Count the occurrences of 0s, 1s, and 2s using three variables or a hash map.
2. Second pass: Overwrite the array. Fill the first `count(0)` slots with 0, the next `count(1)` slots with 1, and the remaining with 2.
*Complexity:* $O(n)$ time, but requires two passes. The problem asks if we can do it in a single pass.

### Optimal Approach (One-Pass Three Pointers / Dutch National Flag)
*Pseudocode logic:*
1. Initialize `low = 0`, `mid = 0`, `high = nums.size() - 1`.
2. While `mid <= high` (while there are still unexplored elements):
   - If `nums[mid] == 0`: 
     - Swap `nums[low]` and `nums[mid]`.
     - Increment both `low` and `mid` (we know the swapped-in value is a 1, so `mid` is safe to advance).
   - If `nums[mid] == 1`:
     - Just increment `mid`.
   - If `nums[mid] == 2`:
     - Swap `nums[mid]` and `nums[high]`.
     - Decrement `high`. (Do **not** increment `mid` here, because the element swapped from `high` is unknown and needs to be evaluated next).

```cpp
class Solution {
public:
    void sortColors(std::vector<int>& nums) {
        int low = 0;
        int mid = 0;
        int high = nums.size() - 1;
        
        while (mid <= high) {
            if (nums[mid] == 0) {
                // 0 belongs to the low region
                std::swap(nums[low], nums[mid]);
                low++;
                mid++;
            } else if (nums[mid] == 1) {
                // 1 belongs in the middle region, just move forward
                mid++;
            } else { // nums[mid] == 2
                // 2 belongs to the high region
                std::swap(nums[mid], nums[high]);
                high--;
                // Notice we do NOT increment mid here. The element we just 
                // swapped from 'high' needs to be checked on the next iteration.
            }
        }
    }
};
```

## Complexity
- **Time Complexity:** $O(n)$
  - We traverse the array exactly once. The `mid` pointer moves forward, or the `high` pointer moves backward, guaranteeing that the distance between `mid` and `high` decreases by 1 each step.
- **Space Complexity:** $O(1)$
  - Only three pointers are used. The array is modified in-place.

## Edge Cases
- **All elements are the same color:** (e.g., `[1, 1, 1]`). `mid` just marches to the end. `[0, 0, 0]`: swapped with itself, `low` and `mid` march. `[2, 2, 2]`: `high` decreases until it crosses `mid`.
- **Array already sorted:** `[0, 1, 2]`. Handles smoothly.
- **Only two colors:** `[0, 2]`. `mid` stops immediately after crossing `high`.

## Notes
- **Recognition:** Sorting an array containing only $k$ distinct values (where $k$ is very small, like 2 or 3) heavily hints at pointer-based partitioning logic instead of traditional comparison sorts like Merge Sort or Quick Sort.
- **Mental Model:** Think of `mid` as the "current explorer" moving left to right. `low` is the "garbage bin for 0s" growing from the left. `high` is the "garbage bin for 2s" growing from the right. `mid` grabs an item, tosses it into the appropriate bin, and moves on. The trap is tossing a 2 into the right bin—you don't know what item the right bin threw back at you, so `mid` must stay put and inspect the new item.
