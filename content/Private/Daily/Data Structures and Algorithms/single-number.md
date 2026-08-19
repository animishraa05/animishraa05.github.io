---
title: "Single Number"
link: "https://leetcode.com/problems/single-number/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use XOR bitwise operation. XORing a number by itself results in 0 (A ^ A = 0), and XORing a number with 0 results in the number itself (A ^ 0 = A). Since every element appears twice except for one, XORing all elements together will cancel out the duplicates and leave only the single number.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Use a hash map to count frequencies.
// 1. Initialize a hash map `counts`.
// 2. Iterate through nums and populate counts.
// 3. Iterate through counts and return the key with value 1.

class Solution {
public:
    int singleNumber(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int n : nums) {
            counts[n]++;
        }
        for (auto const& [n, c] : counts) {
            if (c == 1) {
                return n;
            }
        }
        return -1;
    }
};
```

### Optimal Approach (Bit Manipulation)
```cpp
// Pseudocode: 
// 1. Initialize res = 0.
// 2. Iterate through each n in nums.
// 3. res = res ^ n (XOR operation).
// 4. Return res.

class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int res = 0;
        for (int n : nums) {
            res ^= n;
        }
        return res;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) to iterate through the array. Space: O(1) for the optimal XOR approach.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Array of size 1. Loop runs once, returns the element.
2. Negative numbers. XOR works seamlessly with 2's complement negative integers built into C++.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
Whenever you see 'every element appears twice except for one', think XOR. It's the ultimate trick to finding the odd one out without extra space.
