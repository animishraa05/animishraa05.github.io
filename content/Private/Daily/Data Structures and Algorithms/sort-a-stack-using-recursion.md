---
title: "sort a stack using recursion"
link: ""
topic: "recursion"
type: problem
created: 2026-07-19
---

## Approach

Sorting a stack using recursion is structurally identical to sorting an array using recursion. The fundamental constraint here is that we cannot use any looping constructs (`for`, `while`) or extra data structures (like arrays or queues) directly; we can only use recursion stack frames and standard stack operations (`push`, `pop`, `top`/`peek`, `empty`).

The approach uses two recursive functions:

1. `sortStack()`: Pops the top element of the stack, recursively sorts the remaining stack, and then calls `insert_in_sorted_stack()`.
2. `insert_in_sorted_stack()`: Takes a sorted stack and an element. If the stack is empty or the top element is smaller than the element to insert, it pushes the element onto the stack. Otherwise, it pops the top element, recursively calls `insert_in_sorted_stack()`, and pushes the popped element back.

## Code

### Optimal Approach

```cpp
// Pseudocode for Sort:
// If stack is empty, return.
// temp = stack.top()
// stack.pop()
// sortStack(stack)
// insert_in_sorted_stack(stack, temp)

// Pseudocode for Insert:
// If stack is empty OR top of stack <= temp:
//   stack.push(temp)
//   return
// val = stack.top()
// stack.pop()
// insert_in_sorted_stack(stack, temp)
// stack.push(val)

#include <stack>

using namespace std;

class Solution {
public:
    void insert_in_sorted_stack(stack<int>& st, int temp) {
        // Base case: if stack is empty or top element is less than or equal to temp
        if (st.empty() || st.top() <= temp) {
            st.push(temp);
            return;
        }

        // Hypothesis: pop the larger element
        int val = st.top();
        st.pop();

        // Induction: insert the target element recursively
        insert_in_sorted_stack(st, temp);

        // Put back the popped element
        st.push(val);
    }

    void sortStack(stack<int>& st) {
        // Base case
        if (st.empty()) {
            return;
        }

        // Hypothesis: remove the top element
        int temp = st.top();
        st.pop();

        // Recursively sort the remaining stack
        sortStack(st);

        // Induction: insert the element back in sorted order
        insert_in_sorted_stack(st, temp);
    }
};
```

## Complexity

- **Time Complexity:** $O(N^2)$. The `sortStack` function pops $N$ elements, calling itself $N$ times. For each element popped, `insert_in_sorted_stack` could potentially pop all elements currently in the sorted portion of the stack. This leads to the sum of first $N$ integers: $N + (N-1) + (N-2) ... = O(N^2)$.
- **Space Complexity:** $O(N)$. The implicit call stack uses memory. In the worst case, `sortStack` will reach a depth of $N$, and `insert_in_sorted_stack` will also reach a depth of $N$. Thus, the maximum depth of the call stack at any point is $O(N)$.

## Edge Cases

1. **Empty Stack:** `if (st.empty())` handles it gracefully.
2. **Single Element Stack:** Recursion hits the base case immediately.
3. **Already Sorted Stack:** `insert_in_sorted_stack` will resolve in $O(1)$ time per element, bringing the overall time complexity to $O(N)$.
4. **Reverse Sorted Stack:** Generates the worst-case $O(N^2)$ time complexity.

## Notes

- **Thought Process & Recognition:** Whenever a problem asks to manipulate a stack without using loops or auxiliary data structures, recursion is almost always the intended solution. The recursion stack acts as the auxiliary data structure.
- **Mental Model:** Treat recursion as a "trusted black box" (Hypothesis). If I take the top element off, I trust that the `sortStack` function will correctly sort the rest of the stack. Once it does, my only job is to figure out how to put my single element into that sorted stack. That second step (Insertion) is a smaller subproblem of the exact same type: "take the top off, trust the black box, put the top back."
