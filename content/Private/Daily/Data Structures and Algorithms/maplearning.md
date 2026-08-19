Map in c++ is kind of same as JSON or Dict in Python

_it is a generalised array that consists of key-value pairs_, then what is the difference.
the main difference is that in array, indexing is always fixed (0,1,2,3 .... n-1). but in map, the indexing or key can be of any datatype int,string, char. and inside that key we store our data or value.

#### Unordered and Ordered Map.

- the main difference here also is taht the the ordered map will be using the RED BLACK TREE as its internal structure and only maintains the key and value pairs inside it but in sorted order. the search, insert and delete is in logn
- The unordered map is the same as set.Uses hash table, has complexity of O(1), but data is in random order in memory.

**NOTE**

- in python, if we try to access a key which is not available, then you will be getting an error, but in c++ that is not the case.
- if you give cout<<m[abab]; in the map, even if the key abab does not exist, it will create it itself and insert the default value of int in it(0).

That is why to check presence we use .count(). as [] creates new keys.
like m.count(abab) willcheck whether abab is present in the map or not.

to iterate in map

for (auto x:m){
cout<< m.first<< "/n"« m.second<<"/n";

when we loop a map the map loops through the key and value pair.
.first gives key, .second gives value.
