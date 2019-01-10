library(gtools)
library(gtools)
library(data.table)
library(plyr)
library(olsrr)


houses = read.table("house.dat",header=TRUE)

get_rss = function(samples, target, comb, s2) {
  no_combinations = nrow(comb)

  p = ncol(comb)
  m = nrow(samples)
  
  result = matrix(nrow = no_combinations, ncol = 4)
  
  x = cbind(id=rep(1, 26), data.matrix(samples))
  y = data.matrix(target)
  for (i in c(1:no_combinations)) {
    col = append("id", comb[i,])
    xx = x[,col]
    xt = t(xx)
    xtx = xt %*% xx
    
    beta = solve(xtx) %*% xt %*% y
    
    y_estimated = xx %*% beta
    rss = sum((y - y_estimated)**2)
    tss = sum((y - mean(y))**2)
    
    r2 = 1 - rss/tss
    
    result[i, 1] = rss
    result[i, 2] = r2
    result[i, 3] = 1 - (1 - r2) * (m - 1) / (m - p - 1)
    result[i, 4] = rss/s2 - (m - 2* p - 2)
  }
  
  cbind(result, comb)
}

build_rss = function(d) {
  y = d["PRICE"]
  x = d[which(names(d) %in% "PRICE") * -1]
  
  m = nrow(x)
  n = length(d)
  
  column_names = names(x)
  no_columns = length(column_names)
  
  rss_result = list()
  r2_result = list()
  ra_result = list()
  cp_result = list()
  
  rss_total = get_rss(x, y, t(combn(x=column_names, m=no_columns)), 1)
  s_estimated = as.integer(rss_total[,1])/(m-no_columns-1)

  for (i in c(0:no_columns)) {
    rss = get_rss(x, y, t(combn(x=column_names, m=i)), s_estimated)
    
    best_rss = which.min(rss[,1])
    best_r2 = which.max(rss[,2])
    best_ra = which.max(rss[,3])
    best_cp = which.min(abs(as.integer(rss[,4]) - i - 1))
    
    if (i==0) {
      rss_result = append(rss_result, list(rss[best_rss, 1]))
      r2_result = append(r2_result, list(rss[best_r2, 2]))
      ra_result = append(ra_result, list(rss[best_ra, 3]))
      cp_result = append(cp_result, list(rss[best_cp, 4]))
    }
    else {
      rss_result = append(rss_result, list(rss[best_rss, c(1, 5:(5+i-1))]))
      r2_result = append(r2_result, list(rss[best_r2, c(2, 5:(5+i-1))]))
      ra_result = append(ra_result, list(rss[best_ra, c(3,5:(5+i-1))]))
      cp_result = append(cp_result, list(rss[best_cp, c(4,5:(5+i-1))]))
    }
  }
  list(to_dataframe('rss', rss_result), to_dataframe("r2", r2_result), to_dataframe("ra", ra_result), to_dataframe("cp", cp_result))
}

to_dataframe = function(name, data) {
  mx <- max(lengths(data))
  l1 = lapply(data, `length<-`, mx)
  
  df <- transpose(as.data.frame(l1))
  colnames(df) = c(name, c(1:13))
  
  df
}

result = build_rss(houses)

png(file = "png/rss-criterium.png")
plot(x=0:13, transpose(result[[1]]['rss']), type="o",  main="Plot for rss criterium ", xlab="no. variables", ylab="value", pch=16, xlim=c(0,13), ylim=c(0, 4000))
dev.off()
png(file = "png/r-squared-criterium.png")
plot(x=0:13, transpose(result[[2]]['r2']), type="o",  main="Plot for r-square criterium ", xlab="no. variables", ylab="value", pch=16, xlim=c(0,13), ylim=c(0, 1))
dev.off()
png(file = "png/r-adjusted-criterium.png")
plot(x=0:13, transpose(result[[3]]['ra']), type="o",  main="Plot for r adjusted criterium ", xlab="no. variables", ylab="value", pch=16, xlim=c(0,13), ylim=c(0, 1))
dev.off()
png(file = "png/cp-criterium.png")
plot(x=0:13, transpose(result[[4]]['cp']), type="o",  main="Plot for cp criterium ", xlab="no. variables", ylab="value", pch=16, col="blue", xlim=c(0,13), ylim = c(0, 165))
lines(c(0:13), type = "o", pch=10, col=26)
legend("topright", legend=c("cp", "identity function"), col=c("red", "blue"), pch=c(16, 10), cex=0.8)
dev.off()

r_threshold = 0.88
cp_threshold = 1
for (i in c(4:8)) { 
  if (abs(as.numeric(result[[4]]['cp'][i,]) - i - 1) < cp_threshold && as.numeric(result[[3]]['ra'][i,]) > r_threshold) {
    print(sprintf("best model with cp: %s and ra: %s ", result[[4]]['cp'][i,], result[[3]]['ra'][i,]))
    print(result[[4]][i,2:i])
  }
}

last_cp = as.numeric(result[[4]]['cp'][1,])
i = 1
while (last_cp > i + 1) {
  last_cp = as.numeric(result[[4]]['cp'][i,])
  i = i+1
}
print(i-1)

get_rss(x, )

#igrec = houses["PRICE"]
#ics = houses[which(names(houses) %in% "PRICE") * -1]
#get_rss(ics, igrec, combinations(n=length(names(x)), r=2, v=names(x)))

full_model = lm(houses$PRICE ~ houses$BRD+houses$BTH+houses$CDN+houses$CON+houses$FLR+houses$FP+houses$GAR+houses$L1+houses$L2+houses$LOT+houses$RMS+houses$ST+houses$TAX)
l = lm(houses$PRICE ~ houses$BRD+houses$BTH+houses$CDN+houses$CON+houses$FLR+houses$FP+houses$GAR+houses$L1+houses$L2+houses$LOT+houses$RMS+houses$ST)
ols_mallows_cp(l, full_model)
summary(l)
l = lm(houses$PRICE ~ houses$L2)
sse = sum(l$residuals^2)
s2 = sse / (26-13)
sse/s2 - (26 -2*13)