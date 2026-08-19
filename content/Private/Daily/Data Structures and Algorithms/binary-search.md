---
title: "Binary Search"
link: "https://leetcode.com/problems/binary-search/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem provides a sorted array of distinct integers and a target value. The goal is to find the index of the target or return -1 if it doesn't exist.
Because the array is sorted, we can eliminate half of the search space at each step by comparing the middle element with the target. This is the fundamental premise of Binary Search.
- If `target == mid_element`, we found it.
- If `target < mid_element`, the target must lie in the left half.
- If `target > mid_element`, the target must lie in the right half.

## Code
### Brute Force
```cpp
// Pseudocode:
// Iterate over the array from left to right.
// If nums[i] == target, return i.
// If loop completes without finding target, return -1.

#include <vector>

class Solution {
public:
    int search(std::vector<int>& nums, int target) {
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == target) {
                return i;
            }
        }
        return -1;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// Initialize left = 0, right = nums.size() - 1
// While left <= right:
//   mid = left + (right - left) / 2
//   If nums[mid] == target:
//       return mid
//   Else if nums[mid] < target:
//       left = mid + 1
//   Else:
//       right = mid - 1
// Return -1

#include <vector>

class Solution {
public:
    int search(std::vector<int>& nums, int target) {
        int left = 0;
        int right = nums.size() - 1;
        
        while (left <= right) {
            // Prevents potential integer overflow in C++
            int mid = left + (right - left) / 2;
            
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
                
        return -1;
    }
};
```

## Complexity
- **Time Complexity**: `O(log N)` where `N` is the number of elements in the array. The search space is halved in each step.
- **Space Complexity**: `O(1)`. Only constant extra space is used for variables `left`, `right`, and `mid`.

## Edge Cases
1. **Empty Array**: The constraints usually specify `nums.length >= 1`, but if empty, `left > right` initially, loop doesn't run, returns `-1` safely.
2. **Target out of bounds**: If `target` is smaller than `nums[0]` or larger than `nums.back()`, the `left` or `right` pointers will quickly cross, safely returning `-1`.
3. **Single element array**: `left = 0`, `right = 0`. `mid = 0`. It checks the only element and returns 0 or -1 accurately.
4. **Integer Overflow**: Calculating `mid = (left + right) / 2` can overflow if `left` and `right` are very large (close to `INT_MAX`). Using `left + (right - left) / 2` is the robust standard in C++.

## Notes
- **Recognition**: Look for keywords like "sorted array", "O(log n) time complexity", "find an element". 
- **Template Memorization**: Memorize the `while left <= right` template. It's the most intuitive template for searching for a specific target. 
- Always be careful with `+1` and `-1` on the pointers to avoid infinite loops. When `nums[mid]` is not the target, we know the target cannot be at `mid`, hence `mid + 1` or `mid - 1`.
