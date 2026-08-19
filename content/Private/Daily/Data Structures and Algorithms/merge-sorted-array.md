---
title: "Merge Sorted Array"
link: "https://leetcode.com/problems/merge-sorted-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem requires merging two sorted arrays, `nums1` and `nums2`, into a single sorted array. The catch is that the result must be stored in-place within `nums1`, which has been allocated enough extra space at its end (denoted by $0$'s) to hold the elements of `nums2`.

**Why Reverse Two Pointers?**
Normally, to merge two sorted arrays, we use two pointers starting from the beginning of both arrays. We compare the elements and place the smaller one into a new array. However, if we do this in-place starting from the front of `nums1`, we will overwrite elements in `nums1` that haven't been evaluated yet. 

To avoid overwriting, we can utilize the empty space at the back of `nums1`. We start our pointers at the **end of the valid elements** in `nums1` and `nums2`, and a third pointer at the **very end** of `nums1`. We compare the largest elements and place them at the end, working our way backward. 

**Specific questions to practice:**
- Merge Two Sorted Lists (Linked List version)
- Sort Colors (Three pointers)
- Squares of a Sorted Array

## Code

### Brute-Force Approach
A naive way would be to just copy the elements of `nums2` into the empty slots at the end of `nums1`, and then sort the entirety of `nums1`.

*Pseudocode logic:*
1. Loop `i` from $0$ to $n-1$:
   - `nums1[m + i] = nums2[i]`
2. Sort `nums1`.

This works but fails to take advantage of the fact that the arrays are already sorted.

### Optimal Approach (Three Pointers / Reverse Merge)
We maintain three pointers:
- `p1`: points to the last valid element in `nums1` ($m - 1$)
- `p2`: points to the last element in `nums2` ($n - 1$)
- `p`: points to the very end of `nums1` ($m + n - 1$)

*Pseudocode logic:*
1. While `p1 >= 0` and `p2 >= 0`:
   - If `nums1[p1] > nums2[p2]`:
     - Set `nums1[p] = nums1[p1]`
     - Decrement `p1` and `p`
   - Else:
     - Set `nums1[p] = nums2[p2]`
     - Decrement `p2` and `p`
2. If `p2 >= 0` (meaning there are still elements left in `nums2`), copy them over to the remaining slots at the front of `nums1`. (If `p1 >= 0`, we don't need to do anything because they are already in place).

```cpp
class Solution {
public:
    void merge(std::vector<int>& nums1, int m, std::vector<int>& nums2, int n) {
        // Initialize pointers
        int p1 = m - 1;          // Last element of valid nums1
        int p2 = n - 1;          // Last element of nums2
        int p = m + n - 1;       // Last position in nums1 array
        
        // Merge in reverse order
        while (p1 >= 0 && p2 >= 0) {
            if (nums1[p1] > nums2[p2]) {
                nums1[p] = nums1[p1];
                p1--;
            } else {
                nums1[p] = nums2[p2];
                p2--;
            }
            p--;
        }
            
        // Add missing elements from nums2 if any
        // (If nums1 elements are left, they are already in the correct place)
        while (p2 >= 0) {
            nums1[p] = nums2[p2];
            p2--;
            p--;
        }
    }
};
```

## Complexity
- **Time Complexity:** $O(m + n)$
  - We traverse both arrays at most once. Each step places exactly one element into its correct final position in `nums1`.
- **Space Complexity:** $O(1)$
  - We are performing the merge in-place within `nums1` without allocating any additional arrays.

## Edge Cases
- `nums2` is empty ($n = 0$): The first `while` loop won't execute, and the second `while` loop won't execute. `nums1` remains unchanged, which is correct.
- `nums1` is "empty" ($m = 0$): The first `while` loop won't execute. The second `while` loop will copy all elements of `nums2` into `nums1`. Correct.
- All elements of `nums2` are smaller than all elements of `nums1`: `p1` elements will be placed at the end, and then the remaining elements of `nums2` will be cleanly swept into the front by the second `while` loop.

## Notes
- **Thought Process & Recognition:** Whenever a problem asks to process arrays "in-place" and one array has extra padding at the end, the **Reverse Two Pointer** technique is highly likely the intended solution. Modifying from the front causes data destruction; modifying from the back utilizes the "safe" buffer zone.
- **Mental Model:** Think of it like organizing two stacks of graded papers from highest score to lowest. You look at the top of both stacks, grab the higher score, and place it at the very bottom of a new pile. Because `nums1` is your "new pile" and its bottom is empty, you don't crush any existing papers.
