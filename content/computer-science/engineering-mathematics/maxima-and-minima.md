---
title: "Maxima and Minima"
topic: "engineering-mathematics"
scraped_date: [[2026-03-29]]
---

# Maxima and Minima
Maxima and Minima refer to the highest and lowest points of a function's graph, respectively, within a given domain. These points are also called turning points since the slope of the function (derivative) becomes zero at these positions.

Maximum: A point where the function's value is higher than that of all nearby points. It can be:

- Local Maximum: The function value is higher than in its immediate neighbourhood.
- Global Maximum: The function value is higher than at any other point in the domain.

Minimum: A point where the function's value is lower than that of all nearby points. It can be:

- Local Minimum: The function value is lower than in its immediate neighbourhood.
- Global Minimum: The function value is the lowest among all points in the domain.

Mathematically, for a function f(x), a point x0 is:

> A local maximum if f(x0) > f(x) for all x near x0.A local minimum if f(x0) < f(x) for all x near x0.

- A local maximum if f(x0) > f(x) for all x near x0.
- A local minimum if f(x0) < f(x) for all x near x0.

## Types of Maxima and Minima

There are two types of maxima and minima. They are listed as follows:

- Relative or Local Maxima and Minima
- Absolute or Global Maxima and Minima

## Relative Maxima and Minima

The relative maxima and minima are the maximum and minimum values which is greater than or less than its neighbor.

### Relative or Local Maxima

A function f(x) is said to have a relative maximum at x = a if there exists a neighborhood (a - δa, a + δa) of a such that

> f(x) < f(a) for all x ∈ (a-δa, a+δa), x ≠ a.

f(x) < f(a) for all x ∈ (a-δa, a+δa), x ≠ a.

Here, the point a is called the point of relative maxima of a function and f(a) is called as the relative maximum value. The relative maxima is also called as the local maxima of a function.

### Relative or Local Minima

A function f(x) is said to have a relative minimum at x = a if there exists a neighborhood (a-δa, a+δa) of a such that

> f(x) > f(a) for all x ∈ (a-δa, a+δa), x ≠ a.

f(x) > f(a) for all x ∈ (a-δa, a+δa), x ≠ a.

Here, the point a is called the point of minima of a function and f(a) is called as the relative minimum value. The relative minima is also called as the local minima of a function.

## Absolute Maxima and Absolute Minima

The Absolute Maxima and Minima is the highest or the lowest value in the entire domain of the function.

### Absolute Maxima

A function f(x) with domain D is said to be absolute maximum at x = a where a ∈ D, if f(x) ≤ f(a) for all x ∈ D. The point a is called the point of absolute maxima of function and f(a) is called as the absolute maximum value. The absolute maxima is also called as the global maxima of a function.

### Absolute Minima

A function f(x) with domain D is said to be absolute maximum at x = a where a ∈ D , if f(x) ≥ f(a) for all x ∈ D. The point a is called the point of absolute maxima of function and f(a) is called as the absolute maximum value. The absolute maxima is also called as the global maxima of a function.

## Absolute vs Relative Extrema

The difference between absolute and relative maxima and Minima is tabulated below:

| Absolute Maxima and Minima | Relative Maxima and Minima |
| --- | --- |
| It is also called as global maxima or global minima. | It is also called as local maxima or local minima. |
| It is bounded by the domain of the function. | It is not bounded by the domain of the function. |
| It is the highest or lowest point of the function. | It is the higher or lower of both two neighbours. |
| It is the global peak of the curve. | It is the local peak of the curve. |

Absolute Maxima and Minima

Relative Maxima and Minima

> Note: Extrema is the general word for maxima and minima.

Note: Extrema is the general word for maxima and minima.

## How to Find Maxima and Minima?

To find the maxima and minima of a function, we use [[calculus]] to identify critical points and determine their nature (maximum or minimum). The following are the two derivative tests to find maxima and minima.

### First Order Derivative Test

The first order derivative [[test]] as the name suggests it uses the first order derivative to find maxima and minima. The first order derivative gives the slope of the function.

Let f be a continuous function at a critical point c on the open interval l such that f'(c) = 0 then, we will check the nature of the curve. Below are some conditions after checking the nature of the curve, and x increases towards c, i.e., the critical point.

1. If the sign of f'(x) changes from positive to negative, then f(c) is the maximum value and c is the point of local maxima.
2. If the sign of f'(x) changes from negative to positive, then f(c) is the minimum value and c is the point of local minima.
3. If the sign of f'(x) neither changes from positive to negative nor from negative to positive, then c is called the point of inflection, i.e., neither maxima nor minima.

### Second Derivative Test

The second order derivative [[test]] as the name suggests it uses the second order derivative to find maxima and minima.

