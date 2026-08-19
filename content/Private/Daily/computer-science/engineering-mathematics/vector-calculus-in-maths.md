---
title: "Vector Calculus in Maths"
topic: "engineering-mathematics"
scraped_date: [[2026-03-29]]
---

# Vector Calculus in Maths
Vector Calculus in maths is a subdivision of [[calculus|Calculus]] that deals with the [[differentiation]] and [[integration]] of Vector Functions. We already know that [[calculus|Calculus]] is a branch of mathematics that deals with the rate of change of a function with respect to another function. There are two major divisions of [[calculus|Calculus]], namely, Differential [[calculus|Calculus]] and Integral [[calculus|Calculus]].

The branch of Differential [[calculus|Calculus]] deals with the process of finding derivatives or [[differentiation]] of functions, while Integral [[calculus|Calculus]] deals with finding the antiderivative of a function whose derivative is given

![Vector-calculus](images_vector-calculus.webp)

The vector fields are the vector functions whose domain and range are not dimensionally related to each other. The branch of Vector [[calculus|Calculus]] corresponds to the multivariable [[calculus]] which deals with partial [[differentiation]] and multiple [[integration]]. This [[differentiation]] and [[integration]] of vectors is done for a quantity in 3D physical space represented as R3. For n-dimensional space, it is represented as Rn.

Vector [[calculus|Calculus]] is often called Vector Analysis, deals with vector quantities, i.e., the quantities that have both magnitude as well as direction. Since we know that Vector [[calculus|Calculus]] deals with [[differentiation]] and [[integration]] of functions, there are three types of integrals dealt with in Vector [[calculus|Calculus]] that are

- Line Integral
- Surface Integral
- Volume Integral

### Line Integral

Line Integral in mathematics is the [[integration]] of a function along a line of the curve. The function can be a scalar or vector whose line integral is given by summing up the values of the field at all points on a curve weighted by some scalar function on the curve. Line Integral is also called Path Integral and is represented by Φ = ∫Lf. Line Integral has its application in physics. For Example, Work Done by Force is along a path given as W = ∫LF(s).ds because we know that work done is given as the product of force and distance covered.

### Surface Integral

Surface Integral in mathematics is the [[integration]] of a function along the whole region or space that is not flat. In Surface integral, the surfaces are assumed of small points hence, the [[integration]] is given by summing up all the small points present on the surface. The surface integral is equivalent to the double [[integration]] of a line integral. Surface Integral has got its application in Electromagnetism and many more branches of physics where the vector function is spread over the surface. Surface Integral is represented as ∬sf(x,y)dA.

### Volume Integral

A volume integral, also known as a triple integral, is a mathematical concept used in [[calculus]] and vector [[calculus]] to calculate the volume of a three-dimensional region within a space. It is an extension of the concept of a definite integral in one dimension to three dimensions.

Mathematically, the volume integral of a scalar function f(x, y, z) over a region R in three-dimensional space is denoted as:

> \bold{\iiint_R f(x, y, z) \ dV} Where dV represents an infinitesimal volume element, and Integral is taken over region R.

\bold{\iiint_R f(x, y, z) \ dV}

Where

- dV represents an infinitesimal volume element, and
- Integral is taken over region R.

## Operation in Vector

The different operations performed with vector quantities are tabulated below with their notation and illustration.

| Operation | Notation | Illustration |
| --- | --- | --- |
| Vector Addition | r1 + r2 | Addition of two vectors gives a vector |
| Scalar Multiplication | q.r1 | Multiplying a vector 'r1' with scalar 'q' result in a vector |
| Dot Product | r1 · r2 | Dot product of two vectors gives a scalar |
| Cross Product | r1 ⨯ r2 | Cross product of two vectors gives a vector |
| Scalar Triple Product | r1 · (r2 ⨯ r3) | Dot Product of Cross product of two vectors |
| Vector Triple Product | r1 ⨯ (r2 ⨯ r3) | Cross Product of Cross Product of two Vectors |

