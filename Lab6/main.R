notes = read.table("swiss.tsv",header=TRUE)

normFunc = function(x){(x-mean(x, na.rm = T))/sd(x, na.rm = T)}

get_variance_covariance_matrix = function(data, func_to_apply) {
  dims = length(data)
  no_instances = nrow(data)
  m = matrix(nrow = dims, ncol = dims, dimnames = list(names(data), names(data)))
  
  normalised_data = apply(data, 2, func_to_apply)
  
  for (row_no in c(1:dims)) {
    row1 = normalised_data[ ,row_no]
    for (col_no in c(row_no:dims)) {
      row2 = normalised_data[ ,col_no]
      covariance = (t(row1) %*% row2) / (no_instances - 1)
      m[row_no, col_no] = covariance
      m[col_no, row_no] = covariance
    }
  }
  
  m
}

variance_covariance_matrix = get_variance_covariance_matrix(notes, normFunc)
initial_variance = sum(diag(variance_covariance_matrix))
# cov(notes)
eigen_computation = eigen(variance_covariance_matrix)

q = eigen_computation$vectors
spectral_decomposition = t(q) %*% variance_covariance_matrix %*% q

pca = as.matrix(notes) %*% q
variations = diag(spectral_decomposition)
all_variation = sum(variations)
print(initial_variance - all_variation)
print(cumsum(variations/all_variation))
plot(c(1:6), cumsum(variations/all_variation), type="l", xlab="principal components no", ylab="cumulative variation", lwd=3)
title("scree plot")

q = prcomp(notes)

library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)
ggbiplot(q, obs.scale = 1, var.scale = 1
         , ellipse = TRUE, circle = TRUE) +
  scale_color_discrete(name = '') +
  theme(legend.direction = 'horizontal', legend.position = 'top')

q
