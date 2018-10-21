# ex1
twos = function (a, b) {
  curve(2 ^ x, from=a, to=b, main=sprintf("f(x)=2^x, x in [%d, %d]", a, b))
}

twos(5, 10)

# ex2
dir.create(file.path(getwd(), "png"), showWarnings = FALSE)
dir.create(file.path(getwd(), "pdf"), showWarnings = FALSE)
dir.create(file.path(getwd(), "eps"), showWarnings = FALSE)

probabilities = seq(0.1, 0.9, by=0.1)
n = 20
for (p in probabilities) {
  x <- seq(0, n, by = 1)
  png(file = sprintf("png/dbinom-%d-%.0f.png", n, p*10))
  pdf(file = sprintf("pdf/dbinom-%d-%.0f.pdf", n, p*10))
  setEPS()
  postscript(sprintf("eps/dbinom-%d-%.0f.eps", n, p*10))
  plot(x, dbinom(x, n, p), type="l", main=sprintf("Binomial Distribution with n=%d and p=%s", n, p))
  dev.off()
}

# ex3
dir.create(file.path(getwd(), "png"), showWarnings = FALSE)
dir.create(file.path(getwd(), "pdf"), showWarnings = FALSE)
dir.create(file.path(getwd(), "eps"), showWarnings = FALSE)

probabilities = seq(0.1, 0.9, by=0.1)
n = 20
for (p in probabilities) {
  x <- seq(-n, n, by = 1)
  png(file = sprintf("png/dnorm-%d-%.0f.png", n, p*10))
  pdf(file = sprintf("pdf/dnorm-%d-%.0f.pdf", n, p*10))
  setEPS()
  postscript(sprintf("eps/dnorm-%d-%.0f.eps", n, p*10))
  plot(x, dnorm(x, 0, p), type="l", main=sprintf("Normal Distribution with n=%d and p=%s", n, p))
  dev.off()
}

# ex4
CLT = function(n) {
  samples = c()
  for (i in seq(1,1000)) {
    samples = append(samples, mean(runif(n, min=-10, max=10)))
  }
  samples
}
hist(CLT(1))
hist(CLT(5))
hist(CLT(10))
hist(CLT(100))
  
