---
title: "Count Good Numbers"
link: "https://leetcode.com/problems/count-good-numbers/"
topic: "Math"
type: problem
created: 2026-07-19
---

## Approach
A "good" number is a string of digits of length `n` where digits at even indices (0, 2, 4...) are even (0, 2, 4, 6, 8) and digits at odd indices (1, 3, 5...) are prime (2, 3, 5, 7). 

There are 5 even digits and 4 prime digits between 0 and 9. 
Thus, for every even index, we have 5 choices, and for every odd index, we have 4 choices.
If `n` is the total length:
- The number of even indices is `ceil(n/2)`.
- The number of odd indices is `floor(n/2)`.
The total number of good numbers is simply `(5 ^ number_of_even_indices) * (4 ^ number_of_odd_indices) % (10^9 + 7)`.

Because `n` can be up to `10^{15}`, a simple loop for exponentiation will result in Time Limit Exceeded (TLE). We must use **Modular Exponentiation** (Fast Exponentiation / Power algorithm) which computes `x^y % p` in `O(\log y)` time.

## Code
### Brute Force
```cpp
// Pseudocode:
// Initialize ans = 1
// For i from 0 to n-1:
//   if i % 2 == 0: ans = (ans * 5) % MOD
//   else: ans = (ans * 4) % MOD
// Return ans
// (Will TLE since n <= 10^15)
```

### Optimal Approach
```cpp
// Pseudocode:
// Calculate even_count = (n + 1) / 2
// Calculate odd_count = n / 2
// Write a helper function power(base, exp) that computes (base^exp) % mod in O(log exp).
// Return (power(5, even_count) * power(4, odd_count)) % MOD

class Solution {
public:
    int MOD = 1e9 + 7;
    
    long long power(long long base, long long exp) {
        long long res = 1;
        base = base % MOD;
        while (exp > 0) {
            if (exp % 2 == 1) { // if exponent is odd
                res = (res * base) % MOD;
            }
            // Square the base and halve the exponent
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    int countGoodNumbers(long long n) {
        long long even_indices = (n + 1) / 2;
        long long odd_indices = n / 2;
        
        long long first_part = power(5, even_indices);
        long long second_part = power(4, odd_indices);
        
        return (first_part * second_part) % MOD;
    }
};
```

## Complexity
- **Time Complexity:** $O(\log N)$. The exponentiation function halves the exponent on each step. We call it twice, so the time is $O(\log(N/2)) + O(\log(N/2))$ which simplifies to $O(\log N)$.
- **Space Complexity:** $O(1)$. We use an iterative approach for the fast exponentiation, utilizing only a few variables, so space is constant. If we used recursive exponentiation, space would be $O(\log N)$ due to the call stack.

## Edge Cases
1. `n = 1`: Length 1. Even index count = 1, Odd index count = 0. Output should be `(5^1) * (4^0) = 5`. The formula `(n + 1) / 2` gives 1 even, `n / 2` gives 0 odd. Handled correctly.
2. Large inputs (`n = 10^{15}`): The fast modular exponentiation easily handles a loop size of ~50 iterations (since $2^{50} > 10^{15}$), completely avoiding TLE.

## Notes
- **Thought Process & Recognition:** Permutation and combination problems with a large upper bound limit ($10^9$ or $10^{15}$) and a modulo requirement are almost always mathematical problems heavily reliant on Fast/Modular Exponentiation. 
- **Mental Model:** Fast Exponentiation works on binary representation of the exponent. To calculate `3^{13}`, since 13 in binary is `1101` (8 + 4 + 1), $3^{13} = 3^8 * 3^4 * 3^1$. By continuously squaring the base ($3^1$, $3^2$, $3^4$, $3^8$), we drastically reduce multiplications. Every time the exponent is odd, we multiply our result by the current base.
