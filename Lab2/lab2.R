# ex1
twos = function (a, b) {
  plot(2 ^ c(a:b), lwd="2", col="red", main=sprintf("f(x)=2^x, x in [%d, %d]", a, b), type="l")
}

twos(5, 10)
twos(5, 100)

# ex2
dir.create(file.path(getwd(), "png"), showWarnings = FALSE)
dir.create(file.path(getwd(), "pdf"), showWarnings = FALSE)
dir.create(file.path(getwd(), "eps"), showWarnings = FALSE)

plot_binomial_distribution = function(n, probabilities, out_type) {
  x <- seq(0, n)
  for (p in probabilities) {
    switch(out_type,
           "pdf"= pdf(file = sprintf("pdf/dbinom-%d-%.0f.pdf", n, p*10)),
           "eps"= {
             setEPS()
             postscript(sprintf("eps/dbinom-%d-%.0f.eps", n, p*10))},
           "png"= png(file = sprintf("png/dbinom-%d-%.0f.png", n, p*10))
           )
    plot(x, dbinom(x, n, p), type="l", main=sprintf("Binomial Distribution with n=%d and p=%s", n, p))
    dev.off()
  }
}

plot_binomial_distribution(20, seq(0.1, 0.9, by=0.1), "eps")

# ex3
dir.create(file.path(getwd(), "png"), showWarnings = FALSE)
dir.create(file.path(getwd(), "pdf"), showWarnings = FALSE)
dir.create(file.path(getwd(), "eps"), showWarnings = FALSE)

plot_normal_distribution = function(n, probabilities, out_type) {
  x <- seq(-n, n, by = 1)
  for (p in probabilities) {
    switch(out_type,
           "pdf"= pdf(file = sprintf("pdf/dnorm-%d-%.0f.pdf", n, p*10)),
           "eps"= {
             setEPS()
             postscript(sprintf("eps/dnorm-%d-%.0f.eps", n, p*10))},
           "png"= png(file = sprintf("png/dnorm-%d-%.0f.png", n, p*10))
    )
    plot(x, dnorm(x, 0, p), type="l", main=sprintf("Normal Distribution with n=%d and p=%s", n, p))
    dev.off()
  }
}

plot_normal_distribution(20, c(0.1, 1, 10), "pdf")

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

var(CLT(10000))
mean(runif(100000))

#tries
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
  
