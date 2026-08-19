---
title: "Two Sum II - Input Array Is Sorted"
link: "https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to find two numbers such that they add up to a specific target number. The array is already sorted in non-decreasing order. We must use O(1) extra space.
Because the array is sorted, we can use the **Two Pointers technique (Opposite Ends)**. We place one pointer at the beginning (smallest element) and one at the end (largest element).
If their sum is too small, we increment the left pointer to increase the sum. If the sum is too large, we decrement the right pointer to decrease the sum.

## Code

### Brute-Force Approach
Check every pair. Time limit exceeded.
```text
Pseudocode:
1. For i from 0 to N-1:
2.   For j from i+1 to N-1:
3.     If nums[i] + nums[j] == target: return [i+1, j+1]
```

### Optimal Approach
Two Pointers.
```text
Pseudocode:
1. `left = 0`, `right = length of numbers - 1`
2. While `left < right`:
3.   `current_sum = numbers[left] + numbers[right]`
4.   If `current_sum == target`: return `[left + 1, right + 1]` (1-indexed)
5.   Else if `current_sum < target`: `left += 1`
6.   Else: `right -= 1`
```

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& numbers, int target) {
        int left = 0;
        int right = numbers.size() - 1;
        
        while (left < right) {
            int current_sum = numbers[left] + numbers[right];
            
            if (current_sum == target) {
                return {left + 1, right + 1};
            } else if (current_sum < target) {
                left++;
            } else {
                right--;
            }
        }
        
        return {};
    }
};
```

## Complexity
- **Time Complexity:** O(N). Each pointer moves at most N times, and they meet in the middle. We do O(1) work per iteration.
- **Space Complexity:** O(1). No extra memory is used other than the two pointers.

## Edge Cases
- **Negative Numbers:** Perfectly handled because sorting properties apply identically across negatives and positives.
- **Target is achieved with first and last element:** Solved on the first loop iteration.

## Notes
**Thought Process & Recognition:**
Whenever you see "sorted array" and you need to find a "pair of elements", the two-pointer technique should be your very first thought. It elegantly narrows down the search space in linear time by leveraging the sorted property.
