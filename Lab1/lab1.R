# ex2
x <- c(1, 8, 2, 6, 3, 8, 8, 5, 5, 5)
sum(x)/(length(x))
log2(x)
max(x) - min(x)
y <- (x-5.1)/2.514403
y
mean(y)
sd(y)

# ex3
factura <- c(46, 33, 39, 37, 46, 30, 48, 32, 49, 35, 30, 48)
sum(factura)
min(factura)
max(factura)
length(factura[factura>40])
(length(factura[factura>40])/length(factura)) * 100

#ex4
input_numbers = c()
for (i in c(1:6)){
  input_numbers[i] = as.double(readline(prompt="Enter number: "))
}
max(input_numbers)
min(input_numbers)
mean(input_numbers)
median(input_numbers)
sd(input_numbers)
sort(input_numbers)
y = (input_numbers-mean(input_numbers))/sd(input_numbers)
mean(y)
sd(y)