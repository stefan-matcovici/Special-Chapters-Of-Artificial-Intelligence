require(uskewFactors)
data(banknote)
banknote.pca = prcomp(banknote, center = TRUE, scale. = TRUE)
banknote.pca
summary(banknote.pca)
cor(banknote)

library(devtools)
install_github("vqv/ggbiplot")

library(ggbiplot)
ggbiplot(banknote.pca, ellipse=TRUE, groups=banknote$Y)


sapply(banknote, sd, na.rm = TRUE)
banknote.colors="black"
banknote.colors[banknote$Y==1] = "red"
banknote.colors[banknote$Y==0] = "blue"
plot(banknote$Bottom, banknote$Diagonal, col=banknote.colors)

# notes = read.table("swiss.tsv",header=TRUE)
# banknote = prcomp(notes, center = TRUE, scale. = TRUE)
# summary(banknote)