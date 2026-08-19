---
title: "Remove Duplicates from Sorted Array"
link: "https://leetcode.com/problems/remove-duplicates-from-sorted-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem requires modifying an array in-place such that each unique element appears only once, returning the new length.
**Pattern:** Two Pointers (Slow/Fast).

Since the array is sorted, we know that all duplicate elements will be adjacent to each other. 
We can solve this effectively using the **Two Pointers** technique. 
- One pointer (`slow` or `insertIndex`) tracks the position where the next unique element should be placed.
- The other pointer (`fast` or `i`) iterates through every element in the array.

When the `fast` pointer encounters an element different from the one just placed at the `slow - 1` index, it means we found a new unique element. We copy it to the `slow` index and increment `slow`. 

## Code

### Brute-Force Approach
A naive way would be to create a new array, loop through the original, and add only elements that don't match the last added element. However, the problem explicitly demands $O(1)$ extra memory. Another bad approach would be to use `std::vector::erase()` inside a loop, which shifts elements and causes $O(N^2)$ time complexity.

```cpp
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        // Invalid approach per requirements (uses O(N) space)
        // Or O(N^2) if using std::vector::erase()
        return 0; 
    }
};
```

### Optimal Approach (Fast/Slow Pointers)
Pseudocode:
1. Handle edge case: if `nums` is empty, return `0`.
2. Initialize `insertIndex = 1` (the first element is inherently unique).
3. Loop `i` from 1 to `nums.size() - 1`.
4. If `nums[i] != nums[i-1]`, we found a new unique element.
   - Set `nums[insertIndex] = nums[i]`.
   - Increment `insertIndex`.
5. Return `insertIndex`.

```cpp
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }
            
        int insertIndex = 1;
        
        for (int i = 1; i < nums.size(); ++i) {
            // If the current element is different from the previous one
            if (nums[i] != nums[i - 1]) {
                nums[insertIndex] = nums[i];
                insertIndex++;
            }
        }
                
        return insertIndex;
    }
};
```

## Complexity
- **Time:** $O(N)$. We iterate through the array of length $N$ exactly once with the fast pointer `i`.
- **Space:** $O(1)$. We are modifying the array strictly in-place and using only a single extra integer variable `insertIndex`.

## Edge Cases
- **Empty Array:** `nums = []`. The `if (nums.empty())` explicitly catches this, though LeetCode constraints guarantee `nums.size() >= 1`.
- **All duplicates:** `[1, 1, 1, 1]`. `nums[i] != nums[i-1]` is never met. Loop finishes, returns 1. The first element remains `1`. Correct.
- **No duplicates:** `[1, 2, 3, 4]`. `nums[i] != nums[i-1]` is always met. The elements are effectively overwritten with themselves, which is perfectly safe and returns length 4.

## Notes
**Thought Process & Recognition:** 
The keywords "Sorted Array", "In-place", and "Duplicates" heavily signal the Fast/Slow Two Pointers approach. 
Because it's sorted, you never need a hash map to look up if you've seen an element before—you only ever need to look at the element immediately prior (`nums[i-1]`).

**Mental Model:** Imagine a line of people organized by height. You want a line where every height is unique. You walk down the line (fast pointer). If the person you are looking at is the same height as the person behind them, you ignore them. If they are a new height, you pull them forward to the front of the line (slow pointer).
