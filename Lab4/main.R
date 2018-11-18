library(gtools)
library(gtools)
library(data.table)

houses = read.table("house.dat",header=TRUE)

#combinations = function(column_names) {
#  n = length(column_names)
#  result = array(0, n)
#  all = 0
#  
#  combination_util(column_names, result, all, 1, n, 1)
#}

#combination_util = function(d, result, all, start, end, index) {
#  if (index!=0) {
#    if (result[index] == NA) {
#      result[index] = c()
#    }
#  }
#  
#  if (index != length(d)) {
#    i = start
#    while(i <= end) {
#      result[index] = d[i]
#      combination_util(d, result, all, i + 1,  end, index + 1); 
#      i = i+1
#    }
#
#  }
#}

get_rss = function(samples, target, comb) {
  no_combinations = nrow(comb)
  result = matrix(nrow = no_combinations, ncol = 1)
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
    
    result[i, 1] = rss
  }
  
  cbind(result, comb)
}

build_rss = function(d) {
  y = d["PRICE"]
  x = d[which(names(d) %in% "PRICE") * -1]
  
  column_names = names(x)
  no_columns = length(column_names)
  
  result = list()

  for (i in c(1:no_columns)) {
    rss = get_rss(x, y, combinations(n=no_columns, r=i, v=column_names))
    result = append(result, list(rss[which.min(rss[,1]),]))
  }
  result
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

#lm(houses$PRICE ~ houses$BRD + houses$BTH)