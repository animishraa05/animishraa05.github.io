---
title: "Valid Palindrome"
link: "https://leetcode.com/problems/valid-palindrome/"
topic: "Two Pointers"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use Two Pointers starting from both ends of the string. We skip non-alphanumeric characters and compare the characters (case-insensitive). If they mismatch, it's not a palindrome.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Create a new string with only alphanumeric characters, reversed, and compare.
// 1. Filter string to only lowercased alphanumeric.
// 2. Return filtered == reversed_filtered.

class Solution {
public:
    bool isPalindrome(string s) {
        string filtered = "";
        for (char c : s) {
            if (isalnum(c)) {
                filtered += tolower(c);
            }
        }
        string reversed_filtered = filtered;
        reverse(reversed_filtered.begin(), reversed_filtered.end());
        return filtered == reversed_filtered;
    }
};
```

### Optimal Approach (Two Pointers)
```cpp
// Pseudocode: 
// 1. Init l = 0, r = s.length() - 1.
// 2. Loop while l < r:
// 3.   While l < r and not isalnum(s[l]), l += 1.
// 4.   While l < r and not isalnum(s[r]), r -= 1.
// 5.   If tolower(s[l]) != tolower(s[r]), return False.
// 6.   l += 1, r -= 1.
// 7. Return True.

class Solution {
public:
    bool isPalindrome(string s) {
        int l = 0, r = s.length() - 1;
        
        while (l < r) {
            while (l < r && !isalnum(s[l])) {
                l++;
            }
            while (r > l && !isalnum(s[r])) {
                r--;
            }
            if (tolower(s[l]) != tolower(s[r])) {
                return false;
            }
            l++;
            r--;
        }
        return true;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) because we iterate through the string once. Space: O(1) as we use two pointers instead of creating a new string.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Empty string or string with only spaces/punctuation. Returns True. 
2. Mixed case and numbers. Handled by tolower() and isalnum().

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
Always implement your own `isalnum` logic in interviews to show you understand ASCII values, or at least mention it. Using built-in functions is fine, but knowing the underlying logic is impressive.
