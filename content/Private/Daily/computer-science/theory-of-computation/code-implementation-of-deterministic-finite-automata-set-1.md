---
title: "Code Implementation of Deterministic Finite Automata (Set 1)"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Code Implementation of Deterministic Finite Automata (Set 1)
In this article, we will learn about designing of Deterministic Finite Automata (DFA) and it's code implementation.

Problem-1: Construction of a DFA for the set of string over {a, b} such that length of the string |w|=2 i.e, length of the string is exactly 2.

Explanation - The desired language will be like:

```
L = {aa, ab, ba, bb} 
```

The state transition diagram of the language will be like: Here, State A represent set of all string of length zero (0), state B represent set of all string of length one (1), state C represent set of all string of length two (2). State C is the final state and D is the dead state it is so because after getting any alphabet as input it will not go into final state ever.

![](images_toc2.png)

```
Number of states: n+2Where n is |w|=n 
```

The above automata will accept all the strings having the length of the string exactly 2. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to C and when the length of the string is greater than 2, then it will go from state C to D (Dead state) and after it from state D TO D itself.

```
# include <iostream>
# include <string>

// Check string in state A
void checkStateA(const std::string& n);

// Transition to state B
void stateB(const std::string& n);

// Transition to state C
void stateC(const std::string& n);

int main() {
    // Take input
    std::string n;
    std::cout << "Enter a string: ";
    std::cin >> n;
     
    // Check state A
    checkStateA(n);

    return 0;
}

// Check string in state A
void checkStateA(const std::string& n) {
    // If the length of the string is one, print not accepted
    if (n.length() == 1) {
        std::cout << "string not accepted" << std::endl;
    } else {
        // Pass the string to state B for further transitions
        if (n[0] == 'a' || n[0] == 'b') {
            stateB(n.substr(1));
        }
    }
}

// Transition to state B
void stateB(const std::string& n) {
    // If the length is not 1, print not accepted
    if (n.length() != 1) {
        std::cout << "string not accepted" << std::endl;
    } else {
        // Pass the string to state C
        stateC(n.substr(1));
    }
}

// Transition to state C
void stateC(const std::string& n) {
    // If the length becomes zero, print accepted; else, not accepted
    if (n.empty()) {
        std::cout << "string accepted" << std::endl;
    } else {
        std::cout << "string not accepted" << std::endl;
    }
}

```

```
import java.util.Scanner;

public class StateMachine {

    public static void main(String[] args) {
        // Set the input string directly in the code
        String inputString = "aa";

        // Check state A
        checkStateA(inputString);
    }

    // Check string in state A
    static void checkStateA(String n) {
        // If the length of the string is one, print not accepted
        if (n.length() == 1) {
            System.out.println("string not accepted");
        } else {
            // Pass the string to state B for further transitions
            if (n.charAt(0) == 'a' || n.charAt(0) == 'b') {
                stateB(n.substring(1));
            }
        }
    }

    // Transition to state B
    static void stateB(String n) {
        // If the length is not 1, print not accepted
        if (n.length() != 1) {
            System.out.println("string not accepted");
        } else {
            // Pass the string to state C
            stateC(n.substring(1));
        }
    }

    // Transition to state C
    static void stateC(String n) {
        // If the length becomes zero, print accepted; else, not accepted
        if (n.isEmpty()) {
            System.out.println("string accepted");
        } else {
            System.out.println("string not accepted");
        }
    }
}

```

```
# check string in
# in state A
def checkStateA(n):
    
    #if length of
    #string is one
    #print not accepted
    if(len(n)==1):
        print("string not accepted")
    else:   
        #pass string to stateB to
        #to check further transitions
        if(n[0]=='a' or n[0]=='b'):
            stateB(n[1:])
            
            
def stateB(n):
    #here if length 
    #is not 1 print#string not accepted
    if(len(n)!=1):
        print("string not accepted")
    else:
        #else pass string 
        #to state c
        stateC(n[1:])
def stateC(n):
    #here if length 
    #becomes zero
    #print accepted
    #else not accepted
    if (len(n)==0):
        print("string accepted")
    else:
        print("string not accepted")
    
    
# take input    
n=input()
checkStateA(n)

```

