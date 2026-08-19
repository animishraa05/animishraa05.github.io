---
title: "Search in Rotated Sorted Array"
link: "https://leetcode.com/problems/search-in-rotated-sorted-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given an array that was sorted in ascending order, but then rotated at some pivot unknown to us (e.g., `[0,1,2,4,5,6,7]` might become `[4,5,6,7,0,1,2]`). We need to search for a `target` value in $O(\log N)$ time.

Since it requires $O(\log N)$ time, we must use **Binary Search**. But how do we binary search an array that isn't perfectly sorted?

The brilliant realization is that **if you divide a rotated sorted array in half, at least ONE of the two halves will ALWAYS be perfectly sorted**. 
For example, in `[4,5,6,7,0,1,2]`, if we cut at `mid = 3` (value `7`), the left half `[4,5,6,7]` is perfectly sorted. The right half is broken.
If we cut at `mid = 5` (value `1`), the right half `[1, 2]` is perfectly sorted. The left half is broken.

**The Strategy:**
1. Find the `mid` point.
2. Check if the **Left Half is sorted**: `nums[left] <= nums[mid]`.
   - If it is sorted, check if our `target` falls *strictly within the bounds* of this sorted left half (`nums[left] <= target < nums[mid]`).
     - If yes, the target MUST be in the left half. `right = mid - 1`.
     - If no, the target MUST be in the right half. `left = mid + 1`.
3. Otherwise, the **Right Half must be sorted**:
   - Check if our `target` falls *strictly within the bounds* of this sorted right half (`nums[mid] < target <= nums[right]`).
     - If yes, the target MUST be in the right half. `left = mid + 1`.
     - If no, the target MUST be in the left half. `right = mid - 1`.

## Code

### Optimal Approach (Modified Binary Search)
**C++ Code:**
```cpp
#include <vector>

class Solution {
public:
    int search(std::vector<int>& nums, int target) {
        int l = 0, r = nums.size() - 1;
        
        while (l <= r) {
            int mid = l + (r - l) / 2;
            
            if (nums[mid] == target) return mid;
            
            if (nums[l] <= nums[mid]) {
                if (nums[l] <= target && target < nums[mid]) {
                    r = mid - 1;
                } else {
                    l = mid + 1;
                }
            } else {
                if (nums[mid] < target && target <= nums[r]) {
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }
        }
        
        return -1;
    }
};
```

## Complexity
- **Time Complexity:** $O(\log N)$. Despite the array being rotated, we are still discarding exactly half of the search space at every iteration. 
- **Space Complexity:** $O(1)$. We only use three integer pointers (`l`, `r`, `mid`).

## Edge Cases
1. **Unrotated Sorted Array (`[1, 2, 3, 4, 5]`):** The condition `nums[l] <= nums[mid]` will always trigger first. The code gracefully handles this as a normal binary search.
2. **Size 1 or 2 Arrays (`[3, 1]`, target=1):** The `=` sign in `nums[l] <= nums[mid]` is critical. When `l == mid` (e.g., in a 2-element array, `mid` biases left), the left half is considered a "sorted array of size 1". It correctly determines that target is not inside it, moves `l` to `mid + 1`, and finds the target at the new `mid`. 

## Notes
- **Thought Process & Recognition:** "O(log N)" + "Array" almost definitively means Binary Search. A "Rotated Sorted Array" is one of the most classic BS modifications. 
- **Mental Trap:** A common mistake is trying to find the pivot element first (which is the minimum element, like in *Find Minimum in Rotated Sorted Array*), and then doing a standard binary search on the appropriate sub-array. While that works and is also $O(\log N)$, it requires two separate binary search passes. Doing it in a single pass as shown above is significantly more elegant and preferred in interviews.
- **The "Equal" Sign:** Always write `if nums[l] <= nums[mid]:`. Without the `=`, it will fail on arrays of size 2. Because of integer division rounding down, `mid` can equal `l`. When that happens, the left half `[l ... mid]` is just a single element, which is by definition sorted.