Vector Addition

r1 + r2

Scalar Multiplication

q.r1

Dot Product

r1 · r2

Cross Product

r1 ⨯ r2

Scalar Triple Product

r1 · (r2 ⨯ r3)

Vector Triple Product

r1 ⨯ (r2 ⨯ r3)

## Divergence and Curl

Divergence and Curl are two important operators used in Vector [[calculus|Calculus]].

- Divergence is a scalar operator which tells about the behaviour of a function towards or away from a point.
- Curl is a vector operator which tells about the behaviour of a function around a point.
- The vector operator is represented by ∇ which accounts for the partial [[differentiation]] of the vector field.
- The Vector Differential Operator (∇) also called Nabla is expressed as ∇ = ∂/∂x i + ∂/∂y j + ∂/∂z k.

### Divergence of Vector

If a vector field is given by f(x,y,z) = fxi + fyj + fzk then its divergence is given by taking the scalar of the vector operator is given by

div(f) = ∇.f(x,y,z) = (∂/∂x i + ∂/∂y j + ∂/∂z k) · (fxi + fyj + fzk )

⇒ ∇.f(x,y,z) = ∂x/∂x + ∂y/∂y + ∂z/∂z.

### Curl of Vector

If a vector field is given by f(x,y,z) = fxi + fyj + fzk then its curl is given by taking the vector of the vector operator

∇ × f(x,y,z) = (∂/∂x i + ∂/∂y j + ∂/∂z k) ⨯ (fxi + fyj + fzk )

⇒ ∇ × f(x,y,z) = \begin{vmatrix} i & j & k \\ \partial /\partial x& \partial /\partial y & \partial /\partial z \\ f_{x} & f_{y} & f_{z} \\ \end{vmatrix}

⇒ ∇ × f(x,y,z) = (∂z/∂y - ∂y/∂z)i + (∂x/∂z - ∂z/∂x)j + (∂y/∂x - ∂x/∂y).

### Gradient of Scalar

The gradient of a scalar field F is given by grad(F) or ∇ F. It gives the measurement of the rate and direction of a scalar-valued function. In the Cartesian system, the gradient of a scalar-valued function is given by

> ∇ F = (∂/∂x i + ∂/∂y j + ∂/∂z k)F = ∂/∂x i + ∂/∂y j + ∂/∂z k

∇ F = (∂/∂x i + ∂/∂y j + ∂/∂z k)F = ∂/∂x i + ∂/∂y j + ∂/∂z k

## Vector Calculus Formulas

For a vector field given as F(x,y,z) = p(x,y,z)i + q(x,y,z)j + r(x,y,z)k. The following formulas are given.

### Fundamental Theorem of Line Integral

if F = ∇Φ and Curve C has A and B endpoints then its line integral is given as

> ∫cF.dr = Φ(B) - Φ(A)

∫cF.dr = Φ(B) - Φ(A)

### Circulation Curl Form

There are two theorems under Circulation Curl Form, namely the Green theorem and Stokes theorem.

- Green Theorem: If D is the region bounded by curve C then, ∮cF.dr = ∬D(∂Q/∂x - ∂P/∂y)dA
- Stoke's Theorem: For a surface S bounded by curve C stokes theorem given by ∮cF.dr = ∬S(∇ ⨯ F)dS

### Flux Divergence Theorem

- The Flux Divergence Form of Green's Theorem is given as ∬D∇. F dA = ∮cF.n ds
- The Flux Divergence Form of Stoke's Theorem is given as ∭D ∇. F dV = ∯sF.n dσ

## Vector Calculus Applications

Vector [[calculus|Calculus]] or vector analysis has a number of applications in the real world:

- Navigation
- Sports
- Partial differential equation
- Three-dimensional geometry
- Used in heat transfer

### Related Articles

- Implicit [[differentiation|Differentiation]] in [[calculus|Calculus]]
- How to find Derivatives?
- Vector Algebra