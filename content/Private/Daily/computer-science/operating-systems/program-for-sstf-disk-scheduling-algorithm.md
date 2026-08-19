---
title: "Program for SSTF Disk Scheduling Algorithm"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Program for SSTF Disk Scheduling Algorithm
Given an array of disk track numbers and initial head position, our task is to find the total number of seek operations done to access all the requested tracks if Shortest Seek Time First (SSTF) is a disk scheduling algorithm is used.

The basic idea is the tracks that are closer to the current disk head position should be serviced first in order to minimize the seek operations is basically known as Shortest Seek Time First (SSTF).

## Advantages of Shortest Seek Time First (SSTF)

- Better performance than the FCFS scheduling algorithm.
- It provides better throughput.
- This algorithm is used in Batch Processing systems where throughput is more important.
- It has a less average response and waiting time.

## Disadvantages of Shortest Seek Time First (SSTF)

- Starvation is possible for some requests as it favours easy-to-reach requests and ignores the far-away processes.
- There is a lack of predictability because of the high variance of response time.
- Switching direction slows things down.

## Algorithm

Step 1: Let the Request array represents an array storing indexes of tracks that have been requested. 'head' is the position of the disk head.

Step 2: Find the positive distance of all tracks in the request array from the head.

Step 3: Find a track from the requested array which has not been accessed/serviced yet and has a minimum distance from the head.

Step 4: Increment the total seek count with this distance.

Step 5: Currently serviced track position now becomes the new head position.

Step 6: Go to step 2 until all tracks in the request array have not been serviced.

Example:

Request sequence = {176, 79, 34, 60, 92, 11, 41, 114} Initial head position = 50

The following chart shows the sequence in which requested tracks are serviced using SSTF.

Therefore, the total seek count is calculated as:

![SSTF (Shortest Seek Time First)](images_sstf-shortest-seek-time-first.png)

```
= (50-41)+(41-34)+(34-11)+(60-11)+(79-60)+(92-79)+(114-92)+(176-114)= 204which can also be directly calculated as: (50-11) + (176-11)
```

## Implementation

The implementation of SSTF is given below. Note that we have made a node class having 2 members. ‘distance’ is used to store the distance between the head and the track position. ‘accessed’ is a boolean variable that tells whether the track has been accessed/serviced before by the disk head or not.

```
// C++ program for implementation of 
// SSTF disk scheduling
# include <bits/stdc++.h>
using namespace std;

// Calculates difference of each  
// track number with the head position 
void calculatedifference(int request[], int head,
                         int diff[][2], int n)
{
    for(int i = 0; i < n; i++)
    {
        diff[i][0] = abs(head - request[i]);
    }
}

// Find unaccessed track which is 
// at minimum distance from head 
int findMIN(int diff[][2], int n)
{
    int index = -1;
    int minimum = 1e9;
  
    for(int i = 0; i < n; i++)
    {
        if (!diff[i][1] && minimum > diff[i][0])
        {
            minimum = diff[i][0];
            index = i;
        }
    }
    return index;
}

void shortestSeekTimeFirst(int request[], 
                           int head, int n)
{
    if (n == 0)
    {
        return;
    }
    
    // Create array of objects of class node    
    int diff[n][2] = { { 0, 0 } };
    
    // Count total number of seek operation   
    int seekcount = 0;
    
    // Stores sequence in which disk access is done 
    int seeksequence[n + 1] = {0};
    
    for(int i = 0; i < n; i++)
    {
        seeksequence[i] = head;
        calculatedifference(request, head, diff, n);
        int index = findMIN(diff, n);
        diff[index][1] = 1;
        
        // Increase the total count 
        seekcount += diff[index][0]; 
        
        // Accessed track is now new head 
        head = request[index];
    }
    seeksequence[n] = head;
    
    cout << "Total number of seek operations = "
         << seekcount << endl;
    cout << "Seek sequence is : " << "\n";
    
    // Print the sequence 
    for(int i = 0; i <= n; i++) 
    {
        cout << seeksequence[i] << "\n";
    }
}

// Driver code
int main()
{
    int n = 8;
    int proc[n] = { 176, 79, 34, 60, 92, 11, 41, 114 };
    
    shortestSeekTimeFirst(proc, 50, n);
    
    return 0;
}

// This code is contributed by manish19je0495

```

