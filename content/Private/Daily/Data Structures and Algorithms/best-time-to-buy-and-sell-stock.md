---
title: "Best Time to Buy and Sell Stock"
link: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use a Two Pointer / sliding window approach. We want to find a maximum difference where the smaller number comes before the larger number. We keep track of the minimum price seen so far and calculate the potential profit if we sold at the current price.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Try every pair of buy and sell days.
// 1. Init max_profit = 0.
// 2. For i from 0 to n-1:
// 3.   For j from i+1 to n-1:
// 4.     max_profit = max(max_profit, prices[j] - prices[i])

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int max_profit = 0;
        for (int i = 0; i < prices.size(); i++) {
            for (int j = i + 1; j < prices.size(); j++) {
                max_profit = max(max_profit, prices[j] - prices[i]);
            }
        }
        return max_profit;
    }
};
```

### Optimal Approach (One Pass)
```cpp
// Pseudocode: 
// 1. Init min_price = INT_MAX, max_profit = 0.
// 2. For each price in prices:
// 3.   min_price = min(min_price, price)
// 4.   max_profit = max(max_profit, price - min_price)
// 5. Return max_profit.

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int min_price = INT_MAX;
        int max_profit = 0;
        
        for (int price : prices) {
            if (price < min_price) {
                min_price = price;
            } else if (price - min_price > max_profit) {
                max_profit = price - min_price;
            }
        }
        return max_profit;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) because we pass through the array once. Space: O(1) as we only use two variables.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Array is in descending order. Minimum price is constantly updated, but `price - min_price` is never positive. Returns 0.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
This is a classic 'minimum so far' pattern. Whenever you need to find a maximum difference with a temporal ordering (buy before sell), tracking the minimum value seen so far is often the key.
