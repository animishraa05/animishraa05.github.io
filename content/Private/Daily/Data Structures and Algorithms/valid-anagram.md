---
title: "Valid Anagram"
link: "https://leetcode.com/problems/valid-anagram/"
topic: "Hash Table"
type: problem
created: 2026-07-19
---

## Approach
An anagram is a word or phrase formed by rearranging the letters of a different word or phrase, using all the original letters exactly once.
To check if two strings are valid anagrams, they must have the exact same frequencies of every character. 
We can use a Hash Table (or a fixed-size array of 26 integers since inputs are lowercase English letters) to count the frequencies.

## Code

### Brute-Force Approach
Sort both strings and compare them. If they are equal, they are anagrams.
```text
Pseudocode:
1. If length of s != length of t, return false.
2. Sort s and t.
3. Return s == t.
```

### Optimal Approach
Count frequencies using a vector of size 26.
```text
Pseudocode:
1. If length of s != length of t, return false.
2. Create a vector `count` of 26 zeroes.
3. For each char in `s`, increment `count[char - 'a']`.
4. For each char in `t`, decrement `count[char - 'a']`.
5. If any value in `count` is not 0, return false.
6. Return true.
```

```cpp
class Solution {
public:
    bool isAnagram(string s, string t) {
        if (s.length() != t.length()) {
            return false;
        }
        
        vector<int> count(26, 0);
        
        for (int i = 0; i < s.length(); ++i) {
            count[s[i] - 'a']++;
            count[t[i] - 'a']--;
        }
        
        for (int c : count) {
            if (c != 0) {
                return false;
            }
        }
        
        return true;
    }
};
```

## Complexity
- **Time Complexity:** O(N), where N is the length of the string. We iterate through the strings once and then through the fixed-size array of 26 elements.
- **Space Complexity:** O(1), since the size of the count array is fixed at 26, independent of the input size.

## Edge Cases
- **Different lengths:** Instantly caught by the `s.length() != t.length()` check.
- **Unicode characters:** If the input allows unicode, we must use an `unordered_map` instead of an array of size 26.

## Notes
**Thought Process & Recognition:**
Whenever asked to compare the "composition" of two strings disregarding order, character counting is the go-to strategy. Using a fixed-size array is a micro-optimization over hash maps for fixed alphabets (like lowercase a-z).
