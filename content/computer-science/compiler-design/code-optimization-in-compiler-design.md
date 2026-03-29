---
title: "Code Optimization in Compiler Design"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# Code Optimization in Compiler Design
Code optimization is the process of improving a program to make it more efficient in terms of speed, memory, and resource usage, without changing its functionality. The key aspects of code optimization include:

- Improved performance: Optimized code executes faster and uses fewer resources.
- Reduced code size: Smaller code is easier to distribute and deploy.
- Increased portability: Optimized code can run efficiently on multiple platforms.
- Lower power consumption: Efficient code uses less energy, making it more energy-friendly.
- Better maintainability: Well-optimized code can be easier to read and maintain.
- Reasonable compilation time: Optimization should not make compilation excessively slow.
- Correctness assurance: Optimization must preserve the program’s original behavior and logic.
- Manageable complexity: Code optimization may increase complexity, but the program should remain easy to understand, maintain, and debug.

## When to Optimize?

Optimization of the code is often performed at the end of the development stage since it reduces readability and adds code that is used to increase performance.

## Why Optimize?

Algorithm optimization is beyond the scope of the code optimization phase. Instead, the compiler optimizes the intermediate program code, which may also reduce the size of the generated code. Therefore, code optimization helps to:

- Reduce memory usage and code size.
- Improve program execution speed.
- Automatically optimize code using a compiler optimizer, since manual optimization is difficult and time-consuming.

## Types of Code Optimization

- Machine Independent Optimization: Improves the intermediate code to produce more efficient target code. It is performed without considering the target machine architecture. The transformations do not involve CPU registers or absolute memory addresses.

- Machine Dependent Optimization: Performed after the target code is generated. It optimizes the code according to the specific architecture of the target machine. This type of optimization uses CPU registers and may involve absolute memory references to take better advantage of the memory hierarchy and hardware features.

## Ways to Optimize Code

There are several ways to optimize code. Some of them are mentioned below.

### 1. Compile Time Evaluation:

Expressions evaluated during compilation.

`// Before Optimization
A = 2 * (22.0 / 7.0) * r

// After Optimization
A = 6.2857 * r
`

```
// Before Optimization
A = 2 * (22.0 / 7.0) * r

// After Optimization
A = 6.2857 * r

```

### 2. Variable Propagation:

Replaces a variable with another variable having the same value.

`// Before Optimization
x = a
y = x + 5

// After Optimization
y = a + 5
`

```
// Before Optimization
x = a
y = x + 5

// After Optimization
y = a + 5

```

### 3. Constant Propagation:

Replaces variables with their constant values.

Example:

`// Before Optimization
a = 10
b = a + 5

// After Optimization
a = 10
b = 10 + 5
`

```
// Before Optimization
a = 10
b = a + 5

// After Optimization
a = 10
b = 10 + 5

```

### 4. Constant Folding:

Computes constant expressions at compile time.

Example:

`#define k 5
x = 2 * k  
y = k + 5
  
This can be computed at compile time and the values of x and y are : 
 x = 10
 y = 10
`

```
# define k 5
x = 2 * k  
y = k + 5
  
This can be computed at compile time and the values of x and y are : 
 x = 10
 y = 10

```

### 5. Copy Propagation:

- It is extension of constant propagation.
- Replaces copied variables with the original variable.

Example :

```
     //Before Optimization 
     c = a * b                                               
     x = a                                                  
     till                                                           
     d = x * b + 4 

    
     //After Optimization 
     d = a * b + 4

```

### 6. Common Sub Expression Elimination:

Avoids repeated calculation of the same expression.

`// Before Optimization
t1 = a * b
t2 = a * b + c

// After Optimization
t1 = a * b
t2 = t1 + c
`

```
// Before Optimization
t1 = a * b
t2 = a * b + c

// After Optimization
t1 = a * b
t2 = t1 + c

```

### 7. Dead Code Elimination:

Removes code that is never used.

Example:

`// Before Optimization
x = 10
y = 20
print(y)

// After Optimization
y = 20
print(y)
`

```
// Before Optimization
x = 10
y = 20
print(y)

// After Optimization
y = 20
print(y)

```

### 8. Unreachable Code Elimination:

Removes code that will never execute.

```
# include <iostream>
using namespace std;

int main() {
  int num;
  num=10;
    cout << "GFG!";
    return 0;
  cout << num; //unreachable code
}
//after elimination of unreachable code
int main() {
  int num;
  num=10;
    cout << "GFG!";
    return 0;
 }

```

