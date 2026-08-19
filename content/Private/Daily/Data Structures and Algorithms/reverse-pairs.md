---
title: "Reverse Pairs"
link: "https://leetcode.com/problems/reverse-pairs/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem asks to find the number of "reverse pairs" where `i < j` and `nums[i] > 2 * nums[j]`. 
This is a classic variation of the "Count Inversions" problem, which is optimally solved using a modified **Merge Sort**.

During the merge sort process, the array is recursively split into a left half and a right half. At any given point when we are merging two sorted halves (`left_half` and `right_half`), we know that all elements in `left_half` appear before all elements in `right_half` in the original array (satisfying `i < j`). 
Because both halves are sorted, we can efficiently count the reverse pairs: for a specific element in `left_half`, if it is `> 2 * right_half[j]`, then all subsequent elements in `left_half` will also be greater (since `left_half` is sorted).
So, before merging the two sorted halves, we use two pointers to quickly count the valid pairs. After counting, we proceed with the standard merge operation to keep the array sorted for the parent recursive calls.

## Code
### Brute Force
```cpp
// Pseudocode:
// count = 0
// For i from 0 to nums.size():
//   For j from i + 1 to nums.size():
//       If nums[i] > 2LL * nums[j]:
//           count += 1
// Return count

#include <vector>

class Solution {
public:
    int reversePairs(std::vector<int>& nums) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (nums[i] > 2LL * nums[j]) {
                    count++;
                }
            }
        }
        return count;
        // Time: O(N^2), gets Time Limit Exceeded
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// Define mergeSort(arr, low, high):
//   If low >= high, return 0
//   mid = low + (high - low) / 2
//   count = mergeSort(arr, low, mid) + mergeSort(arr, mid + 1, high)
//   
//   // Count pairs
//   j = mid + 1
//   For i from low to mid:
//       While j <= high and arr[i] > 2LL * arr[j]:
//           j += 1
//       count += (j - (mid + 1))
//   
//   // Standard Merge
//   Merge arr[low...mid] and arr[mid+1...high]
//   Return count

#include <vector>

class Solution {
    int mergeSort(std::vector<int>& nums, int left, int right) {
        if (left >= right) return 0;
        
        int mid = left + (right - left) / 2;
        int count = mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right);
        
        // Count reverse pairs across the two halves
        int j = mid + 1;
        for (int i = left; i <= mid; i++) {
            while (j <= right && nums[i] > 2LL * nums[j]) {
                j++;
            }
            // All elements from (mid+1) to (j-1) satisfy the condition
            count += (j - (mid + 1));
        }
        
        // Merge the two sorted halves
        std::vector<int> temp;
        int i = left, k = mid + 1;
        while (i <= mid && k <= right) {
            if (nums[i] <= nums[k]) temp.push_back(nums[i++]);
            else temp.push_back(nums[k++]);
        }
        while (i <= mid) temp.push_back(nums[i++]);
        while (k <= right) temp.push_back(nums[k++]);
        
        for (int p = 0; p < temp.size(); p++) {
            nums[left + p] = temp[p];
        }
        
        return count;
    }

public:
    int reversePairs(std::vector<int>& nums) {
        return mergeSort(nums, 0, nums.size() - 1);
    }
};
```

## Complexity
- **Time Complexity**: `O(N log N)`. The recursion tree has depth `log N`. At each level, counting takes `O(N)` (since both `i` and `j` only advance forward) and merging takes `O(N)`. Therefore, total time is `O(N log N)`.
- **Space Complexity**: `O(N)` to store the temporary array during the merge process.

## Edge Cases
1. **Negative numbers**: The condition `nums[i] > 2 * nums[j]` works flawlessly with negatives. For example, `i=-1`, `j=-3`. `-1 > 2 * (-3)` => `-1 > -6`, which is True.
2. **Integer Overflow**: In C++, `2 * nums[j]` can easily overflow if `nums[j]` is close to `INT_MAX` or `INT_MIN`. It is required to use `2LL * nums[j]` to cast the multiplication to a 64-bit `long long` to prevent overflow issues.
3. **Empty or single-element array**: Handled cleanly by the `left >= right` base case, immediately returning 0.

## Notes
- **Recognition**: Finding specific pairs `(i, j)` where `i < j` and a mathematical relation holds across an unsorted array almost universally implies a Divide & Conquer / Merge Sort algorithm (or a Binary Indexed Tree / Segment Tree).
- **Separation of Concerns**: Notice how the counting logic is entirely distinct from the merging logic. We count *first*, then we merge. Trying to do both at the exact same time inside the standard merge loop leads to confusing spaghetti code. Count first, merge second.
