---
title: "Longest Consecutive Sequence"
link: "https://leetcode.com/problems/longest-consecutive-sequence/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use a Hash Set. We add all elements to a set for O(1) lookups. Then, we iterate through the set. We only start building a sequence if the current number is the start of a sequence (i.e., num - 1 is not in the set). This avoids redundant work.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Sort the array and find the longest adjacent sequence.
// 1. Sort the array. Time: O(n log n).
// 2. Iterate and count max consecutive elements.

class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        if (nums.empty()) return 0;
        sort(nums.begin(), nums.end());
        int res = 1;
        int curr = 1;
        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] != nums[i-1]) {
                if (nums[i] == nums[i-1] + 1) {
                    curr++;
                } else {
                    res = max(res, curr);
                    curr = 1;
                }
            }
        }
        return max(res, curr);
    }
};
```

### Optimal Approach
```cpp
// Pseudocode: 
// 1. Convert nums to an unordered_set `num_set`.
// 2. Init max_len = 0.
// 3. For n in num_set:
// 4.   If n - 1 not in num_set (it's the start of a sequence):
// 5.     length = 1
// 6.     while n + length in num_set:
// 7.       length += 1
// 8.     max_len = max(max_len, length)
// 9. Return max_len.

class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        unordered_set<int> num_set(nums.begin(), nums.end());
        int max_len = 0;
        
        for (int n : num_set) {
            if (num_set.find(n - 1) == num_set.end()) {
                int length = 1;
                while (num_set.find(n + length) != num_set.end()) {
                    length++;
                }
                max_len = max(max_len, length);
            }
        }
        return max_len;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n). Although there is a nested while loop, it only runs for the start of a sequence, meaning each number is visited at most twice. Space: O(n) for the hash set.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Empty array -> returns 0. 
2. Array with duplicates -> Set handles duplicates automatically.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
This is a classic 'Hash Set' pattern. Identifying the START of a sequence is the core trick. If `n-1` exists, skip `n`.
