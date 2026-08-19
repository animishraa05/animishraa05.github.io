---
title: "Sort an array using recursion"
link: ""
topic: "recursion"
type: problem
created: 2026-07-19
---

## Approach
Sorting an array entirely using recursion is an excellent exercise in understanding recursive leaps of faith. The core idea is to reduce the problem size: to sort an array of size `N`, we can recursively sort the array of size `N-1`. Once the `N-1` elements are sorted, our task reduces to **inserting** the `N`th element into its correct position within the already sorted `N-1` elements. 

This requires two recursive functions:
1. `sortArray()`: Reduces the array size by removing the last element, recursively calls itself to sort the remaining array, and then calls `insert()`.
2. `insert()`: Takes a sorted array and an element. If the array is empty or the last element is smaller than or equal to the element to insert, we simply append it. Otherwise, we remove the last element, recursively call `insert()`, and then put the removed element back.

## Code
### Approach
```cpp
// Pseudocode for Sort:
// If array is size 1 or empty, return.
// Pop the last element `temp`.
// Recursively call sortArray(array).
// Call insert(array, temp).

// Pseudocode for Insert:
// If array is empty or last element <= temp, append `temp` and return.
// Pop the last element `val`.
// Recursively call insert(array, temp).
// Append `val` back.

#include <vector>

using namespace std;

class Solution {
public:
    void insert(vector<int>& arr, int temp) {
        // Base case: if array is empty or the last element is smaller/equal
        if (arr.empty() || arr.back() <= temp) {
            arr.push_back(temp);
            return;
        }
        
        // Hypothesis: remove the larger element
        int val = arr.back();
        arr.pop_back();
        
        // Induction: insert the temp in the remaining sorted array
        insert(arr, temp);
        
        // Re-add the removed element
        arr.push_back(val);
    }

    void sortArray(vector<int>& arr) {
        // Base case
        if (arr.size() <= 1) {
            return;
        }
        
        // Hypothesis: remove last element
        int temp = arr.back();
        arr.pop_back();
        
        // Recursively sort the remaining array
        sortArray(arr);
        
        // Induction: insert the element in the sorted array
        insert(arr, temp);
    }
};
```

## Complexity
- **Time Complexity:** $O(N^2)$. The `sortArray` function is called $N$ times. For each call, `insert` is called. In the worst case (e.g., array sorted in reverse order), `insert` removes all elements one by one, taking $O(N)$ time per call. Thus, $O(N) \times O(N) = O(N^2)$.
- **Space Complexity:** $O(N)$ auxiliary space. This is due to the recursion stack. `sortArray` uses $O(N)$ stack frames, and `insert` can also use up to $O(N)$ stack frames at each step.

## Edge Cases
1. **Empty Array:** The base case `arr.size() <= 1` correctly handles an empty array by returning immediately.
2. **Already Sorted Array:** The `insert` function will hit its base case `arr.back() <= temp` immediately, making it $O(1)$ for insertion, but `sortArray` still does $O(N)$ calls. Total time becomes $O(N)$.
3. **Reverse Sorted Array:** This triggers the worst-case time complexity $O(N^2)$.
4. **Duplicate Elements:** `arr.back() <= temp` handles duplicates gracefully, maintaining a stable relative order.

## Notes
- **Thought Process & Recognition:** This pattern is explicitly about Base Condition, Hypothesis, and Induction (BHI).
  - **Hypothesis:** Assume `sortArray` up to the second-to-last element works perfectly.
  - **Induction Step:** How do we make the whole array sorted if the remaining elements are sorted? We just insert the last element in its correct place.
- **Mental Model:** Imagine holding a deck of cards. You take the top card off and ask a friend to magically sort the rest of the deck. When they hand it back sorted, you figure out where to insert your single card. But since you can only access the cards one by one from the top, you pull cards off the sorted deck until you find the right spot, put your card in, and then put the pulled cards back.