Let f be a function that is two times differentiable at a critical point c defined on the open interval l. The following are the conditions:

| Condition | Result |
| --- | --- |
| If f'(c) = 0 and f''(c) < 0 | c is the local maxima and f(c) is the maximum value. |
| If f'(c) = 0 and f''(c) > 0 | c is the local minima and f(c) is the minimum value. |
| If f''(c) = 0 | [[test|Test]] fails. |

Condition

Result

## Applications

- Identifying where a function's derivative is zero or undefined, which are the candidates for being the highest or lowest points on a graph.
- Minimizing material cost and weight while maximizing strength and stability in designs for bridges, beams, and buildings.
- Minimizing time for light to travel between two points (Fermat's principle), which explains refraction and reflection.
- The core of training algorithms is minimizing a loss function (which measures prediction error) to find the best model parameters (e.g., Gradient Descent).
- Using optimization for tasks like image segmentation, where the goal is to minimize the energy between different segments of an image.
- Navigation apps like Google Maps find the path that minimizes travel time or distance.

### Related Articles

> DerivativesDifferentiation FormulasApplication of Derivative

- Derivatives
- [[differentiation|Differentiation]] Formulas
- Application of Derivative

## Solved Examples on Maxima and Minima

Example 1: Find the local maxima and local minima for the function y = x3 - 3x + 2

Solution:

> y = x3 - 3x + 2Find first order derivative by differentiating yy' = (d / dx) [x3 - 3x + 2]⇒ y' = (d / dx) x3 - (d / dx) (3x) + (d / dx) 2⇒ y' = 3x2 - 3 + 0⇒ y' = 3x2 - 3Now equate y' = 0, to find the critical pointsy' = 0⇒ 3x2 - 3 = 0⇒ 3x2 = 3⇒ x2 = 1⇒ x = 1 or x = -1The critical points are x = 1 and x = -1Now we will find second derivative to check the critical point is maxima or minima.y'' = (d / dx) [3x2 - 3]⇒ y'' = (d / dx) [3x2] - (d /dx) [3]⇒ y'' = 6x - 0⇒ y'' = 6xNow we will put the values of x and find whether y'' is greater than 0 or less than 0.At x = 1,y'' = 6(1) = 6Since, y'' > 0 x = 1 is the minima of yAt x = -1y'' = 6(-1) = -6Since, y'' < 0 x = -1 is the maxima of yThe local maxima and minima of y are x = -1 and x = 1 respectively.

y = x3 - 3x + 2

Find first order derivative by differentiating y

y' = (d / dx) [x3 - 3x + 2]⇒ y' = (d / dx) x3 - (d / dx) (3x) + (d / dx) 2⇒ y' = 3x2 - 3 + 0⇒ y' = 3x2 - 3

Now equate y' = 0, to find the critical points

y' = 0⇒ 3x2 - 3 = 0⇒ 3x2 = 3⇒ x2 = 1⇒ x = 1 or x = -1

The critical points are x = 1 and x = -1

Now we will find second derivative to check the critical point is maxima or minima.

y'' = (d / dx) [3x2 - 3]⇒ y'' = (d / dx) [3x2] - (d /dx) [3]⇒ y'' = 6x - 0⇒ y'' = 6x

Now we will put the values of x and find whether y'' is greater than 0 or less than 0.

At x = 1,y'' = 6(1) = 6

Since, y'' > 0 x = 1 is the minima of y

At x = -1y'' = 6(-1) = -6

Since, y'' < 0 x = -1 is the maxima of y

The local maxima and minima of y are x = -1 and x = 1 respectively.

Example 2: Find the extremum of the function f(x) = -3x2 + 4x + 7 and the extremum value.

Solution:

> y =-3x2 + 4x + 7Find first order derivative by differentiating yy' = (d / dx) [-3x2 + 4x + 7]⇒ y' = (d / dx) (-3x2) + (d / dx) (4x) + (d / dx) 7⇒ y' = -6x + 4 + 0⇒ y' = -6x + 4Now equate y' = 0, to find the critical pointsy' = 0⇒ -6x + 4 = 0⇒ -6x = - 4⇒ x = 2 / 3The critical point is x = 2/3Now we will find second derivative to check the critical point is maxima or minima.y'' = (d / dx) [-6x + 4]⇒ y'' = (d / dx) [-6x] + (d /dx) [4]⇒ y'' = -6 + 0⇒ y'' = - 6Since, y'' < 0 x = 2 / 3 is the maxima of y and the maximum value is obtained by putting x = 2/3 in yThe local maxima of y is x = 2/3. (extremum)The maximum value of y = -3(-2/3)2 + 4(-2/3) + 7 = - 2/ 3 + 8 / 3 + 7 = 25 /3 (extremum value)

y =-3x2 + 4x + 7

Find first order derivative by differentiating y

y' = (d / dx) [-3x2 + 4x + 7]⇒ y' = (d / dx) (-3x2) + (d / dx) (4x) + (d / dx) 7⇒ y' = -6x + 4 + 0⇒ y' = -6x + 4

Now equate y' = 0, to find the critical points

y' = 0⇒ -6x + 4 = 0⇒ -6x = - 4⇒ x = 2 / 3

The critical point is x = 2/3

Now we will find second derivative to check the critical point is maxima or minima.

y'' = (d / dx) [-6x + 4]⇒ y'' = (d / dx) [-6x] + (d /dx) [4]⇒ y'' = -6 + 0⇒ y'' = - 6

Since, y'' < 0 x = 2 / 3 is the maxima of y and the maximum value is obtained by putting x = 2/3 in y

The local maxima of y is x = 2/3. (extremum)

The maximum value of y = -3(-2/3)2 + 4(-2/3) + 7 = - 2/ 3 + 8 / 3 + 7 = 25 /3 (extremum value)

Example 3: Find the maximum height when a stone is thrown at any time t and the height is given by h = -10t2 + 20t + 8.

Solution:

> To find the maximum height we will differentiate h = -10t2 + 20t + 8h' = (d /dx) [-10t2 + 20t + 8]⇒ h' = (d/dx) -10t2 + (d /dx) 20t + (d/ dx) 8⇒ h' = -20t + 20 + 0⇒ h' = -20t + 20To find the time at which height is maximum we find h' = 0⇒ -20t + 20 = 0⇒ -20t = -20⇒ t = 1Now we will find second derivative of h,h'' = -20 < 0Therefore, height is maximum at t = 1Putting value of t in h = -10t2 + 20t + 8h = -10(1)2 + 20(1) + 8⇒ h = -10 + 20 + 8⇒ h = 18The maximum height is 18 unit.

To find the maximum height we will differentiate h = -10t2 + 20t + 8

h' = (d /dx) [-10t2 + 20t + 8]⇒ h' = (d/dx) -10t2 + (d /dx) 20t + (d/ dx) 8⇒ h' = -20t + 20 + 0⇒ h' = -20t + 20

To find the time at which height is maximum we find h' = 0⇒ -20t + 20 = 0⇒ -20t = -20⇒ t = 1

Now we will find second derivative of h,h'' = -20 < 0

Therefore, height is maximum at t = 1

Putting value of t in h = -10t2 + 20t + 8

h = -10(1)2 + 20(1) + 8⇒ h = -10 + 20 + 8⇒ h = 18

The maximum height is 18 unit.

Example 4: Find the value of the function (x - 1)(x - 2)2 at its minima.

Solution:

> Let y = (x - 1)(x - 2)2⇒ y = (x - 1) (x2 + 4 - 4x)⇒ y = x3 + 4x - 4x2 - x2 - 4 + 4x⇒ y = x3 - 5x2 + 8x - 4Differentiating yy' = (d /dx) [x3 - 5x2 + 8x - 4]⇒ y' = 3x2 - 10x + 8Now we will equate y' = 0 to find the critical pointsy' = 03x2 - 10x + 8 = 0⇒ 3x2 - 6x - 4x + 8 = 0⇒ 3x (x - 2) - 4 (x - 2) = 0⇒ (x - 2)(3x - 4) = 0⇒ x = 2 or x = 4/3We will find second derivative to check point is maxima or minimay'' = (d / dx) [3x2 - 10x + 8]⇒ y'' = 6x - 10Putting x = 2, y'' = 12 - 10 = 2 > 0So, x = 2 is minima pointputting x = 4 / 3, y'' = 8 - 10 = -2 < 0So, x = 4/3 is maxima pointIn the question we have to find minima and value of y at its minimaAt x = 2⇒ y = (x - 1)(x - 2)2⇒ y = (2 - 1)(2 - 2)2⇒ y = 1 x 0 = 0 The value of y at its minima is 0.

Let y = (x - 1)(x - 2)2⇒ y = (x - 1) (x2 + 4 - 4x)⇒ y = x3 + 4x - 4x2 - x2 - 4 + 4x⇒ y = x3 - 5x2 + 8x - 4

Differentiating yy' = (d /dx) [x3 - 5x2 + 8x - 4]⇒ y' = 3x2 - 10x + 8

Now we will equate y' = 0 to find the critical points

y' = 03x2 - 10x + 8 = 0⇒ 3x2 - 6x - 4x + 8 = 0⇒ 3x (x - 2) - 4 (x - 2) = 0⇒ (x - 2)(3x - 4) = 0⇒ x = 2 or x = 4/3

We will find second derivative to check point is maxima or minima

y'' = (d / dx) [3x2 - 10x + 8]⇒ y'' = 6x - 10

Putting x = 2, y'' = 12 - 10 = 2 > 0

So, x = 2 is minima point

putting x = 4 / 3, y'' = 8 - 10 = -2 < 0

So, x = 4/3 is maxima point

In the question we have to find minima and value of y at its minima

At x = 2⇒ y = (x - 1)(x - 2)2⇒ y = (2 - 1)(2 - 2)2⇒ y = 1 x 0 = 0

The value of y at its minima is 0.

Example 5: Find the minimum value of the function 6e3x + 4e-3x

Solution:

> Let y = 6e3x + 4e-3xFind first order derivativeDifferentiating yy' = (d / dx) [6e3x + 4e-3x]⇒ y' = (d / dx) 6e3x + (d / dx) 4e-3x⇒ y' = 18e3x - 12e-3xNow equate y' = 0, to find the critical pointsy' = 0⇒ 18e3x - 12e-3x = 0⇒ 6[3e3x - 2e-3x] = 0⇒ 3e3x - 2e-3x = 0⇒ 3e3x = 2e-3x⇒ e6x = 2/3⇒ ex = (2/3)1/6⇒ x = log(2/3)1/6The critical points are x = log(2/3)1/6Now we will find second derivative to check the critical point is maxima or minima.y'' = (d / dx) [18e3x - 12e-3x]⇒ y'' = 54 e3x + 36 e-3xNow we will put the values of x and find whether y'' is greater than 0 or less than 0.At x = log(2/3)1/6Since, y'' > 0 x = log(2/3)1/6 is the minima of yThe minima of y is x = log(2/3)1/6The minimum value of y is at x = log(2/3)1/6⇒ y = 6e(1/2)ln(2/3) + 4e(-1/2)ln(2/3)⇒ y = 6(2/3)(1/2) + 4(2/3)(-1/2)⇒ y = 6√(2/3) + 4√(3/2)⇒ y = 4√6

Let y = 6e3x + 4e-3x

Find first order derivative

Differentiating y

y' = (d / dx) [6e3x + 4e-3x]⇒ y' = (d / dx) 6e3x + (d / dx) 4e-3x⇒ y' = 18e3x - 12e-3x

Now equate y' = 0, to find the critical pointsy' = 0⇒ 18e3x - 12e-3x = 0⇒ 6[3e3x - 2e-3x] = 0⇒ 3e3x - 2e-3x = 0⇒ 3e3x = 2e-3x⇒ e6x = 2/3⇒ ex = (2/3)1/6⇒ x = log(2/3)1/6

The critical points are x = log(2/3)1/6

Now we will find second derivative to check the critical point is maxima or minima.y'' = (d / dx) [18e3x - 12e-3x]⇒ y'' = 54 e3x + 36 e-3x

Now we will put the values of x and find whether y'' is greater than 0 or less than 0.

At x = log(2/3)1/6

Since, y'' > 0 x = log(2/3)1/6 is the minima of y

The minima of y is x = log(2/3)1/6

The minimum value of y is at x = log(2/3)1/6

⇒ y = 6e(1/2)ln(2/3) + 4e(-1/2)ln(2/3)⇒ y = 6(2/3)(1/2) + 4(2/3)(-1/2)⇒ y = 6√(2/3) + 4√(3/2)⇒ y = 4√6

## Practice Problems on Maxima and Minima

Question 1: Find the maximum and minimum values of the function f(x) = 2x3 - 3x2 - 12x + 1 on the interval [-2, 3].

Question 2: Determine the critical points of the function g(x) = x4 - 4x3 + 6x2 and classify them as local maxima, local minima, or saddle points.

Question 3: Consider the function h(x) = ex - 4x2. Find all the critical points and determine whether they correspond to local maxima, local minima, or neither.

Question 4: A rectangular piece of cardboard measuring 8 inches by 12 inches has squares cut out of its corners, and the sides are folded up to form an open box. Find the dimensions of the squares that should be cut out to maximize the volume of the box.

Question 5: Given the function j(x) = x3 - 12x2 + 36x + 1, find the intervals where the function is increasing and decreasing.

Question 6: Find the dimensions of a rectangular box with a square base and a surface area of 64 square inches that has the maximum possible volume.

Question 7: Determine the critical points of f(x) = x³ - 9x² + 24x - 7 and classify them as local maxima, local minima, or neither.

Question 8: A farmer wants to fence a rectangular area and then divide it into two equal parts with a fence parallel to one of the sides. If the farmer has 1000 feet of fencing, what dimensions will maximize the total area enclosed?

Question 9: Find the points on the curve y = x³ - 3x that are closest to the point (0, 2).

Question 10: A cylindrical can is to be made to hold 1 liter of liquid. Determine the dimensions that will minimize the amount of material used to construct the can.