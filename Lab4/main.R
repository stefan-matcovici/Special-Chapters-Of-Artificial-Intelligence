library(gtools)
library(gtools)
library(data.table)
library(plyr)

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
    result[i, 4] = rss/s2 - (m - 2* (p + 1))
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
  
  rss_result = matrix(nrow = 0, ncol = no_columns+1)
  r2_result = list()
  ra_result = list()
  cp_result = list()
  
  rss_total = get_rss(x, y, combinations(n=no_columns, r=no_columns, v=column_names), 1)
  s_estimated = as.integer(rss_total[,1])/(m-n-1)

  for (i in c(1:no_columns)) {
    rss = get_rss(x, y, combinations(n=no_columns, r=i, v=column_names), s_estimated)
    
    best_rss = which.min(rss[,1])
    best_r2 = which.max(rss[,2])
    best_ra = which.max(rss[,3])
    best_cp = which.min(abs(as.integer(rss[,4]) - i))
    
    rss_result = rbind.fill.matrix(rss_result, rss[best_rss, c(1, 5:(5+i-1))])
    r2_result = append(r2_result, list(rss[best_r2, c(2, 5:(5+i-1))]))
    ra_result = append(ra_result, list(rss[best_ra, c(3,5:(5+i-1))]))
    cp_result = append(cp_result, list(rss[best_cp, c(4,5:(5+i-1))]))
  }
  cp_result
}

l = build_rss(houses)
mx <- max(lengths(l))
l1 = lapply(l, `length<-`, mx)

df <- t(as.data.frame(l1))
df <- transpose(as.data.frame(l1))
colnames(df) = c("rss", c(1:13))


#igrec = houses["PRICE"]
#ics = houses[which(names(houses) %in% "PRICE") * -1]
#get_rss(ics, igrec, combinations(n=length(names(x)), r=2, v=names(x)))

l = lm(houses$PRICE ~ houses$BRD+houses$BTH+houses$CDN+houses$CON+houses$FLR+houses$FP+houses$GAR+houses$L1+houses$L2+houses$LOT+houses$RMS+houses$ST+houses$TAX)
l = lm(houses$PRICE ~ houses$L2)
sse = sum(l$residuals^2)
s2 = sse / (26-13)
sse/s2 - (26 -2*13)