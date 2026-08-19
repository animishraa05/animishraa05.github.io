_basically have to tell whether a string is palindrome or not_

#### Brute Force

- The most obvious solution would be to reverse the string entirely and then compare it with first string char by char.
- if it matches then we return true otherwise false.

But the issue is that in the large inputs at like a sentences with 100000 words, it would be very very big to be able to do it.

##### optimal approach

An optimal approach would be to think about the two pointers, and also when valid palindrome always think about this only.

The pointer will be like this,

pseudocode

make two pointers
while l < r

then we compare each character at left with each character at right
if they are equal we will continue
and keep comparing,
if not just return -1.

if coming out of loop, means all were equal and left crossed right **basically meaning that we covered the entire area, so we will put true.**
