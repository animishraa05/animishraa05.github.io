---
title: "Find All Anagrams in a String"
link: "https://leetcode.com/problems/find-all-anagrams-in-a-string/"
topic: "Hash Table"
type: problem
created: 2026-07-19
---

## Approach
We need to find all starting indices of anagrams of string `p` inside string `s`.
An anagram simply means the frequency of characters is exactly the same, regardless of order.
Because the length of the anagrams must perfectly match the length of `p`, this is a classic **Fixed-Size Sliding Window** problem combined with **Frequency Maps (Hash Tables / Arrays)**.

We first create a frequency map for the string `p`.
Then, we maintain a sliding window of length `len(p)` on string `s`. We keep a frequency map for the characters currently inside our window.
As the window slides one character to the right:
1. We add the new rightmost character to our window's frequency map.
2. We remove the leftmost character (which just left the window) from our frequency map.
3. We compare the window's frequency map to `p`'s frequency map. If they match, the start index of the window is recorded.

Since the alphabet is limited to 26 lowercase English letters, comparing two frequency maps takes `O(26) = O(1)` time. We can use an array of size 26 instead of a hash map for slight performance gains.

## Code
### Brute Force
```cpp
// Pseudocode:
// result = []
// target_count = count_characters(p)
// For i from 0 to s.size() - p.size():
//   substring = s[i : i+p.size()]
//   If count_characters(substring) == target_count:
//       result.push_back(i)
// Return result

#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::vector<int> findAnagrams(std::string s, std::string p) {
        std::vector<int> res;
        if (p.size() > s.size()) return res;
        
        std::string sorted_p = p;
        std::sort(sorted_p.begin(), sorted_p.end());
        
        for (int i = 0; i <= s.size() - p.size(); ++i) {
            std::string window = s.substr(i, p.size());
            std::sort(window.begin(), window.end());
            if (window == sorted_p) {
                res.push_back(i);
            }
        }
        return res;
        // Time: O(N * P log P) where P is length of p. Will likely TLE.
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// If p.size() > s.size(): return []
// p_count = array of 26 zeros, s_count = array of 26 zeros
// Fill initial window for p_count and s_count (first p.size() characters)
// result = []
// If p_count == s_count: result.push_back(0)
// 
// For i from p.size() to s.size() - 1:
//   Add s[i] to s_count
//   Remove s[i - p.size()] from s_count
//   If p_count == s_count:
//       result.push_back(i - p.size() + 1)
// Return result

#include <vector>
#include <string>

class Solution {
public:
    std::vector<int> findAnagrams(std::string s, std::string p) {
        std::vector<int> res;
        if (p.size() > s.size()) return res;
        
        std::vector<int> p_count(26, 0);
        std::vector<int> s_count(26, 0);
        
        // Populate initial window frequencies
        for (int i = 0; i < p.size(); ++i) {
            p_count[p[i] - 'a']++;
            s_count[s[i] - 'a']++;
        }
            
        // Check if the very first window is an anagram
        if (p_count == s_count) {
            res.push_back(0);
        }
            
        // Slide the window
        for (int i = p.size(); i < s.size(); ++i) {
            // Add new character on the right
            s_count[s[i] - 'a']++;
            // Remove character on the left
            int left_char_index = i - p.size();
            s_count[s[left_char_index] - 'a']--;
            
            // Compare maps (O(26) -> O(1))
            if (p_count == s_count) {
                res.push_back(left_char_index + 1);
            }
        }
                
        return res;
    }
};
```

## Complexity
- **Time Complexity**: `O(N)` where `N` is the length of `s`. We iterate through `s` once. The map comparison takes `O(26)`, which simplifies to `O(1)`. Total time is purely linear.
- **Space Complexity**: `O(1)`. We allocate two arrays of size 26. Since the size is strictly bound to the alphabet size regardless of input length, it counts as constant space.

## Edge Cases
1. **`p` is longer than `s`**: An anagram of `p` cannot possibly exist in `s`. The initial check `if len(p) > len(s): return []` handles this gracefully.
2. **Duplicate characters in `p`**: E.g., `p = "aab"`. The frequency counts naturally handle multiples of the same character (`p_count[0] == 2`).
3. **No anagrams exist**: The function simply loops through, finds no matches, and returns an empty list.

## Notes
- **Recognition**: "Substring/Subarray of fixed length" + "permutation/anagram/frequency matching" = Fixed-Size Sliding Window + Frequency Array.
- Using a `std::vector<int>` of size 26 (`vector<int>(26, 0)`) is computationally much faster than instantiating dynamic Hash Maps (`std::unordered_map`), avoiding hashing overhead. `char - 'a'` is the standard trick to map lowercase letters to indices `0-25`.
- C++ `std::vector` supports equality operator (`==`), which makes checking if two arrays of size 26 are equal extremely easy and fast.
