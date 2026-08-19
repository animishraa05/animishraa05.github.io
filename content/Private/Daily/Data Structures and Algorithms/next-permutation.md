---
title: "Next Permutation"
link: "https://leetcode.com/problems/next-permutation/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem requires us to find the next lexicographically greater permutation of an array of numbers. If no such arrangement is possible (it's sorted in descending order), we must rearrange it to the lowest possible order (ascending).
**Pattern:** Math/Sequence Traversal from Right to Left.

To find the *next* greater permutation, we want to increase the sequence as little as possible. 
Consider how numbers work: 123 -> 132. We changed the rightmost digits. 
If a sequence is sorted in descending order (e.g., 3, 2, 1), no larger permutation is possible. 
Therefore, we must find the first pair of two successive numbers `a[i]` and `a[i-1]` from the right, which satisfy `a[i-1] < a[i]`. This `a[i-1]` is the pivot that needs to be replaced to make the sequence larger.

Once we find this pivot `a[i-1]`:
1. We need to replace it with the next largest number to its right. We scan from the right again to find the first number `a[j]` that is greater than `a[i-1]`.
2. We swap `a[i-1]` and `a[j]`.
3. Now, to ensure the new permutation is as small as possible, we must reverse the sub-array to the right of `i-1` (from `i` to the end). Since it was previously in descending order, reversing it puts it in ascending order, giving the smallest possible sequence for that right half.

## Code

### Brute-Force Approach
A brute force approach would involve generating all possible permutations of the array, sorting them lexicographically, finding the given array, and then picking the next one.
Time complexity would be $O(N!)$, which is completely infeasible.

### Optimal Approach (Linear Scan)
Pseudocode:
1. Initialize `i = nums.size() - 2`.
2. Find the first decreasing element from the right:
   While `i >= 0` and `nums[i] >= nums[i+1]`, decrement `i`.
3. If `i >= 0` (we found a pivot):
   - Initialize `j = nums.size() - 1`.
   - Find the first element from the right strictly greater than `nums[i]`:
     While `nums[j] <= nums[i]`, decrement `j`.
   - Swap `nums[i]` and `nums[j]`.
4. Reverse the subarray from `i + 1` to the end.

```cpp
class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        // Step 1: Find the pivot (first element from right that is smaller than its neighbor)
        int i = nums.size() - 2;
        while (i >= 0 && nums[i] >= nums[i + 1]) {
            i--;
        }
            
        // Step 2: If pivot found, find the swap candidate and swap
        if (i >= 0) {
            int j = nums.size() - 1;
            while (nums[j] <= nums[i]) {
                j--;
            }
            swap(nums[i], nums[j]);
        }
            
        // Step 3: Reverse the elements to the right of the pivot
        reverse(nums.begin() + i + 1, nums.end());
    }
};
```

## Complexity
- **Time:** $O(N)$. In the worst case, we scan down the array a couple of times (once to find the pivot, once to find the swap candidate, and once to reverse the suffix). This is strictly linear time.
- **Space:** $O(1)$. All operations, including swapping and reversing, are done in-place.

## Edge Cases
- **Entirely descending array:** `[3, 2, 1]`. Step 1 will run until `i = -1`. The `if (i >= 0)` check fails, meaning no swap happens. Step 3 reverses the entire array to `[1, 2, 3]`, correctly returning the lowest possible order.
- **Array with duplicates:** `[1, 5, 1]`. The algorithm correctly handles this by using `>=` and `<=` during the scans, ensuring it skips over exact identical values to find strictly greater/lesser values for swaps.
- **Array of length 1 or 0:** The initial `i` is set to `< 0`, bypassing the `if` and the `reverse` handles it trivially.

## Notes
**Thought Process & Recognition:** 
This is a mathematically specific algorithm that is hard to intuitively derive during an interview unless you've seen it before. 
To memorize it, visualize a graph of the array's values. You are looking from right to left for the first "dip". Everything to the right of this dip is a descending slope. 
To make the number *just slightly* bigger, you swap the dip with the smallest value on the slope that is still taller than the dip. 
After the swap, the slope is still descending, so to minimize the new number, you simply reverse the slope to make it ascending.
