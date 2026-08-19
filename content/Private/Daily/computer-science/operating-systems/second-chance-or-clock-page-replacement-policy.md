---
title: "Second Chance (or Clock) Page Replacement Policy"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Second Chance (or Clock) Page Replacement Policy
The Second Chance Page Replacement Algorithm is an improvement over FIFO (First-In, First-Out). FIFO may remove frequently used pages, but Second Chance reduces this problem by using a reference bit.

1. When a page is accessed, its reference bit is set to 1.2. During replacement, the algorithm checks pages in order:

- If a page’s bit = 0, it is replaced.
- If the bit = 1, it is reset to 0 and the page gets a “second chance,” moving to the back of the queue.

This way, frequently used pages are less likely to be removed.

Traditionally, Second Chance and its variant Clock were considered less efficient than LRU (Least Recently Used). However, recent research from Carnegie Mellon University shows that Second Chance and Clock can actually achieve a lower miss ratio and are more scalable, making them more efficient than LRU in modern systems.

## Algorithm

The algorithm works by associating a reference bit with each page in memory:

- Reference Bit = 1, The page has been recently used.
- Reference Bit = 0, The page has not been recently used.

### Steps:

1. Pages are maintained in a queue (like FIFO).2. When a page fault occurs, the algorithm checks the page at the front of the queue.3. If the reference bit = 0, the page is replaced.4. If the reference bit = 1:

- The reference bit is reset to 0.
- The page is moved to the back of the queue (given a second chance).
- The search continues until a page with reference bit = 0 is found.

Thus, frequently accessed pages are less likely to be replaced.

### Example

Let's say the reference string is 0 4 1 4 2 4 3 4 2 4 0 4 1 4 2 4 3 4 and we have 3 frames. Let's see how the algorithm proceeds by tracking the second chance bit and the pointer.

![page_replacement](images_page_replacement.webp)

