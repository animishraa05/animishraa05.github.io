---
title: "Search in Rotated Sorted Array II"
link: "https://leetcode.com/problems/search-in-rotated-sorted-array-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem asks us to search for a target value in a sorted array that has been rotated at an unknown pivot. Crucially, the array **may contain duplicates**. 

**Why Modified Binary Search?**
Because the array is rotated but originally sorted, halves of the array remain strictly sorted. Binary search allows us to find the target in $O(\log n)$ time by checking which half is sorted and whether the target lies within that sorted half.

**The Complication with Duplicates:**
In the original "Search in Rotated Sorted Array" (without duplicates), we could easily tell which half was sorted by comparing `nums[mid]` with `nums[left]` or `nums[right]`. 
However, with duplicates, we can encounter a situation where `nums[left] == nums[mid] == nums[right]`. In this case, we have absolutely no way to know which half is sorted.
*Example:* Array `[1, 0, 1, 1, 1]`. Here, `left`=1, `mid`=1, `right`=1. Is the left half `[1, 0]` sorted? No. Is the right half `[1, 1]` sorted? Yes. We can't know without looking closer.
*Solution:* When `nums[left] == nums[mid] == nums[right]`, we must linearly shrink our search space by incrementing `left` and decrementing `right` until we can make a definitive binary search decision.

**Specific questions to practice:**
- Search in Rotated Sorted Array (no duplicates)
- Find Minimum in Rotated Sorted Array II (handling duplicates for min value)

## Code

### Brute-Force Approach
A simple linear scan.
*Pseudocode logic:*
1. Loop through each element in `nums`.
2. If `nums[i] == target`, return `true`.
3. Return `false`.
This takes $O(n)$ time, completely ignoring the sorted-rotated nature of the array.

### Optimal Approach (Binary Search with Shrinking)

*Pseudocode logic:*
1. Initialize `left = 0`, `right = nums.size() - 1`.
2. While `left <= right`:
   - Calculate `mid`.
   - If `nums[mid] == target`, return `true`.
   - **Handling Duplicates (The key difference):** If `nums[left] == nums[mid] == nums[right]`, we can't determine the sorted half. Increment `left`, decrement `right`, and `continue`.
   - **Left half is sorted:** If `nums[left] <= nums[mid]`:
     - If `nums[left] <= target < nums[mid]`, target is in the left half, so `right = mid - 1`.
     - Else, target is in the right half, so `left = mid + 1`.
   - **Right half is sorted:** Else (which implies `nums[mid] <= nums[right]`):
     - If `nums[mid] < target <= nums[right]`, target is in the right half, so `left = mid + 1`.
     - Else, target is in the left half, so `right = mid - 1`.
3. Return `false` if not found.

```cpp
class Solution {
public:
    bool search(std::vector<int>& nums, int target) {
        int left = 0;
        int right = nums.size() - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (nums[mid] == target) {
                return true;
            }
                
            // The tricky part: Duplicate values at boundaries
            if (nums[left] == nums[mid] && nums[mid] == nums[right]) {
                left++;
                right--;
                continue;
            }
                
            // Left half is sorted
            if (nums[left] <= nums[mid]) {
                // Is the target in this sorted left half?
                if (nums[left] <= target && target < nums[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            } 
            // Right half is sorted
            else {
                // Is the target in this sorted right half?
                if (nums[mid] < target && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
                    
        return false;
    }
};
```

## Complexity
- **Time Complexity:** 
  - **Average Case:** $O(\log n)$. Standard binary search halves the search space each step.
  - **Worst Case:** $O(n)$. When all elements are identical (e.g., `[1, 1, 1, 1, 1]`) and the target is not found, the algorithm falls back to `left++; right--;` for every element, effectively doing a linear scan.
- **Space Complexity:** $O(1)$. No extra space is used, just a few pointer variables.

## Edge Cases
- **Array of length 1 or 2:** Handled gracefully by the `<=` condition and integer division logic.
- **Extreme rotation (not rotated at all):** The left half will always be evaluated as sorted, behaving exactly like a normal binary search.
- **Target at boundaries:** E.g., target is at `left` or `right`. The `<=` operators gracefully handle bounds.

## Notes
- **Recognition:** "Sorted array" + "rotated" = Binary Search. The moment you see "duplicates allowed", immediately think: "I might lose my binary search property! I must shrink the bounds manually when `left == mid == right`."
- **Mental Model:** A rotated sorted array is just two sorted line segments, one shifted above the other. You cut it in half with `mid`. One half MUST be a single unbroken straight line (sorted). You check if your target lies strictly within the bounds of that straight line. If it does, you dive into that half. If it doesn't, you must dive into the other (potentially broken) half. The only complication is when a thick layer of fog (duplicates) obscures your view of the start, middle, and end, forcing you to take small steps inward to clear the fog.