```
using System;

class StateMachine
{
    static void Main()
    {
        // Set the input string directly in the code
        string inputString = "aa";

        // Check state A
        CheckStateA(inputString);
    }

    // Check string in state A
    static void CheckStateA(string n)
    {
        // If the length of the string is one, print not accepted
        if (n.Length == 1)
        {
            Console.WriteLine("string not accepted");
        }
        else
        {
            // Pass the string to state B for further transitions
            if (n[0] == 'a' || n[0] == 'b')
            {
                StateB(n.Substring(1));
            }
        }
    }

    // Transition to state B
    static void StateB(string n)
    {
        // If the length is not 1, print not accepted
        if (n.Length != 1)
        {
            Console.WriteLine("string not accepted");
        }
        else
        {
            // Pass the string to state C
            StateC(n.Substring(1));
        }
    }

    // Transition to state C
    static void StateC(string n)
    {
        // If the length becomes zero, print accepted; else, not accepted
        if (string.IsNullOrEmpty(n))
        {
            Console.WriteLine("string accepted");
        }
        else
        {
            Console.WriteLine("string not accepted");
        }
    }
}
// code is contributed by utkarsh

```

```
// Check string in state A
function checkStateA(n) {
    // If the length of the string is one, print not accepted
    if (n.length === 1) {
        console.log("string not accepted");
    } else {
        // Pass the string to state B for further transitions
        if (n[0] === 'a' || n[0] === 'b') {
            stateB(n.substring(1));
        }
    }
}

// Transition to state B
function stateB(n) {
    // If the length is not 1, print not accepted
    if (n.length !== 1) {
        console.log("string not accepted");
    } else {
        // Pass the string to state C
        stateC(n.substring(1));
    }
}

// Transition to state C
function stateC(n) {
    // If the length becomes zero, print accepted; else, not accepted
    if (n.length === 0) {
        console.log("string accepted");
    } else {
        console.log("string not accepted");
    }
}

// Main function
function main() {
    // Take input
    const readline = require('readline');
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    rl.question("Enter a string: ", function (n) {
        // Check state A
        checkStateA(n);
        rl.close();
    });
}

// Call the main function
main();

```

Problem-2: Construction of a DFA for the set of string over {a, b} such that length of the string |w|>=2 i.e, length of the string should be at least 2.

Explanation - The desired language will be like:

```
L = {aa, ab, ba, bb, aaa, aab, aba, abb........} 
```

The state transition diagram of the language will be like: Here, State A represent set of all string of length zero (0), state B represent set of all string of length one (1), and state C represent set of all string of length two (2).

![](images_toc.png)

```
Number of states: n+1Where n is |w|>=n 
```

The above automata will accept all the strings having the length of the string at least 2. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to C and lastly when the length of the string is greater than 2, then it will go from state C to C itself.

```
# check string in
# in state A
def checkStateA(n):
    
    #if length of
    #string is one
    #print not accepted
    if(len(n)==1):
        print("string not accepted")
    else:   
        #pass string to stateB to
        #to check further transitions
        if(n[0]=='a' or n[0]=='b'):
            stateB(n[1:])
            
            
def stateB(n):
    
    #here if length 
    #is less than 1 
    #printstring not accepted
    if(len(n)<1):
        print("string not accepted")
    else:
        
        #else pass string 
        #to state c
        stateC(n[1:])
        
        
def stateC(n):
    #here if length of string 
    #is greater than equal to zero
    #print accepted
    #else not accepted
    if (len(n)>=0):
        print("string accepted")
    else:
        print("string not accepted")
    
    
# take input    
n=input()
checkStateA(n)

```

Problem-3: Construction of a DFA for the set of string over {a, b} such that length of the string |w|<=2 i.e, length of the string is atmost 2.Explanation - The desired language will be like:

```
L = {?, aa, ab, ba, bb} 
```

The state transition diagram of the language will be like:

![](images_toc1.png)

Here, State A represent set of all string of length zero (0), state B represent set of all string of length one (1), state C represent set of all string of length two (2), state A, B, C is the final state and D is the dead state it is so because after getting any alphabet as input it will not go into final state ever.

```
Number of states: n+2Where n is |w|<=n 
```

The above automata will accept all the strings having the length of the string at most 2. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to C and lastly when the length of the string is greater than 2, then it will go from state C to D (Dead state).

```
# check string in
# in state A
def checkStateA(n):
    
    #if only two transition occurs 
    #then print string accepted
  
    if(n[0]=='a' or n[0]=='b'):
        stateB(n[1:])
            
            
def stateB(n):
    
    #if length is 0 
    #print accepted
    if(len(n)==0):
        print("string accepted")
    else:
        stateC(n[1:])
        
        
def stateC(n):
    #if length is 0 
    #print accepted
    #else not accepted
    if (len(n)==0):
        print("string accepted")
    else:
        print("string not accepted")
    
    
# take input    
n=input()
checkStateA(n)

```