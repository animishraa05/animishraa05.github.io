---
title: "Find First and Last Position of Element in Sorted Array"
link: "https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given a non-decreasing array of integers and need to find the starting and ending position of a given `target` value. If not found, return `[-1, -1]`. The requirement is $O(\log N)$ time complexity.

Because the array is sorted and we need $O(\log N)$ time, we must use **Binary Search**. But standard binary search just finds *any* instance of the target. To find the extremes (first and last), we need to run Binary Search **twice**:
1. **First Binary Search (Find Leftmost):** When we find `nums[mid] == target`, we don't return immediately. Instead, we record `mid` but *continue searching to the left* (`right = mid - 1`) to see if there's an even earlier occurrence.
2. **Second Binary Search (Find Rightmost):** When we find `nums[mid] == target`, we record `mid` but *continue searching to the right* (`left = mid + 1`) to see if there's a later occurrence.

## Code

### Optimal Approach (Double Binary Search)

**Pseudocode:**
```text
function findBound(isFirst):
    l = 0, r = len(nums) - 1
    bound = -1
    while l <= r:
        mid = (l + r) / 2
        if nums[mid] == target:
            bound = mid
            if isFirst:
                r = mid - 1 # Keep looking left
            else:
                l = mid + 1 # Keep looking right
        elif nums[mid] < target:
            l = mid + 1
        else:
            r = mid - 1
    return bound

return [findBound(True), findBound(False)]
```

**C++ Code:**
```cpp
#include <vector>

class Solution {
public:
    std::vector<int> searchRange(std::vector<int>& nums, int target) {
        int first_pos = binary_search(nums, target, true);
        if (first_pos == -1) return {-1, -1};
        
        int last_pos = binary_search(nums, target, false);
        return {first_pos, last_pos};
    }
    
private:
    int binary_search(const std::vector<int>& nums, int target, bool is_finding_first) {
        int l = 0, r = nums.size() - 1;
        int bound = -1;
        
        while (l <= r) {
            int mid = l + (r - l) / 2;
            
            if (nums[mid] == target) {
                bound = mid;
                if (is_finding_first) {
                    r = mid - 1;
                } else {
                    l = mid + 1;
                }
            } else if (nums[mid] < target) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        
        return bound;
    }
};
```

## Complexity
- **Time Complexity:** $O(\log N)$. We perform two completely separate binary searches. $O(\log N) + O(\log N) = O(\log N)$. 
- **Space Complexity:** $O(1)$. We just maintain a few pointers (`l`, `r`, `mid`, `bound`).

## Edge Cases
1. **Target Not in Array:** Both searches will fall through `nums[mid] < target` or `nums[mid] > target` and `bound` will remain `-1`. Returns `[-1, -1]`.
2. **Array is Empty:** Handled correctly. Initial `r = -1`. The `while` loop never executes. Returns `[-1, -1]`.
3. **Only One Element that matches Target (`[5]`, target=5):** First search records 0, sets `r = -1`. Second search records 0, sets `l = 1`. Returns `[0, 0]`.
4. **All Elements Match Target (`[5, 5, 5, 5]`, target=5):** First search slowly squashes `r` until it finds index 0. Second search pushes `l` until it finds index 3. Returns `[0, 3]`.

## Notes
- **Thought Process & Recognition:** A core skill in binary search is tweaking the "match" condition. Standard binary search stops at a match. To find boundaries, you just log the match and *pretend* you haven't found the edge yet by aggressively shrinking the search space in the direction you want to bias towards.
- **Helper Function Elegance:** Wrapping the logic in a helper function parameterized by a boolean (`is_finding_first`) prevents you from writing the exact same `while` loop twice in an interview, making the code much cleaner and less prone to copy-paste typos.
