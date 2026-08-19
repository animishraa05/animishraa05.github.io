---
title: "Single Element in a Sorted Array"
link: "https://leetcode.com/problems/single-element-in-a-sorted-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given a sorted array where every element appears twice except for one. We need to find that single element in `O(log n)` time. The constraint of `O(log n)` time strongly points to Binary Search.

Let's observe the pairs and their indices.
Before the single element, the pairs follow the pattern:
- First instance is at an **even** index.
- Second instance is at an **odd** index.
Example: `[1, 1, 2, 2, 3, 4, 4]` (Indices: `0, 1, 2, 3, 4, 5, 6`). 
For `1`s: indices `0` (even), `1` (odd). For `2`s: indices `2` (even), `3` (odd).

After the single element (which is `3` at index `4`), the pattern flips:
- First instance is at an **odd** index.
- Second instance is at an **even** index.
For `4`s: indices `5` (odd), `6` (even).

We can use binary search on the array indices. For any `mid`, if `mid` is even, its pair should theoretically be at `mid + 1`. If `nums[mid] == nums[mid + 1]`, we know the single element is to the right (we are still in the normal even-odd pattern). If they don't match, the single element is to the left (or is `mid` itself).
Using bitwise XOR (`mid ^ 1`) cleverly toggles between the pair components:
- If `mid` is even, `mid ^ 1` is `mid + 1`.
- If `mid` is odd, `mid ^ 1` is `mid - 1`.
We just need to check if `nums[mid] == nums[mid ^ 1]`.

## Code
### Brute Force
```cpp
// Pseudocode:
// XOR all elements in the array.
// Since every number appears twice, x ^ x = 0.
// The only remaining number will be the single element.
// Or, linearly scan checking pairs.

#include <vector>

class Solution {
public:
    int singleNonDuplicate(std::vector<int>& nums) {
        int res = 0;
        for (int num : nums) {
            res ^= num;
        }
        return res;
        // Time: O(N), Space: O(1)
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// left = 0, right = nums.size() - 2 (we want to check pairs, so we don't need to consider the last element as a starting point)
// While left <= right:
//   mid = left + (right - left) / 2
//   If nums[mid] == nums[mid ^ 1]:
//       left = mid + 1 // We are in the left half, single element is to the right
//   Else:
//       right = mid - 1 // Pattern broke, single element is to the left or is mid
// Return nums[left]

#include <vector>

class Solution {
public:
    int singleNonDuplicate(std::vector<int>& nums) {
        int left = 0;
        int right = nums.size() - 2; 
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            // mid ^ 1 will give the index of the pair:
            // if mid is even, mid ^ 1 gives mid + 1
            // if mid is odd, mid ^ 1 gives mid - 1
            if (nums[mid] == nums[mid ^ 1]) {
                // Pair is intact, we are in the left half
                left = mid + 1;
            } else {
                // Pair is broken, we are in the right half (or at the single element)
                right = mid - 1;
            }
        }
                
        return nums[left];
    }
};
```

## Complexity
- **Time Complexity**: `O(log N)` where `N` is the length of the array. The binary search halves the search space each time.
- **Space Complexity**: `O(1)` as we only use pointers.

## Edge Cases
1. **Single element array (`[1]`)**: The bounds `left = 0, right = -1`. The loop is bypassed, `nums[0]` is correctly returned.
2. **Target element at the very end (`[1, 1, 2, 2, 3]`)**: `right` is initially initialized to `nums.size() - 2` (index 3). The binary search will keep moving `left` up to `mid + 1` until `left` becomes index 4. The loop terminates, returning `nums[4]`, which is correct.
3. **Target element at the very beginning (`[1, 2, 2, 3, 3]`)**: The first check `nums[mid] == nums[mid^1]` will fail immediately, `right` will shrink to `-1`, `left` remains `0`. Returns `nums[0]`.

## Notes
- **Recognition**: `O(log n)` required time on a sorted array usually mandates binary search. Finding a single abnormality in pairs implies index parity mapping.
- **Bitwise Trick (`mid ^ 1`)**: This is an extremely elegant trick. It pairs `0-1`, `2-3`, `4-5`, etc. This prevents writing messy nested `if-else` blocks to check if `mid` is even or odd before deciding to check `mid-1` or `mid+1`.
- Another way is to always ensure `mid` is even (`if mid % 2 != 0: mid -= 1`), then compare `nums[mid]` and `nums[mid+1]`. It's logically identical but slightly more verbose.
