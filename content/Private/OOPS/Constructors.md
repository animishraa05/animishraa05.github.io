

**Problem**
- In an object which has independent state,we have to understand what is it that defines the inital state of it as it is independent of the class behaviour.

#### Solution

class Student {
public:
    string name;
    int age;
};

Student s1;
Student animesh;

*constructor is a special member function which is called when an object is created*

**Constructor Properties**
- Constructor has no return type like function.
- THe name of constructor is same as class name.


3 types- non parameterised. default. parameterised

**Default constructor-**

A default constructor is automatically created by the compiler even if no constructor is defined.
It takes no arguments and does not have a body.
IT DOES NOT GENERATE IF PROGRAMMER DEFINES A CONSTRUCTOR.

**Parameterised Constructor**
Parameterised constructor is nothing but a constructor which initialises a value in an object itself and we can create an object with initialised value in it. Using this we can pass argument inside a constructor and call the function on it

class student{
int name;

student(string name1){
name = name1;
};

student s1(ani);

This will create an object with creation and initialisation.











