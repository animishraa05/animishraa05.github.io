---
title: "Maximum Product Subarray"
link: "https://leetcode.com/problems/maximum-product-subarray/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use Dynamic Programming or an iterative approach tracking both the maximum and minimum products up to the current element. Because a negative number can turn a large negative product into a large positive one, we must keep track of the minimum (most negative) product as well as the maximum product at each step.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Check every possible subarray product.
// 1. Initialize max_prod = INT_MIN.
// 2. For i from 0 to n-1:
// 3.   curr_prod = 1
// 4.   For j from i to n-1:
// 5.     curr_prod *= nums[j]
// 6.     max_prod = max(max_prod, curr_prod)
// 7. Return max_prod.

class Solution {
public:
    int maxProduct(vector<int>& nums) {
        int res = INT_MIN;
        for (int i = 0; i < nums.size(); ++i) {
            int curr = 1;
            for (int j = i; j < nums.size(); ++j) {
                curr *= nums[j];
                res = max(res, curr);
            }
        }
        return res;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode: 
// 1. Initialize res = max element in nums, curMin = 1, curMax = 1.
// 2. Iterate through each n in nums.
// 3. If n == 0, reset curMin = 1, curMax = 1.
// 4. Calculate tmp = curMax * n.
// 5. curMax = max({n * curMax, n * curMin, n}).
// 6. curMin = min({tmp, n * curMin, n}).
// 7. res = max(res, curMax).
// 8. Return res.

class Solution {
public:
    int maxProduct(vector<int>& nums) {
        int res = *max_element(nums.begin(), nums.end());
        int curMin = 1, curMax = 1;
        for (int n : nums) {
            if (n == 0) {
                curMin = 1;
                curMax = 1;
                continue;
            }
            int tmp = curMax * n;
            curMax = max({n * curMax, n * curMin, n});
            curMin = min({tmp, n * curMin, n});
            res = max(res, curMax);
        }
        return res;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) as we loop through the array once. Space: O(1) as we only use a few variables.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Array contains zeroes. Zeroes reset the product. Handled by resetting curMax and curMin to 1.
2. Array has only negative numbers. We need to return the max negative number, which works since we take `max(n)` initially.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
Always track the minimum product when dealing with array products with negative numbers. A large negative number multiplied by another negative number becomes a large positive number.
