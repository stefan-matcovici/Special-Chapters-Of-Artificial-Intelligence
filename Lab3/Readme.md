# Second Homework
## This homework was about implementing my own simple regression parameter estimator similar to the lm function in R
---

## Write a function R that generates the observation for a simple regression model using the formula:
![formula](https://latex.codecogs.com/gif.latex?y_i&space;=&space;a&space;&plus;&space;b*x_i&space;&plus;&space;\varepsilon_i,&space;i&space;=&space;1,&space;...,&space;m.)

The error distribution is ![aprox](https://latex.codecogs.com/gif.latex?\varepsilon_i&space;\sim&space;N(0,&space;\sigma^2)). The values ​​of x are evenly generated from the range [xmin, xmax]. The values ​​of y are obtained using the above ratio. Function parameters are m, a, b, xmin, xmax and sigma.

---

## Consider the simple regression model y = a + b*x + ε. Write a function R that receives at the input of the observation of the model (2) and computes the estimated values and b of the regression coefficients and their 95% confidence intervals.

### Using the above functions, determine the coefficients and their confidence intervals of 95%. Plot the graph of the estimated and real data in the cases a = 3, b = 5 with different number of points standard deviation and spread of the values determined by the experiment:
![][1]
![][2]
![][3]
![][4]
![][5]
![][6]

---

### From these plots we can observe how a simple regression can be improved. This can be mainly achieved by:
1. reducing σ, the inherent variability of the Y observations.
1. increasing the sample size n.
1. increasing the spread of the X values which are determined by the experiments (survey).

[1]: regression-100--200-200-1.5.png
[2]: regression-10--5-5-1.png
[3]: regression-10000--5-5-1.png
[4]: regression-10-5-5.2-1.png
[5]: regression-10000-5-5.2-1.png
[6]: regression-10-5-5.2-0.01.png