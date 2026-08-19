---
title: "Remove Duplicates from Sorted Array II"
link: "https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The task is to remove duplicates from a sorted array *in-place* such that each unique element appears **at most twice**. We must return the new length of the array, and the relative order of elements must be maintained.

**Why Two Pointers (Slow and Fast)?**
This is an in-place array transformation problem. The "slow and fast pointer" pattern is universally used to overwrite unwanted elements without using extra memory. 
- The `fast` pointer iterates through the array reading elements.
- The `slow` pointer keeps track of where the next valid element should be written.

**The "At Most Twice" Rule:**
Since the array is sorted, duplicates are adjacent. To ensure an element appears at most twice, before we write a new element using the `fast` pointer, we only need to check it against the element located at `slow - 2`. 
- If `nums[fast] == nums[slow - 2]`, it means we already have two copies of this element in our "valid" segment, so we skip it.
- If `nums[fast] != nums[slow - 2]`, it's safe to add `nums[fast]` to our valid segment.

**Specific questions to practice:**
- Remove Duplicates from Sorted Array (at most once)
- Remove Element
- Move Zeroes

## Code

### Brute-Force Approach
Use a hash map to count the frequencies of each element. Iterate through the array, and reconstruct it in-place using the hash map, ensuring no element is written more than twice. 
*Complexity:* $O(n)$ time, $O(n)$ space. Fails the $O(1)$ extra memory constraint.

### Optimal Approach (Two Pointers)

*Pseudocode logic:*
1. If the length of `nums` is less than or equal to 2, return the length (it's inherently valid).
2. Initialize `slow = 2`. This is where we'll place the next valid element. (The first two elements are always valid regardless of their value).
3. Loop `fast` from 2 to the end of the array:
   - If `nums[fast] != nums[slow - 2]`:
     - We write `nums[fast]` into the `slow` position: `nums[slow] = nums[fast]`.
     - Increment `slow`.
4. Return `slow`, which represents the length of the new valid array prefix.

```cpp
class Solution {
public:
    int removeDuplicates(std::vector<int>& nums) {
        // Base case: an array with 2 or fewer elements is always valid
        if (nums.size() <= 2) {
            return nums.size();
        }
            
        // slow pointer indicates the index where the next valid element should go
        int slow = 2;
        
        // fast pointer scans through the array
        for (int fast = 2; fast < nums.size(); ++fast) {
            // If the current element is different from the element two positions back
            // in our valid section, it means we haven't exceeded the quota of 2.
            if (nums[fast] != nums[slow - 2]) {
                nums[slow] = nums[fast];
                slow++;
            }
        }
                
        return slow;
    }
};
```

## Complexity
- **Time Complexity:** $O(n)$. The `fast` pointer iterates through the array exactly once.
- **Space Complexity:** $O(1)$. We are modifying the array in-place and only using two integer variables.

## Edge Cases
- **Array with 0, 1, or 2 elements:** Handled automatically by the base case `if (nums.size() <= 2)`.
- **All elements are the same (e.g., `[1, 1, 1, 1, 1]`):** `nums[fast]` will always equal `nums[slow-2]` (which is `nums[0]`), so `slow` remains at 2. The result length is 2, modifying it to `[1, 1, ...]`.
- **No duplicates at all (e.g., `[1, 2, 3, 4]`):** `nums[fast]` will never equal `nums[slow-2]`, so `slow` increments with `fast`, and the array is untouched.

## Notes
- **Recognition:** "In-place modification" + "Array" usually implies Two Pointers. When limiting frequency to $k$ in a sorted array, compare the current candidate element with the element at `slow - k`.
- **Generalization:** This pattern scales! If the problem asked for "at most $k$ duplicates", you would simply set `slow = k`, start `fast` at `k`, and check `if (nums[fast] != nums[slow - k])`. This is a highly robust and elegant mental model for all "remove duplicates" problems.