```
// Java program for implementation of 
// SSTF disk scheduling
class node {
    
    // represent difference between 
    // head position and track number
    int distance = 0; 
    
    // true if track has been accessed
    boolean accessed = false; 
}

public class SSTF {
    
    // Calculates difference of each 
    // track number with the head position
    public static void calculateDifference(int queue[], 
                                        int head, node diff[])
                                        
    {
        for (int i = 0; i < diff.length; i++)
            diff[i].distance = Math.abs(queue[i] - head);
    }

    // find unaccessed track 
    // which is at minimum distance from head
    public static int findMin(node diff[])
    {
        int index = -1, minimum = Integer.MAX_VALUE;

        for (int i = 0; i < diff.length; i++) {
            if (!diff[i].accessed && minimum > diff[i].distance) {
                
                minimum = diff[i].distance;
                index = i;
            }
        }
        return index;
    }

    public static void shortestSeekTimeFirst(int request[], 
                                                     int head)
                                                     
    {
        if (request.length == 0)
            return;
            
        // create array of objects of class node    
        node diff[] = new node[request.length]; 
        
        // initialize array
        for (int i = 0; i < diff.length; i++) 
        
            diff[i] = new node();
        
        // count total number of seek operation    
        int seek_count = 0; 
        
        // stores sequence in which disk access is done
        int[] seek_sequence = new int[request.length + 1]; 
        
        for (int i = 0; i < request.length; i++) {
            
            seek_sequence[i] = head;
            calculateDifference(request, head, diff);
            
            int index = findMin(diff);
            
            diff[index].accessed = true;
            
            // increase the total count
            seek_count += diff[index].distance; 
            
            // accessed track is now new head
            head = request[index]; 
        }
        
        // for last accessed track
        seek_sequence[seek_sequence.length - 1] = head; 
        
        System.out.println("Total number of seek operations = " 
                                                     + seek_count);
                                                     
        System.out.println("Seek Sequence is");
        
        // print the sequence
        for (int i = 0; i < seek_sequence.length; i++) 
            System.out.println(seek_sequence[i]);
    }

    public static void main(String[] args)
    {
        // request array
        int arr[] = { 176, 79, 34, 60, 92, 11, 41, 114 }; 
        shortestSeekTimeFirst(arr, 50);
    }
}

```

```
# Python3 program for implementation of 
# SSTF disk scheduling 

# Calculates difference of each 
# track number with the head position
def calculateDifference(queue, head, diff):
    for i in range(len(diff)):
        diff[i][0] = abs(queue[i] - head) 
    
# find unaccessed track which is 
# at minimum distance from head 
def findMin(diff): 

    index = -1
    minimum = 999999999

    for i in range(len(diff)):
        if (not diff[i][1] and 
                minimum > diff[i][0]):
            minimum = diff[i][0]
            index = i
    return index 
    
def shortestSeekTimeFirst(request, head):             
        if (len(request) == 0): 
            return
        
        l = len(request) 
        diff = [0] * l
        
        # initialize array 
        for i in range(l):
            diff[i] = [0, 0]
        
        # count total number of seek operation     
        seek_count = 0
        
        # stores sequence in which disk 
        # access is done 
        seek_sequence = [0] * (l + 1) 
        
        for i in range(l): 
            seek_sequence[i] = head 
            calculateDifference(request, head, diff) 
            index = findMin(diff) 
            
            diff[index][1] = True
            
            # increase the total count 
            seek_count += diff[index][0] 
            
            # accessed track is now new head 
            head = request[index] 
    
        # for last accessed track 
        seek_sequence[len(seek_sequence) - 1] = head 
        
        print("Total number of seek operations =", 
                                       seek_count) 
                                                        
        print("Seek Sequence is") 
        
        # print the sequence 
        for i in range(l + 1):
            print(seek_sequence[i]) 
    
# Driver code 
if __name__ =="__main__":
    
    # request array 
    proc = [176, 79, 34, 60, 
            92, 11, 41, 114]
    shortestSeekTimeFirst(proc, 50)
    
# This code is contributed by
# Shubham Singh(SHUBHAMSINGH10)

```

