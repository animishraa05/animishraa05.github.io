---
title: "Program for Deterministic Finite Automata"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Program for Deterministic Finite Automata
Construction of a DFA for the set of string over {a, b} such that length of the string |w| is divisible by 2 i.e, |w| mod 2 = 0.

Explanation -

The desired language will be like:

> L = {\epsilon , aa, ab, ba, bb, aaaa, bbbb, ............}

L = {\epsilon , aa, ab, ba, bb, aaaa, bbbb, ............}

The state transition diagram of the language will be like:

![](images/toc3.png)

Here, state A represent set of all string of length even (0, 2, 4, ...), and state B represent set of all string of length odd (1, 3, 5, ...).

> Number of states: nIf |W| mod n = 0

Number of states: nIf |W| mod n = 0

```
# include <iostream>
# include <string>

void stateA(const std::string& n);
void stateB(const std::string& n);

void stateA(const std::string& n) {
    if (n.empty()) {
        std::cout << "Accepted" << std::endl;
    } else {
        // on any input call function stateB
        if (n[0] == 'a' || n[0] == 'b') {
            stateB(n.substr(1));
        }
    }
}

void stateB(const std::string& n) {
    if (n.empty()) {
        std::cout << "Not Accepted" << std::endl;
    } else {
        // on any input call function stateA
        if (n[0] == 'a' || n[0] == 'b') {
            stateA(n.substr(1));
        }
    }
}

int main() {
    // take input
    std::string inputString = "ab";

    // call stateA to check the input string
    stateA(inputString);

    return 0;
}
//This code is contributed by utkarsh

```

```
public class StateMachine {

    public static void stateA(String n) {
        if (n.isEmpty()) {
            System.out.println("Accepted");
        } else {
            // on any input call function stateB
            if (n.charAt(0) == 'a' || n.charAt(0) == 'b') {
                stateB(n.substring(1));
            }
        }
    }

    public static void stateB(String n) {
        if (n.isEmpty()) {
            System.out.println("Not Accepted");
        } else {
            // on any input call function stateA
            if (n.charAt(0) == 'a' || n.charAt(0) == 'b') {
                stateA(n.substring(1));
            }
        }
    }

    public static void main(String[] args) {
        // take input
        String inputString = "ab";

        // call stateA to check the input string
        stateA(inputString);
    }
}

```

```
def stateA(n):
    if(len(n)==0):
        print(&quot;Accepted&quot;)
    else:  
        
        #on any input call function stateB
        if (n[0]=='0' or n[0]=='1'):
            stateB(n[1:])
        
def stateB(n):
    if(len(n)==0):
        print(&quot;Not Accepted&quot;)
    else:
        
         #on any input call function stateA
        if (n[0]=='0' or n[0]=='1'):
            stateA(n[1:])        



# take input
n=input()

# call stateA
# to check the input
stateA(n)

```

```
using System;

class Program
{
    static void Main()
    {
        // Take input
        string inputString = "ab";

        // Call stateA to check the input string
        StateA(inputString);
    }

    static void StateA(string n)
    {
        if (string.IsNullOrEmpty(n))
        {
            Console.WriteLine("Accepted");
        }
        else
        {
            // On any input, call function StateB
            if (n[0] == 'a' || n[0] == 'b')
            {
                StateB(n.Substring(1));
            }
        }
    }

    static void StateB(string n)
    {
        if (string.IsNullOrEmpty(n))
        {
            Console.WriteLine("Not Accepted");
        }
        else
        {
            // On any input, call function StateA
            if (n[0] == 'a' || n[0] == 'b')
            {
                StateA(n.Substring(1));
            }
        }
    }
}

```

Output:

```
Accepted
```

The above automata will accept all the strings having the length of the string divisible by 2. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to A and so on. State A is the final state i.e, it accept all the string having length divisible by 2.

Problem-2:

Construction of a DFA for the set of string over {a, b} such that length of the string |w| is not divisible by 2 i.e, |w| mod 2 = 1.

Explanation -

The desired language will be like:

```
L = {a, b, aaa, aab, aba, abb, aaaaa, bbbb, .......} 
```

