---
title: "Laplace Transform"
topic: "engineering-mathematics"
scraped_date: [[2026-03-29]]
---

# Laplace Transform
Laplace transform is an integral transform used in mathematics and engineering to convert a function of time f(t) into a function of a complex variable s, denoted as F(s), where s = \sigma+\iota\omega.

Let us assume f(t) is a function, be it a real or complex function of the variable t>0, where t is time. Then, the Laplace transform F(s) of f(t) is the complex function defined for s\in \Complex, given by:

> F(s) = \mathcal{L}\{f(t)\} = \int_{0}^{\infty} e^{-st} f(t) \, dt

F(s) = \mathcal{L}\{f(t)\} = \int_{0}^{\infty} e^{-st} f(t) \, dt

where s = \sigma + i\omega.

### Standard Notation:

If a function of t is indicated as f(t), f(t),g(t), or y(t), then their respective Laplace transforms are represented by F(s), G(s) and Y(s). Besides the notation F(s), we can also use \mathcal{L}\{f(t)\} or \mathcal{L}\{f\}(s).

### Laplace transforms of some elementary functions:

| Function f(t) | Laplace Transform \mathcal{L}\{f(t)\} =F(s) |
| --- | --- |
| 1 | \frac{1}{s};\,s>0 |
| t | \frac{1}{s^2};\,s>0 |
| t^n\\n = 0,1,2,... | \frac{n!}{s^n+1};\,s>0 |
| e^{at} | \frac{1}{s-a};\,s>a |
| \sin at | \frac{a}{s^2+a^2};\,s>0 |
| \cos at | \frac{s}{s^2+a^2};\,s>0 |
| \sinh at | \frac{a}{s^2-a^2};\,s>|a| |
| \cosh at | \frac{s}{s^2-a^2};\,s>|a| |

Function f(t)

Laplace Transform \mathcal{L}\{f(t)\} =F(s)

\frac{1}{s};\,s>0

\frac{1}{s^2};\,s>0

t^n\\n = 0,1,2,...

\frac{n!}{s^n+1};\,s>0

e^{at}

\frac{1}{s-a};\,s>a

\sin at

\frac{a}{s^2+a^2};\,s>0

\cos at

\frac{s}{s^2+a^2};\,s>0

\sinh at

\frac{a}{s^2-a^2};\,s>|a|

\cosh at

\frac{s}{s^2-a^2};\,s>|a|

### Existence of the Laplace Transform

Here are some definitions before delving into the sufficient conditions for the existence of the Laplace transform:

- Sectional Continuity: A function is said to be sectionally or piecewise continuous in an interval t_1\le t\le t_2 if that interval can be subdivided into a finite number of subintervals, in each of which the function is continuous and has finite left- and right-hand limits.
- Functions of Exponential Order: If real constants k>0 and \gamma exist such that for all t>N, the function f(t) satisfies the condition |f(t)|\le ke^{\gamma t}, then f(t) is said to be of exponential order \bm\gamma.

#### Sufficient Condition for Existence of Laplace Transform:

If f(t) is sectionally continuous in every finite interval 0\le t\le N and of exponential order \bm\gamma for \bm{t>N}, then its Laplace transform F(s) exists for all \bm{s>\gamma}.

## Important Properties of Laplace Transformation:

- Linearity
- Shifting
- Change of Scale
- Laplace Transforms of Derivatives
- Laplace Transforms of Integrals
- Multiplication by t^n
- Division by t
- Laplace Transform of a Periodic function
- Behavior of F(s) as s\to\infty
- Initial value theorem
- Final value theorem
- Convolution theorem for Laplace transform

### Linearity

If c_1 and c_2 are two constants, while f_1(t) and f_2(t) are functions, and F_1(s) and F_2(s) are their respective Laplace transforms, then:

> \begin{aligned}\mathcal{L}\{c_1f_1(t) +c_2f_2(t)\} &= c_1\mathcal{L}\{f_1(t)\}+c_2\mathcal{L}\{f_2(t)\}\\&=c_1F_1(s) +c_2F_2(s)\end{aligned}

\begin{aligned}\mathcal{L}\{c_1f_1(t) +c_2f_2(t)\} &= c_1\mathcal{L}\{f_1(t)\}+c_2\mathcal{L}\{f_2(t)\}\\&=c_1F_1(s) +c_2F_2(s)\end{aligned}

### Shifting

It constitutes of two properties

1. First shifting property: If \mathcal{L}\{f(t)\}=F(s), then \mathcal{L}\{e^{at}f(t)\}=F(s-a).
2. Second Shifting property: If \mathcal{L}\{f(t)\}=F(s) and g(t)=\begin{cases} f(t-a)\quad&; {t>a}\\ 0 \quad&;{t<a} \end{cases}, then \mathcal{L}\{g(t)\}=e^{-as}F(s).

### Change of Scale

If f(t) is a function and F(s) is its Laplace transform, and c is a constant, then \mathcal{L}\{f(at)\}=\frac{1}{a}F(\frac{s}{a}).

### Laplace Transform of Derivatives

