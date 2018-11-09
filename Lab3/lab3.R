# ex1
get_observations = function(m, a, b, xmin, xmax, sigma) {
  x = runif(n=m, min=xmin, max=xmax)
  a+b*x+rnorm(n=m, mean=0, sd=sigma)
  data.frame(x=x, y=a+b*x+rnorm(n=m, mean=0, sd=sigma))
}
observations = get_observations(10, 5, 1, -5, 5, 3)
observations

# ex2
regression_parameters = function(observations) {
  x_mean = mean(observations$x)
  y_mean = mean(observations$y)
  n = length(observations$x)
  
  b = sum((observations$x - x_mean)*(observations$y - y_mean) ) / sum((observations$x-x_mean) ** 2)
  a = y_mean - b* x_mean
  
  y_estimated = a+b*observations$x
  sse = sum((observations$y-y_estimated)^2)
  
  s2 = sse/(n-2)
  sx = sqrt(var(observations$x))

  b_se = sqrt(s2)/((sqrt(n-1))*sqrt(var(observations$x)))
  a_se = sqrt(s2)*sqrt(1/n+(x_mean^2)/sum(observations$x^2))

  b_error <- qt(0.975,df=n-2)*b_se
  a_error <-  qt(0.975,df=n-2)*a_se
  
  # data.frame(a=a, b=b, b_lwr=b-b_error, b_upr=b+b_error, a_lwr=a-a_error, a_upr=a+a_error, t_b=b/b_se, t_a=a/a_se)
  data.frame(params=c(a,b), lwr=c(a-a_error, b-b_error), upr=c(a+a_error, b+b_error), t=c(a/a_se, b/b_se))
}
params = regression_parameters(observations)
params

g <- lm(observations$y ~ observations$x)
summary(g)
confint(g, level=0.95)

# ex3
plot_regression = function(m, xmin, xmax, sigma) {
  a = 3
  b = 5
  
  pdf(sprintf("regression-%s-%s-%s-%s.pdf",m,xmin,xmax,sigma))
  
  observations = get_observations(m, a, b, xmin, xmax, sigma)
  r = regression_parameters(observations)
  plot(observations$x, observations$y, pch=19, 
       main=sprintf("Regression lines for %s points, between %s and %s, with sd %s", m, xmin, xmax, sigma),
       xlab="X", 
       ylab="Y"
       )
  abline(r$params[1], r$params[2], lwd=1, col="red")
  abline(a, b, lwd=1, col="blue", lty=5)
  legend("topleft", legend=c("Estimated Y", "Sample Y"), col=c("red", "blue"), lty=1:5, cex=0.8)
  dev.off()
}

plot_regression(100, -200, 200, 1.5)
plot_regression(10, -5, 5, 1)
plot_regression(10000, -5, 5, 1)
plot_regression(10, 5, 5.2, 1)
plot_regression(10000, 5, 5.2, 1)
plot_regression(10, 5, 5.2, 0.01)