### 9. Function Inlining:

Replaces a function call with its body.

`// Before Optimization
sum(a,b){
   return a + b
}
x = sum(2,3)

// After Optimization
x = 2 + 3
`

```
// Before Optimization
sum(a,b){
   return a + b
}
x = sum(2,3)

// After Optimization
x = 2 + 3

```

### 10. Function Cloning:

- Here, specialized codes for a function are created for different calling parameters.
- Example: Function Overloading

```
// Before Optimization
int add(int a, int b){
    return a + b;
}

int x = add(2,3);
float y = add(4,5);
// After Optimization (Function Cloning)
int add_int(int a, int b){
    return a + b;
}

float add_float(float a, float b){
    return a + b;
}

int x = add_int(2,3);
float y = add_float(4,5);

```

### 11. Induction Variable :

Uses variables that change regularly in loops.

Examples:

`// Before Optimization
for(i = 0; i < n; i++){
    x = 4 * i;
    print(x);
}
// After Optimization
x = 0;
for(i = 0; i < n; i++){
    print(x);
    x = x + 4;
}
`

```
// Before Optimization
for(i = 0; i < n; i++){
    x = 4 * i;
    print(x);
}
// After Optimization
x = 0;
for(i = 0; i < n; i++){
    print(x);
    x = x + 4;
}

```

### 12. Strength Reduction:

Replaces costly operations with cheaper ones.

`// Before Optimization
x = y * 2

// After Optimization
x = y + y
`

```
// Before Optimization
x = y * 2

// After Optimization
x = y + y

```

## Loop Optimization Techniques

### 1. Code Motion (Frequency Reduction)

This technique reduces the number of times an expression is evaluated by moving loop-invariant statements outside the loop.

Example:

`// Before Optimization
for(i = 0; i < n; i++){
    x = a * b;
    y[i] = x + i;
}

// After Optimization
x = a * b;
for(i = 0; i < n; i++){
    y[i] = x + i;
}
`

```
// Before Optimization
for(i = 0; i < n; i++){
    x = a * b;
    y[i] = x + i;
}

// After Optimization
x = a * b;
for(i = 0; i < n; i++){
    y[i] = x + i;
}

```

### 2. Loop Jamming

Two or more loops are combined in a single loop to helps in reducing the compile time.

Example:

```
// Before Optimization
for(i = 0; i < n; i++){
    a[i] = b[i] + c[i];
}

for(i = 0; i < n; i++){
    d[i] = e[i] + f[i];
}

// After Optimization
for(i = 0; i < n; i++){
    a[i] = b[i] + c[i];
    d[i] = e[i] + f[i];
}

```

### 3. Loop Unrolling

This technique reduces the number of loop iterations by performing multiple operations in a single iteration, which decreases loop control overhead.

Example:

`// Before Optimization
for(i = 0; i < 4; i++){
    a[i] = a[i] * 2;
}

// After Optimization
a[0] = a[0] * 2;
a[1] = a[1] * 2;
a[2] = a[2] * 2;
a[3] = a[3] * 2;
`

```
// Before Optimization
for(i = 0; i < 4; i++){
    a[i] = a[i] * 2;
}

// After Optimization
a[0] = a[0] * 2;
a[1] = a[1] * 2;
a[2] = a[2] * 2;
a[3] = a[3] * 2;

```

## Where to Apply Optimization?

Code optimization can be applied at different stages of program execution and compilation to improve performance and efficiency.

1. Source Program Level Optimization at the source program level involves modifying the algorithm or program structure, such as improving loop structures or reducing unnecessary computations. Here, the programmer (user) performs the optimization.

2. Intermediate Code Level At this stage, the compiler optimizes the intermediate representation of the program. This may include improving address calculations and optimizing procedure calls.

3. Target Code Level Optimization is performed on the generated machine code. The compiler improves the use of CPU registers, instruction selection, and instruction movement to produce efficient target code.

### Optimization Based on Program Scope

| Type | Description | Techniques Used |
| --- | --- | --- |
| Local Optimization | Applied to small basic blocks of statements. | Local Value Numbering, Tree Height Balancing |
| Regional Optimization | Applied to Extended Basic Blocks. | Super Local Value Numbering, Loop Unrolling |
| Global Optimization | Applied to large program sections such as functions and loops. | Live Variable Analysis, Global Code Replacement |
| Interprocedural Optimization | Applied across multiple procedures or functions. | Inline Substitution, Procedure Placement |