The state transition diagram of the language will be like:

![](images/toc4-1.png)

Here, state A represent set of all string of length even (0, 2, 4, ...), and state B represent set of all string of length odd (1, 3, 5, ...).

```
def stateA(n):
    if(len(n)==0):
        print(&quot;Not Accepted&quot;)
    else:  
        
        #on any input call function stateB
        if (n[0]=='0' or n[0]=='1'):
            stateB(n[1:])
        
def stateB(n):
    if(len(n)==0):
        print(&quot;Accepted&quot;)
    else:
        
         #on any input call function stateA
        if (n[0]=='0' or n[0]=='1'):
            stateA(n[1:])        



# take input
n=input()

# call stateA
# to check the input
stateA(n)

```

The above automata will accept all the strings having the length of the string not divisible by 2. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to A and so on. State B is the final state i.e, it accept all the string having length not divisible by 2.

Problem-3:

Construction of a DFA for the set of string over {a, b} such that length of the string |w| is divisible by 3 i.e, |w| mod 3 = 0.

Explanation -

The desired language will be like:

```
L = {?, aaa, aab, aba, abb, aaaaaa, bbbbbb, .......} 
```

The state transition diagram of the language will be like:

![](images/toc5.png)

Here, state A represents set for which string's length divided by 3 then remainder is zero (0), state B represents set for which string's length divided by 3 then the remainder is one (1), and state C represents set for which string's length divided by 3 then the remainder is two (2).

```
Number of states: nIf |W| mod n = 0 
```

```
def stateA(n):
    if(len(n)==0):
        print(&quot;Accepted&quot;)
    else:  
        
        #on any input call function stateB
        if (n[0]=='0' or n[0]=='1'):
            stateB(n[1:])
        
def stateB(n):
    if(len(n)==0):
        print(&quot;Not Accepted&quot;)
    else:
        
         #on any input call function stateC
        if (n[0]=='0' or n[0]=='1'):
            stateC(n[1:])  
            
def stateC(n):
    if(len(n)==0):
        print(&quot;Not Accepted&quot;)
    else:
        
         #on any input call function stateA
        if (n[0]=='0' or n[0]=='1'):
            stateA(n[1:])              



# take input
n=input()

# call stateA
# to check the input
stateA(n)

```

The above automata will accept all the strings having the length of the string divisible by 3. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to C and When the length of the string is 3, then it will go from state C to A (final state). State A is the final state i.e, it accepts all the string having the length divisible by 3.

Problem-4:

Construction of a DFA for the set of string over {a, b} such that length of the string |w| is not divisible by 3 i.e, |w| mod 3 = 1.

Explanation -

The desired language will be like:

```
L = {a, b, aa, ab, ba, bb, aaaa, bbbb, ........} 
```

The state transition diagram of the language will be like:

![](images/toc6.png)

Here, state A represents set for which string's length divided by 3 then remainder is zero (0), state B represents set for which string's length divided by 3 then the remainder is one (1), and state C represents set for which string's length divided by 3 then the remainder is two (2).

```
def stateA(n):
    if(len(n)==0):
        print(&quot;Not Accepted&quot;)
    else:  
        
        #on any input call function stateB
        if (n[0]=='0' or n[0]=='1'):
            stateB(n[1:])
        
def stateB(n):
    if(len(n)==0):
        print(&quot;Accepted&quot;)
    else:
        
         #on any input call function stateC
        if (n[0]=='0' or n[0]=='1'):
            stateC(n[1:])  
            
def stateC(n):
    if(len(n)==0):
        print(&quot;Not Accepted&quot;)
    else:
        
         #on any input call function stateA
        if (n[0]=='0' or n[0]=='1'):
            stateA(n[1:])              



# take input
n=input()

# call stateA
# to check the input
stateA(n)

```

The above automata will accept all the strings having the length of the string not divisible by 3. When the length of the string is 1, then it will go from state A to B. When the length of the string is 2, then it will go from state B to C and When the length of the string is 3, then it will go from state C to A. State B and C are the final state i.e, it accepts all the string having the length not divisible by 3.