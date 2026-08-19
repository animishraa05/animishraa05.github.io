---
title: "Find Minimum in Rotated Sorted Array"
link: "https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use Binary Search to find the minimum element in O(log n) time. The array is sorted but rotated. The key observation is that if we look at the middle element, it will be part of either the left sorted portion or the right sorted portion. We want to find the inflection point where the rotation happens. If nums[mid] > nums[right], it means the minimum must be to the right of mid. Otherwise, it is at mid or to the left of mid.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Linearly scan the array and keep track of the minimum.
// 1. Initialize min_val to the first element.
// 2. Iterate through each number in nums.
// 3. Update min_val = min(min_val, num).
// 4. Return min_val.

class Solution {
public:
    int findMin(vector<int>& nums) {
        int res = nums[0];
        for (int n : nums) {
            res = min(res, n);
        }
        return res;
    }
};
```

### Optimal Approach (Binary Search)
```cpp
// Pseudocode: 
// 1. Initialize left = 0, right = nums.size() - 1.
// 2. Loop while left < right.
// 3. Calculate mid = left + (right - left) / 2.
// 4. If nums[mid] > nums[right], the minimum is in the right half (left = mid + 1).
// 5. Else, the minimum is in the left half including mid (right = mid).
// 6. Return nums[left].

class Solution {
public:
    int findMin(vector<int>& nums) {
        int l = 0, r = nums.size() - 1;
        while (l < r) {
            int mid = l + (r - l) / 2;
            if (nums[mid] > nums[r]) {
                l = mid + 1;
            } else {
                r = mid;
            }
        }
        return nums[l];
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(log n) because we are cutting the search space in half at each step using binary search. Space: O(1) because we only use two pointers.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Array is not rotated (e.g., [1, 2, 3, 4, 5]). Handled correctly as nums[mid] will always be < nums[right].
2. Array has 1 or 2 elements. Handled correctly.
3. All elements are the same or duplicate elements exist? This problem states all elements are unique.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
When dealing with rotated sorted arrays, always think of binary search. Compare `mid` with `right` to determine which half is sorted and where the inflection point lies. If `nums[mid] > nums[right]`, the right side contains the drop.
