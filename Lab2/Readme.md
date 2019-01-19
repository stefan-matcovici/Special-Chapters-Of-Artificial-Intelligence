# Second Homework
## This homework was about plotting in R and understanding common statistical distributions
---

## Write a function R that displays the function graph ![function](https://latex.codecogs.com/gif.latex?f(x)&space;=&space;2^x) over a specified range [a, b]. It will use the red color for the line graph.
![][twos]

---

## Plot the graphs corresponding to the binomial distribution B (n, x, p) for n = 20 and p = 0.1, 0.2,. . . , 0.9. It will generate a single file (.PDF, .PNG or .EPS) for each graph.

![][binom7] ![][binom2]

---

## Draw the graphs corresponding to the normal distribution ![distribution](https://latex.codecogs.com/gif.latex?N(\mu&space;,&space;\sigma&space;^{2})), on [-20, 20] for μ = 0 and σ = 0.1, 1, 10. A file (.PDF, .PNG or .EPS) will be generated for each graph.

![][dnorm100] ![][dnorm1]

---

## Write a function that generates a number of 1000 samples, ![numbers](https://latex.codecogs.com/gif.latex?v_{1}$,&space;...,&space;$v_{1000}), each sample ![vi](https://latex.codecogs.com/gif.latex?v_{1}) (i = 1, ..., 1000) of dimension n, using the uniform distribution with values ​​of the interval [-10,10]. The sample size n is the parameter of the function. The function returns the vector the averages of the 1000 samples ![numbers](https://latex.codecogs.com/gif.latex?v_{1}$,&space;...,&space;$v_{1000}), where ![mean](https://latex.codecogs.com/gif.latex?v_i&space;=&space;mean(v_i)). Call this function CLT. Use this function to build the histogram of the averages of the 1000 samples when their size n is equal to 1.
### This exercise was to prove in a graphical way the **Central Limit Theorem** which states that if ![nnumbers](https://latex.codecogs.com/gif.latex?x_1,&space;x_2,&space;...,&space;x_n) is a random sample of size n from any distribution with mean µ and variance σ then the sample mean ![mean](https://latex.codecogs.com/gif.latex?\overline{x}&space;=&space;\frac{1}{n}&space;*&space;\sum_{i=1}^{n}x_i) has an approximate normal distribution with mean µ and variance ![variance](https://latex.codecogs.com/gif.latex?\frac{\sigma&space;^2}{n}). That is, approximately ![approx](https://latex.codecogs.com/gif.latex?\overline{X}&space;\approx&space;N(\mu&space;,&space;\frac{\sigma&space;^2}{n})). The approximation gets better for large n.

![][clt1]  ![][clt100]


[twos]: ./png/exponential2.png "2^n"

[binom7]: ./png/dbinom-20-7.png "binom(20, 0.7)"
[binom2]: ./png/dbinom-20-2.png "binom(20, 0.2)"

[dnorm100]: ./png/dnorm-20-1.png "dnorm(20,1)"
[dnorm1]: ./png/dbinom-20-2.png "dnorm(20,1)"

[clt1]: ./png/clt1.png "clt10"
[clt100]: ./png/clt100.png "clt100"