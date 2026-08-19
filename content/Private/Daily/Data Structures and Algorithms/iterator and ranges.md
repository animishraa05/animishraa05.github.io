_iterator is a variable that points to an element in data structure._
Like it was made thinking the difference between why the traversing should be different in array or tree, so they made an interface which is universal.

this iterator just asks what data point I am on right now and what is the next data point.

there is begin and end

- begin()- will always point to the first element of the data structure,
- end()- will always point next to the element which is last. Means outside the structure
  why so - the looping becomes very easy, we can say iterate until iterator == end(). and also the base case or condition where array is empty is O(1), s.begin == s.end

In the normal static array, we do not have c++ stl. So what to do, there we can use the STL function like sort reverse and other using pointer. here if we have a[5], in c++ **the name of array is the memory address of first pointer** so we will be using sort(a) here a is like begin() and to get the last element or end( one more than last) add the +N or (a+n) to get the end().

Eg- a[6]= {1,4,5,6,7,45,3};
sort(a, a+n); and this will sort a.begin to end

### Set iterators
