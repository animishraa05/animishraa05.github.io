---
title: "find the middle element of stack and print the stack without it"
link: ""
topic: "Recursion, Stack"
type: problem
created: 2026-07-20
---

you are given a stack where there is a k given, you have to print the stack after removing the element in the middle.

## Approach

we gotta use the IBH approach ,where we will use the following steps
**Hypothesis:**

1. First we will use a function solve and assume that it works and returns the stack without the middle element.
2. Now this element will be size/2 + 1 so if even it will be different and for odd also.
3. then making input smaller, we will call the same for smaller input to get the element but the element to return will be k -1 now.
4. So now we will be calling the function but with different arguments.
   **BaseCase:**
5. If the stack is say 5,4,3,2,1, then k will be 3. and it is 3rd element, but after removing 1 , itll be second element and then 1st . But after that the middle element itself be removed so we can say the smallest valid input for k is 1 and we can pop if k is 1.
6. So the process will be like this, Make a hypothesis true by first removing the function and then calling the function for smaller value and then push it back.

## Code

int solve(int k, stack<int> s){

if (k == 1){
s.pop();
return;
}
int val = s.top();
s.pop();
solve(k-1, s);
s.push(val);
return;
}

## Complexity

## Edge Cases

I in starting thought that if we take the hypothesis that the inpout becomes smaller then wouldnt the mid element change too, but that is not the case. through thinking my solution i was going to assume the base case as size of stack is 0 so that we can just pop the element but I didnt think the middle element will be the same as it was in start. So bc will be k == 1

## Notes
