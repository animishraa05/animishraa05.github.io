---
title: "Search Insert Position"
link: "https://leetcode.com/problems/search-insert-position/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given a *sorted* array of distinct integers and a target value. We need to return the index if the target is found. If not, return the index where it would be if it were inserted in order.
The constraint $O(\log N)$ runtime complexity immediately screams **Binary Search**.

The algorithm is a standard binary search:
1. Maintain two pointers, `left` and `right`.
2. Calculate the `mid` pointer.
3. Compare `nums[mid]` to `target`.
4. If they match, return `mid`.
5. If `nums[mid] < target`, the target must be to the right, so `left = mid + 1`.
6. If `nums[mid] > target`, the target must be to the left, so `right = mid - 1`.

**The "Trick":** What happens if the element is *not* found? 
When the `while left <= right` loop terminates without finding the target, the pointers have crossed. At this exact moment, `left` will inherently be pointing to the exact index where the target *should* be inserted. Why? Because the loop exits when `left > right`. The final move before exiting was either:
- `left` moving past `right` (target is greater than `nums[right]`, so it belongs at `right + 1` which is `left`).
- `right` moving below `left` (target is less than `nums[left]`, so it belongs at `left`).
In either case, `left` is the correct insertion index.

## Code

### Optimal Approach (Binary Search)
**Pseudocode:**
```text
l = 0, r = len(nums) - 1
while l <= r:
    mid = l + (r - l) / 2
    if nums[mid] == target:
        return mid
    elif nums[mid] < target:
        l = mid + 1
    else:
        r = mid - 1
return l
```

**C++ Code:**
```cpp
#include <vector>

class Solution {
public:
    int searchInsert(std::vector<int>& nums, int target) {
        int l = 0, r = nums.size() - 1;
        
        while (l <= r) {
            // Prevents integer overflow in C++
            int mid = l + (r - l) / 2;
            
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        
        return l;
    }
};
```

## Complexity
- **Time Complexity:** $O(\log N)$. Standard binary search halves the search space at each step.
- **Space Complexity:** $O(1)$. We only use a few variables for pointers (`l`, `r`, `mid`).

## Edge Cases
1. **Target is smaller than all elements:** The `r` pointer will keep shifting left until `r = -1`. The loop breaks, and `l` is `0`. Correct, it belongs at the start.
2. **Target is larger than all elements:** The `l` pointer will keep shifting right until it equals `len(nums)`. The loop breaks, and `l` is returned. Correct, it belongs at the very end.
3. **Empty Array:** If given (though constraints say length >= 1), `l=0`, `r=-1`. Loop doesn't run, returns `0`. 

## Notes
- **Thought Process & Recognition:** "Sorted Array" + "Find/Search" + "O(log N)" = **Binary Search**. It's the most literal translation of the pattern possible.
- **Mental Model for Insertion:** A great way to visualize why `return l` works is to imagine binary search as zooming in on a gap between two numbers. When the search space narrows to zero (pointers cross), `left` always lands on the first element *greater* than the target. Thus, pushing that element (and everything after it) to the right to make room means the new element takes `left`'s index!
