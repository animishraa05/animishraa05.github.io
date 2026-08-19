Suppose We are building a banking system. We have accounts, and each account has Account no, owner, balance.
They can perform things like deposit, withdraw and check balance.

We could write this using seperate functions right. 
We could write this using separate variables and functions:
2 things -  *behaviour* and *state* 
```
int accountNumber;
string owner;
double balance;

void deposit(...);
void withdraw(...);
```


But this describes **one particular account**.

What if we have 10,000 accounts?

We need a way to describe the **structure of a BankAccount**, not one specific account.

That is where the **class** comes in.

#### class = definition of a type

A class bankaccount can say it has these things. Member function like deposit, withdraw and data member like balance etc.

So It is a user defined datatype which implements other OOPS functionality like abstraction and encapsulation. *also it uses object for the secure communication globally*

After the Definition is defined, an actual instance is created from that definiton. **That is called object**.

so BankAccount class, BankAccount a1. Means to create an object of type bank account,

These object have their behavior defined by class, for example the object of this class will have a deposit. 
but each object has its own, state that is the fundamental idea of oop that *object combine state and behaviour*.

For our account:

```
BankAccount object

STATE:
    accountNumber
    owner
    balance

BEHAVIOR:
    deposit()
    withdraw()
```

**things in class**

there are two members, data members and members and member functions.
THe data members represent the state of object. 
where as member functions represent object behaviour.

s1.study() - a is studying.

what will function do, how will it know.

compiler 




s1 => address. study function. this.


this pointer. 


student s1

s1.name = 'animesh';


object
{

name - animesh 

}

s1.setname();
name = name;
this.name= name;

so This pointer is usaully used to access the current object address implicitly and making sure to only use it when the object name and parameter name is not same.




