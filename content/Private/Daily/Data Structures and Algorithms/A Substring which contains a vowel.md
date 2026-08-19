#### main stuff
The main stuff I saw when I first saw this problem was about substring, So when I saw this at first glance, it gave away sliding window as it had substring(continous part of array), it had several other giveaways like we have to find the maximum one possible in a window of size k. 


brute force was pretty obvious
- We make 2 loops , first one goes for iteration and second one for window
- i = 1 to n first and second from j = i to k(or given window).
- we can compare whether the given val is aeiou, and then compare with max of taking a maxi as int_min.

IN OPTIMAL THO
- a straight forward sliding window will take place, where we will first take two pointers i and j
- we will start j with 1st value as while j not equal to size of string, 
- then do j++ when j < k. also do compare it wit aeiou until it becomes size.

in the next step when It becomes size, we calculate maxisame as brute force and then slide the window,

*while thinking about that one thing to remember*
is that i has to be seen whether it was aeiou or not as if it was not we dont need to think about it.
So we compare again and then do j++ and i++. 

the TC of both are On^2 amd On respectively.













