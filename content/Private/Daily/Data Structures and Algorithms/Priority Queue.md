**Basic priority queue**

Queue Works on FIFo, but priority queue works on priority based numbering.

We saw the set uses balanced binary tree and gives the standard, insertion, deletion and searches in logn time.
then what is the need for priority queue.
Because what pqueue uses is heap DS, which looks like tree but internally stores its data points as vectors, or an continous array. that is why its a lot faster than set.
by default the elements are in max heap meaning the the element on top will be greater than its two child or in anohter words, element in this queue are in decreasing order.

q.push()- pushing any number, heap will balance the entire tree and the complexity will be O(logn)
q.top()- peaking at the highest index which will always be on top. uses O(1).
q.pop()- removing highest element so that the entire heap again fixes itself and second largest comes on top. O(logn)

to make a min heap queue, use a greater int which will flip the logic and comparator will check ulta.
so priority_queue<int, vector<int>, greater<int» q;
