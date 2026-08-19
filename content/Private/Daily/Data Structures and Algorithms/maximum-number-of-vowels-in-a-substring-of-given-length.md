---
title: "Maximum Number of Vowels in a Substring of Given Length"
link: "https://leetcode.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length/"
topic: "String"
type: problem
created: 2026-07-19
---

## Approach
This problem asks us to find the maximum number of vowels in any substring of a fixed length `k`. This is a classic **Fixed-Size Sliding Window** problem. 

Instead of re-evaluating all `k` characters for every substring (Brute Force), we evaluate the first window of size `k`. Then, we slide the window one character at a time. When the window slides right, one character enters the window and one character leaves. If the entering character is a vowel, we increment our vowel count. If the leaving character is a vowel, we decrement our count. This brings the work done per window shift from $O(K)$ down to $O(1)$.

## Code
### Brute Force
```cpp
// Pseudocode:
// max_vowels = 0
// For i from 0 to len(s) - k:
//   substring = s[i:i+k]
//   count vowels in substring
//   max_vowels = max(max_vowels, count)
// Return max_vowels

#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxVowels_brute(string s, int k) {
        auto isVowel = [](char c) {
            return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
        };
        int max_v = 0;
        for (int i = 0; i <= (int)s.length() - k; i++) {
            int current_v = 0;
            for (int j = i; j < i + k; j++) {
                if (isVowel(s[j])) {
                    current_v++;
                }
            }
            max_v = max(max_v, current_v);
        }
        return max_v;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// Initialize vowels checker
// Initialize current_vowels = 0
// For i from 0 to k-1:
//   if s[i] is vowel: current_vowels += 1
// max_vowels = current_vowels
// For i from k to len(s) - 1:
//   if s[i] is vowel: current_vowels += 1
//   if s[i - k] is vowel: current_vowels -= 1
//   max_vowels = max(max_vowels, current_vowels)
// Return max_vowels

#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxVowels(string s, int k) {
        auto isVowel = [](char c) {
            return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
        };
        
        int max_v = 0;
        int current_v = 0;
        
        // Process the first window
        for (int i = 0; i < k; i++) {
            if (isVowel(s[i])) {
                current_v++;
            }
        }
        
        max_v = current_v;
        
        // Slide the window
        for (int i = k; i < s.length(); i++) {
            // Add new character to window
            if (isVowel(s[i])) {
                current_v++;
            }
            
            // Remove old character from window
            if (isVowel(s[i - k])) {
                current_v--;
            }
            
            max_v = max(max_v, current_v);
            
            // Optimization: If max_v hits k, we can return early
            if (max_v == k) {
                return k;
            }
        }
        
        return max_v;
    }
};
```

## Complexity
- **Time Complexity:** $O(N)$, where $N$ is the length of string `s`. We traverse the string exactly once. Checking if a character is a vowel using a helper function is $O(1)$.
- **Space Complexity:** $O(1)$. We use a few integer variables and no extra auxiliary space.

## Edge Cases
1. **No vowels in string:** E.g., `s = "xyz"`. The count remains 0 throughout. Correct.
2. **All vowels in string:** E.g., `s = "aeiou", k=3`. Returns `k`. The early exit optimization `max_v == k` immediately cuts down execution time.
3. **`k` equals `s.length()`:** The first loop processes the entire string, the second loop is skipped, and it correctly returns the total vowel count.

## Notes
- **Thought Process & Recognition:** "Fixed length `k`" + "substring" = Fixed Sliding Window. Always. The template is: compute state for first `k` elements, then loop from `k` to $N$, adding the new element and removing the `i-k`th element.
- **Mental Model:** Think of a physical moving frame of width `k` placed over the string. As it shifts right by one slot, the bulk of what's inside the frame stays the same. The only changes happen at the edges: the new character sliding in, and the old one sliding out. Update your running total based *only* on these two edge characters.