1. If \mathcal{L}\{f(t)\}=F(s), then \mathcal{L}\{f'(t)\}=sF(s)-f(0), where f(t) is continuous for 0\le t\le N and of exponential order \gamma, and its derivative f'(t) is sectionally continuous for 0\le t\le N.
2. If f(t) fails to be continuous at t=0 but \lim\limits_{t\to0}f(t)=f(0^+), then \mathcal{L}\{f'(t)\}=sF(s)-f(0^+).
3. If f(t) fails to be continuous at t=a, then \mathcal{L}\{f'(t)\}=sF(s)-f(0)-e^{-as}\{f(a^+)-f(a^-)\}
4. If \mathcal{L}\{f(t)\}=F(s), then \mathcal{L}\{f^{(n)}(t)\}=s^nF(s)-s^{n-1}f(0)-s^{n-2}f'(0)-...-f^{(n-1)}(0), where f(t),\,f'(t),\,f''(t),\,...\,,f^{(n-1)}(t) are continuous for 0\le t\le N and of exponential order for t>N while f^{(n)}(t) is sectionally continuous for 0\le t\le N.

### Laplace Transform of Integrals:

If \mathcal{L}\{f(t)\} =F(s), then \mathcal{L}\{\int\limits_0^t f(v)dv\}=\frac{F(s)}{s}.

### Multiplication by t^n

If \mathcal{L}\{f(t)\} = F(s), then \mathcal{L}\{t^nf(t)\} = (-1)^n \frac{d^n}{ds^n}F(s), where \frac{d^n}{ds^n} denotes the n-th derivative.

### Division by t

If \mathcal{L}\{f(t)\} = F(s), then \mathcal{L}\{\frac{f(t)}{t}\} = \int\limits_{s}^{\infty}f(v)dv.

### Laplace Transform of Periodic functions

Let a function f(t) be periodic with period T>0, such that f(t+T)=f(t). Then \mathcal{L}\{f(t)\}=\frac{\int\limits_0^T e^{-st}f(t)dt}{1-e^{-sT}}.

### Behavior of F(s) as s\to\infty

If \mathcal{L}\{f(t)\}=F(s), then \lim\limits_{s\to\infty}F(s)=0.

### Initial Value Theorem

Let f(t) be a sectional continuous with Laplace transform F(s). Then \lim\limits_{s\to\infty}sF(s) = f(0^+), where the limit s\to\infty has to be taken in such a way that the real part of s, Re s \to\infty as well.

### Final Value Theorem

Let f(t) be a sectional continuous with Laplace transform F(s). When f(\infty) =\lim\limits_{t\to\infty}f(t) exists, then \lim\limits_{s\to0}sF(s) = f(\infty), where the limit s\to0 has to be taken in such a way that the real part of s, Re(s) \to0 as well.

### Convolution Theorem for Laplace Transform

Let f(t) and g(t) be piecewise continuous and of exponential order \gamma with their Laplace transforms F(s)=\mathcal{L}\{f(t)\} and G(s)=\mathcal{L}\{g(t)\}, respectively. Then \mathcal{L}\{f*g\} exists for Re(s)>\gamma and \mathcal{L}\{f*g\}=F(s)\cdot G(s).

## Inverse Laplace Transformation:

If the Laplace transform of a function f(t) is F(s), i.e., if \mathcal{L}\{f(t)\}=F(s), then f(t) is called the inverse Laplace transform of F(s), and we write it symbolically as f(t)=\mathcal{L}^{-1}\{F(s)\} where \mathcal{L^{-1}} is called the inverse Laplace transformation operator.

- Example: Find the inverse Laplace transform of F(s)=\frac{1}{s+3}.We know that \mathcal{L}\{e^{at}\}=\frac{1}{s-a}, s>a. Then, \mathcal{L^{-1}}\{\frac{1}{s-a}\}=e^{at}. Similarly, \mathcal{L^{-1}}\{\frac{1}{s+3}\}=e^{-3t}.

## Bilateral Laplace Transform

The bilateral Laplace transform involves the values of a function for both t<0 and t\ge0. This means that the bilateral Laplace transform is well-suited for non-causal signals and functions. If f(t) is the function and F(s) is its bilateral Laplace transform, then F(s) is given by:

> F(s) = \int_{-\infty}^{\infty} f(t) e^{-st}dt

F(s) = \int_{-\infty}^{\infty} f(t) e^{-st}dt

## Applications of Laplace Transform

Various applications of the Laplace transform include:

- The Laplace transform can be used to find the transfer function of linear time-invariant continuous-time systems: In linear time-invariant continuous-time systems (LTI systems), h(t) is the impulse response. The system function, or transfer function, H(s), of the LTI system is the Laplace transform of h(t).

- Laplace transform can be used to solve differential equation problems, including initial value problems. In an initial value problem, the solution to a differential equation is determined by the initial conditions of the system, such as the initial values of the function and its derivatives.

- Let H(s) be the transfer function of a causal LTI system described by the following differential equation:a_n \frac{d^n y(t)}{dt^n} + a_{n-1} \frac{d^{n-1} y(t)}{dt^{n-1}} + \cdots + a_1 \frac{dy(t)}{dt} + a_0 y(t) = b_m \frac{d^m x(t)}{dt^m} + b_{m-1} \frac{d^{m-1} x(t)}{dt^{m-1}} + \cdots + b_1 \frac{dx(t)}{dt} + b_0 x(t) satisfying the following condition of initial rest,y(0)=y'(0)=y''(0)=...=y^{m-2}(0)=y^{m-1}(0)=0 Then the system is stable if and only if the poles of H(s) lie in the left half-plane Re(s)<0.

- Laplace transform can be applied to analyze electrical circuits, simplifying the process of solving circuits with capacitors, inductors, and resistors by converting the time-domain equations into s-domain equations.

- Laplace transform is used in probability theory to find the distribution of sums of random variables and to solve problems related to stochastic processes. For example: Transforming Probability Density Functions (PDFs). The Laplace transform can be used to transform the probability density function (PDF) of a random variable. For a non-negative random variable X with PDF f_X(x), the Laplace transform is\mathcal{L}\{f_X(x)\} = F(s) = \int_0^\infty e^{-sx} f_X(x) \, dx.

### Related Articles:

> Laplace Transform Practice QuestionsInverse Laplace TransformFourier Transform

- Laplace Transform Practice Questions
- Inverse Laplace Transform
- Fourier Transform