- Initially, all frames are empty so after the first 3 passes they will be filled with {0, 4, 1} and the second chance array will be {0, 0, 0} as none has been referenced yet. Also, the pointer will cycle back to 0.
- Pass-4: Frame={0, 4, 1}, second_chance = {0, 1, 0} [4 will get a second chance], pointer = 0 (No page needed to be updated so the candidate is still page in frame 0), pf = 3 (No increase in page fault number).
- Pass-5: Frame={2, 4, 1}, second_chance= {0, 1, 0} [0 replaced; it's second chance bit was 0, so it didn't get a second chance], pointer=1 (updated), pf=4
- Pass-6: Frame={2, 4, 1}, second_chance={0, 1, 0}, pointer=1, pf=4 (No change)
- Pass-7: Frame={2, 4, 3}, second_chance= {0, 0, 0} [4 survived but it's second chance bit became 0], pointer=0 (as element at [[index]] 2 was finally replaced), pf=5
- Pass-8: Frame={2, 4, 3}, second_chance= {0, 1, 0} [4 referenced again], pointer=0, pf=5
- Pass-9: Frame={2, 4, 3}, second_chance= {1, 1, 0} [2 referenced again], pointer=0, pf=5
- Pass-10: Frame={2, 4, 3}, second_chance= {1, 1, 0}, pointer=0, pf=5 (no change)
- Pass-11: Frame={2, 4, 0}, second_chance= {0, 0, 0}, pointer=0, pf=6 (2 and 4 got second chances)
- Pass-12: Frame={2, 4, 0}, second_chance= {0, 1, 0}, pointer=0, pf=6 (4 will again get a second chance)
- Pass-13: Frame={1, 4, 0}, second_chance= {0, 1, 0}, pointer=1, pf=7 (pointer updated, pf updated)
- Page-14: Frame={1, 4, 0}, second_chance= {0, 1, 0}, pointer=1, pf=7 (No change)
- Page-15: Frame={1, 4, 2}, second_chance= {0, 0, 0}, pointer=0, pf=8 (4 survived again due to 2nd chance!)
- Page-16: Frame={1, 4, 2}, second_chance= {0, 1, 0}, pointer=0, pf=8 (2nd chance updated)
- Page-17: Frame={3, 4, 2}, second_chance= {0, 1, 0}, pointer=1, pf=9 (pointer, pf updated)
- Page-18: Frame={3, 4, 2}, second_chance= {0, 1, 0}, pointer=1, pf=9 (No change)

### Code Implementation:

```
# include<iostream>
# include<cstring>
# include<sstream>
using namespace std; 
    
// If page found, updates the second chance bit to true 
static bool findAndUpdate(int x,int arr[], 
                bool second_chance[],int frames){ 
    int i; 
    for(i = 0; i < frames; i++){ 
        if(arr[i] == x){ 
            // Mark that the page deserves a second chance 
            second_chance[i] = true; 
            // Return 'true', that is there was a hit 
            // and so there's no need to replace any page 
            return true; 
        } 
    }
    // Return 'false' so that a page for replacement is selected 
    // as he reuested page doesn't exist in memory 
    return false; 
} 

// Updates the page in memory and returns the pointer 
static int replaceAndUpdate(int x,int arr[], 
            bool second_chance[],int frames,int pointer){ 
    while(true){ 
        // We found the page to replace 
        if(!second_chance[pointer]){ 
            // Replace with new page 
            arr[pointer] = x; 
            // Return updated pointer 
            return (pointer + 1) % frames; 
        } 
        // Mark it 'false' as it got one chance 
        // and will be replaced next time unless accessed again 
        second_chance[pointer] = false; 
        //Pointer is updated in round robin manner 
        pointer = (pointer + 1) % frames; 
    } 
} 
static void printHitsAndFaults(string reference_string, int frames){ 
    int pointer, i, l=0, x, pf; 
    //initially we consider frame 0 is to be replaced 
    pointer = 0; 

    //number of page faults 
    pf = 0; 
    
    // Create a array to hold page numbers 
    int arr[frames];
    
    // No pages initially in frame, 
    // which is indicated by -1 
    memset(arr, -1, sizeof(arr)); 
    
    // Create second chance array. 
    // Can also be a byte array for optimizing memory 
    bool second_chance[frames];
    // Split the string into tokens, 
    // that is page numbers, based on space 
    string str[100];
    string word = ""; 
    for (auto x : reference_string){ 
        if (x == ' '){ 
            str[l]=word; 
            word = "";
            l++;
        } 
        else{ 
            word = word + x; 
        } 
    }
    str[l] = word;
    l++;
    // l=the length of array 
    for(i = 0; i < l; i++){
        x = stoi(str[i]);
        // Finds if there exists a need to replace 
        // any page at all 
        if(!findAndUpdate(x,arr,second_chance,frames)){ 
            // Selects and updates a victim page 
            pointer = replaceAndUpdate(x,arr, 
                    second_chance,frames,pointer); 
            
            // Update page faults 
            pf++; 
        } 
    } 
    cout << "Total page faults were " << pf << "\n";
}
// Driver code
int main(){ 
    string reference_string = ""; 
    int frames = 0; 
    // Test 1: 
    reference_string = "0 4 1 4 2 4 3 4 2 4 0 4 1 4 2 4 3 4"; 
    frames = 3; 
    // Output is 9 
    printHitsAndFaults(reference_string,frames); 
    // Test 2: 
    reference_string = "2 5 10 1 2 2 6 9 1 2 10 2 6 1 2 1 6 9 5 1"; 
    frames = 4; 
    // Output is 11 
    printHitsAndFaults(reference_string,frames); 
    return 0; 
}

```

```
# include <stdio.h>
# include <string.h>
# include <stdlib.h>

// If page found, updates the second chance bit to true
static int findAndUpdate(int x, int arr[], int second_chance[], int frames) {
    int i;
    for (i = 0; i < frames; i++) {
        if (arr[i] == x) {
            // Mark that the page deserves a second chance
            second_chance[i] = 1;
            // Return 'true', that is there was a hit
            // and so there's no need to replace any page
            return 1;
        }
    }
    // Return 'false' so that a page for replacement is selected
    // as the requested page doesn't exist in memory
    return 0;
}

// Updates the page in memory and returns the pointer
static int replaceAndUpdate(int x, int arr[], int second_chance[], int frames, int pointer) {
    while (1) {
        // We found the page to replace
        if (!second_chance[pointer]) {
            // Replace with new page
            arr[pointer] = x;
            // Return updated pointer
            return (pointer + 1) % frames;
        }
        // Mark it 'false' as it got one chance
        // and will be replaced next time unless accessed again
        second_chance[pointer] = 0;
        // Pointer is updated in round robin manner
        pointer = (pointer + 1) % frames;
    }
}

static void printHitsAndFaults(char* reference_string, int frames) {
    int pointer = 0, i, l = 0, x, pf = 0;
    // Create a array to hold page numbers
    int arr[frames];
    // No pages initially in frame, which is indicated by -1
    memset(arr, -1, sizeof(arr));
    // Create second chance array
    int second_chance[frames];
    // Split the string into tokens, that is page numbers, based on space
    char* token = strtok(reference_string, " ");
    while (token != NULL) {
        str[l++] = atoi(token);
        token = strtok(NULL, " ");
    }
    for (i = 0; i < l; i++) {
        x = str[i];
        // Finds if there exists a need to replace any page at all
        if (!findAndUpdate(x, arr, second_chance, frames)) {
            // Selects and updates a victim page
            pointer = replaceAndUpdate(x, arr, second_chance, frames, pointer);
            // Update page faults
            pf++;
        }
    }
    printf("Total page faults were %d\n", pf);
}

int main() {
    char reference_string[] = "0 4 1 4 2 4 3 4 2 4 0 4 1 4 2 4 3 4";
    int frames = 3;
    // Output is 9
    printHitsAndFaults(reference_string, frames);
    
    strcpy(reference_string, "2 5 10 1 2 2 6 9 1 2 10 2 6 1 2 1 6 9 5 1");
    frames = 4;
    // Output is 11
    printHitsAndFaults(reference_string, frames);
    return 0;
}

```

```
import java.util.Arrays;

public class SecondChance{
    static boolean findAndUpdate(int x, int[] arr, boolean[] secondChance, int frames){
        for (int i = 0; i < frames; i++) {
            if (arr[i] == x) {
                secondChance[i] = true;
                return true;
            }
        }
        return false;
    }

    static int replaceAndUpdate(int x, int[] arr, boolean[] secondChance, int frames, int pointer){
        while (true) {
            if (!secondChance[pointer]) {
                arr[pointer] = x;
                return (pointer + 1) % frames;
            }
            secondChance[pointer] = false;
            pointer = (pointer + 1) % frames;
        }
    }

    static void printHitsAndFaults(String referenceString, int frames) {
        int pointer = 0, i, l, x, pf = 0;
        int[] arr = new int[frames];
        Arrays.fill(arr, -1);
        boolean[] secondChance = new boolean[frames];
        String[] str = referenceString.split(" ");
        l = str.length;
        for (i = 0; i < l; i++) {
            x = Integer.parseInt(str[i]);
            if (!findAndUpdate(x, arr, secondChance, frames)) {
                pointer = replaceAndUpdate(x, arr, secondChance, frames, pointer);
                pf++;
            }
        }
        System.out.println("Total page faults were " + pf);
    }

    public static void main(String[] args) {
        String referenceString = "0 4 1 4 2 4 3 4 2 4 0 4 1 4 2 4 3 4";
        int frames = 3;
        printHitsAndFaults(referenceString, frames);

        referenceString = "2 5 10 1 2 2 6 9 1 2 10 2 6 1 2 1 6 9 5 1";
        frames = 4;
        printHitsAndFaults(referenceString, frames);
    }
}

```

```
def find_and_update(x, arr, second_chance, frames):
    for i in range(frames):
        if arr[i] == x:
            second_chance[i] = True
            return True
    return False

def replace_and_update(x, arr, second_chance, frames, pointer):
    while True:
        if not second_chance[pointer]:
            arr[pointer] = x
            return (pointer + 1) % frames
        second_chance[pointer] = False
        pointer = (pointer + 1) % frames

def print_hits_and_faults(reference_string, frames):
    pointer = 0
    pf = 0
    arr = [-1] * frames
    second_chance = [False] * frames
    str_list = reference_string.split()
    l = len(str_list)
    for i in range(l):
        x = int(str_list[i])
        if not find_and_update(x, arr, second_chance, frames):
            pointer = replace_and_update(x, arr, second_chance, frames, pointer)
            pf += 1
    print(f'Total page faults were {pf}')

# Driver code
reference_string = '0 4 1 4 2 4 3 4 2 4 0 4 1 4 2 4 3 4'
frames = 3
print_hits_and_faults(reference_string, frames)

reference_string = '2 5 10 1 2 2 6 9 1 2 10 2 6 1 2 1 6 9 5 1'
frames = 4
print_hits_and_faults(reference_string, frames)

```

```
function findAndUpdate(x, arr, secondChance, frames) {
    for (let i = 0; i < frames; i++) {
        if (arr[i] === x) {
            secondChance[i] = true;
            return true;
        }
    }
    return false;
}

function replaceAndUpdate(x, arr, secondChance, frames, pointer) {
    while (true) {
        if (!secondChance[pointer]) {
            arr[pointer] = x;
            return (pointer + 1) % frames;
        }
        secondChance[pointer] = false;
        pointer = (pointer + 1) % frames;
    }
}

function printHitsAndFaults(referenceString, frames) {
    let pointer = 0, i, l, x, pf = 0;
    let arr = new Array(frames).fill(-1);
    let secondChance = new Array(frames).fill(false);
    let str = referenceString.split(' ');
    l = str.length;
    for (i = 0; i < l; i++) {
        x = parseInt(str[i]);
        if (!findAndUpdate(x, arr, secondChance, frames)) {
            pointer = replaceAndUpdate(x, arr, secondChance, frames, pointer);
            pf++;
        }
    }
    console.log(`Total page faults were ${pf}`);
}

// Driver code
let referenceString = '0 4 1 4 2 4 3 4 2 4 0 4 1 4 2 4 3 4';
let frames = 3;
printHitsAndFaults(referenceString, frames);

referenceString = '2 5 10 1 2 2 6 9 1 2 10 2 6 1 2 1 6 9 5 1';
frames = 4;
printHitsAndFaults(referenceString, frames);

```

Output:

> Total page faults were 9Total page faults were 11

Total page faults were 9Total page faults were 11