```
// C# program for implementation of 
// SSTF disk scheduling
using System;
    
public class node
{
    
    // represent difference between 
    // head position and track number
    public int distance = 0; 
    
    // true if track has been accessed
    public Boolean accessed = false; 
}

public class SSTF 
{
    
    // Calculates difference of each 
    // track number with the head position
    public static void calculateDifference(int []queue, 
                                        int head, node []diff)
                                        
    {
        for (int i = 0; i < diff.Length; i++)
            diff[i].distance = Math.Abs(queue[i] - head);
    }

    // find unaccessed track 
    // which is at minimum distance from head
    public static int findMin(node []diff)
    {
        int index = -1, minimum = int.MaxValue;

        for (int i = 0; i < diff.Length; i++)
        {
            if (!diff[i].accessed && minimum > diff[i].distance)
            {
                
                minimum = diff[i].distance;
                index = i;
            }
        }
        return index;
    }

    public static void shortestSeekTimeFirst(int []request, 
                                                    int head)
    {
        if (request.Length == 0)
            return;
            
        // create array of objects of class node 
        node []diff = new node[request.Length]; 
        
        // initialize array
        for (int i = 0; i < diff.Length; i++) 
        
            diff[i] = new node();
        
        // count total number of seek operation 
        int seek_count = 0; 
        
        // stores sequence in which disk access is done
        int[] seek_sequence = new int[request.Length + 1]; 
        
        for (int i = 0; i < request.Length; i++)
        {
            
            seek_sequence[i] = head;
            calculateDifference(request, head, diff);
            
            int index = findMin(diff);
            
            diff[index].accessed = true;
            
            // increase the total count
            seek_count += diff[index].distance; 
            
            // accessed track is now new head
            head = request[index]; 
        }
        
        // for last accessed track
        seek_sequence[seek_sequence.Length - 1] = head; 
        
        Console.WriteLine("Total number of seek operations = "
                                                    + seek_count);
                                                    
        Console.WriteLine("Seek Sequence is");
        
        // print the sequence
        for (int i = 0; i < seek_sequence.Length; i++) 
            Console.WriteLine(seek_sequence[i]);
    }

    // Driver code
    public static void Main(String[] args)
    {
        // request array
        int []arr = { 176, 79, 34, 60, 92, 11, 41, 114 }; 
        shortestSeekTimeFirst(arr, 50);
    }
}

// This code contributed by Rajput-Ji

```

```
// Javascript Program for implementation of 
// SSTF disk scheduling
function calculatedifference(request, head, diff, n) {
    for (let i = 0; i < n; i++) {
        diff[i][0] = Math.abs(head - request[i]);
    }
}

// Find unaccessed track which is 
// at minimum distance from head 
function findMIN(diff, n) {
    let index = -1;
    let minimum = 1e9;

    for (let i = 0; i < n; i++) {
        if (!diff[i][1] && minimum > diff[i][0]) {
            minimum = diff[i][0];
            index = i;
        }
    }
    return index;
}

function shortestSeekTimeFirst(request, head, n) {
    if (n == 0) {
        return;
    }

    // Create array of objects of class node    
    let diff = new Array(n);
    for (let i = 0; i < n; i++) {
        diff[i] = new Array(2);
    }

    // Count total number of seek operation   
    let seekcount = 0;

    // Stores sequence in which disk access is done 
    let seeksequence = new Array(n + 1);
    seeksequence[0] = head;

    for (let i = 0; i < n; i++) {
        calculatedifference(request, head, diff, n);
        let index = findMIN(diff, n);
        diff[index][1] = 1;

        // Increase the total count 
        seekcount += diff[index][0];

        // Accessed track is now new head 
        head = request[index];
        seeksequence[i + 1] = head;
    }

    console.log("Total number of seek operations = " + seekcount);
    console.log("Seek sequence is : ");

    // Print the sequence 
    for (let i = 0; i <= n; i++) {
        console.log(seeksequence[i]);
    }
}

// Driver code
let n = 8;
let proc = [176, 79, 34, 60, 92, 11, 41, 114];

shortestSeekTimeFirst(proc, 50, n);

//  This code is contributed by ishankhandelwals.

```

## Output

```
Total number of seek operations = 204Seek Sequence: 50, 41, 34, 11, 60, 79, 92, 114, 176 
```

Time Complexity: O(N^2)

Auxiliary Space: O(N)