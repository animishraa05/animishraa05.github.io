---
title: "Remove Element"
link: "https://leetcode.com/problems/remove-element/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The task is to remove all occurrences of a specific `val` in an array in-place and return the new length. The order of elements can be changed.
**Pattern:** Two Pointers (Slow/Fast).

This is incredibly similar to "Remove Duplicates from Sorted Array". 
We maintain a `slow` pointer (let's call it `k`) that points to the index where the next valid (non-`val`) element should be placed.
We use a `fast` pointer `i` to iterate through all elements.
If `nums[i]` is not equal to `val`, it is a "keeper". We place it at `nums[k]` and increment `k`. 

*Alternative Approach:* Because the problem explicitly states "the order of elements can be changed", if the array has very few elements to remove, we can optimize by swapping the element to be removed with the *last* element in the array, reducing unnecessary copy operations.

## Code

### Standard Optimal Approach (Fast/Slow Pointers)
Pseudocode:
1. Initialize `k = 0`.
2. Loop `i` from 0 to `nums.size() - 1`.
3. If `nums[i] != val`:
   - Set `nums[k] = nums[i]`.
   - Increment `k`.
4. Return `k`.

```cpp
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int k = 0;
        
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] != val) {
                nums[k] = nums[i];
                k++;
            }
        }
                
        return k;
    }
};
```

### Alternative Optimal Approach (Two Pointers - Swap from end)
Pseudocode:
1. Initialize `left = 0`, `right = nums.size()`.
2. Loop while `left < right`:
   - If `nums[left] == val`:
     - Swap `nums[left]` with `nums[right - 1]`.
     - Decrement `right`. (Don't increment `left` yet, we need to check the newly swapped element).
   - Else:
     - Increment `left`.
3. Return `left`.

```cpp
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int left = 0;
        int right = nums.size();
        
        while (left < right) {
            if (nums[left] == val) {
                nums[left] = nums[right - 1];
                right--;
            } else {
                left++;
            }
        }
                
        return left;
    }
};
```

## Complexity
- **Time:** $O(N)$. Both approaches traverse the array at most once.
- **Space:** $O(1)$. Modifying in-place requires no extra space.

## Edge Cases
- **Array full of `val`:** `nums = [2, 2, 2], val = 2`. The standard approach never enters the `if`, returning `k = 0`. The alternative approach swaps all elements backwards, returning `left = 0`. Both correctly result in a length of 0.
- **`val` not in array:** `nums = [1, 3, 4], val = 2`. Standard approach assigns elements to themselves, `k` reaches length of array.
- **Empty array:** Readily handled; loop condition fails instantly, returns 0.

## Notes
**Thought Process & Recognition:** 
In-place removal of elements based on a condition almost always demands Two Pointers. 
The standard `k` pointer method is best when you want to preserve the relative order of the remaining elements. 
The swapping method is best when relative order doesn't matter and you want to minimize write operations (e.g., an array of 10,000 elements where only the first element needs to be removed). 

**Mental Model:** Think of the array as two zones: the "clean" zone at the front and the "unprocessed" zone at the back. The `slow` pointer acts as a wall separating the clean zone from the rest. You inspect every item, and if it's clean, you toss it over the wall into the clean zone and push the wall forward.
