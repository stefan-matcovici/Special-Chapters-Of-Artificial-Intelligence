houses = read.table("house.dat",header=TRUE)

get_attributes_string = function(attribute_list) {
  s = ''
  for (attribute in attribute_list) {
    s = paste(s, attribute, sep='+')
  }
  
  s = substring(s, 2)
  s
}

get_model_from_attribute_list = function(data, attribute_list) {
  formula_string = paste("PRICE ~ ", get_attributes_string(attribute_list))
  model = lm(formula_string, data = data)
  
  model
}

forward_selection = function(data, alpha) {
  
  x = data[which(names(data) %in% "PRICE") * -1]
  
  all_attributes_significant = TRUE
  current_attributes = list()
  
  while (all_attributes_significant) {
    
    all_attributes_significant = FALSE
    remaining_attributes = names(x[!(names(x) %in% current_attributes)])
    scores = list()
    
    for (attribute in remaining_attributes) {
      
      model = get_model_from_attribute_list(data, append(current_attributes, attribute))
      scores = append(scores, coef(summary(model))[attribute, "Pr(>|t|)"])
    }
    
    m = cbind(remaining_attributes, scores)

    filtered_attributes = m[which(as.numeric(m[ , 'scores']) < alpha),, drop=FALSE]
    if (length(filtered_attributes) > 0) {
      
      all_attributes_significant = TRUE
      most_significant_attribute = filtered_attributes[which.min(filtered_attributes[, 'scores']), 1]
      current_attributes = append(current_attributes, most_significant_attribute)
    }
    
  }
  
  current_attributes
}

backward_selection = function(data, alpha) {
  x = data[which(names(data) %in% "PRICE") * -1]
  
  all_attributes_significant = TRUE
  current_attributes = names(x)
  
  while (all_attributes_significant) {
    
    all_attributes_significant = FALSE

    model = get_model_from_attribute_list(data, current_attributes)
    scores = coef(summary(model))[, "Pr(>|t|)"]
    
    # no intercept
    scores = scores[-1]
    
    m = cbind(current_attributes, scores)
    print(m)
    
    filtered_attributes = m[which(as.numeric(m[ , 'scores']) > alpha),, drop=FALSE]
    if (length(filtered_attributes) > 0) {
      
      all_attributes_significant = TRUE
      most_insignificant_attribute = filtered_attributes[which.max(filtered_attributes[, 'scores']), 1]
      cat(sprintf("Deleting: %s\n", most_insignificant_attribute))
      current_attributes = current_attributes[current_attributes != most_insignificant_attribute]
    }
    
  }
  
  current_attributes
}

stepwise_selection = function(data, alpha) {
  x = data[which(names(data) %in% "PRICE") * -1]
  
  all_attributes_significant = TRUE
  current_attributes = list()
  
  while (all_attributes_significant) {
    
    all_attributes_significant = FALSE
    remaining_attributes = names(x[!(names(x) %in% current_attributes)])
    scores = list()
    
    for (attribute in remaining_attributes) {
      
      model = get_model_from_attribute_list(data, append(current_attributes, attribute))
      scores = append(scores, coef(summary(model))[attribute, "Pr(>|t|)"])
    }
    
    m = cbind(remaining_attributes, scores)
    
    filtered_attributes = m[which(as.numeric(m[ , 'scores']) < alpha),, drop=FALSE]
    if (length(filtered_attributes) > 0) {
      
      all_attributes_significant = TRUE
      most_significant_attribute = filtered_attributes[which.min(filtered_attributes[, 'scores']), 1]
      current_attributes = append(current_attributes, most_significant_attribute)
      
      #backward step
      model = get_model_from_attribute_list(data, current_attributes)
      scores = coef(summary(model))[, "Pr(>|t|)"]
      
      # no intercept
      scores = scores[-1]
      
      m = cbind(current_attributes, scores)
      
      filtered_attributes = m[which(as.numeric(m[ , 'scores']) > alpha),, drop=FALSE]
      if (length(filtered_attributes) > 0) {
        
        most_insignificant_attribute = filtered_attributes[which.max(filtered_attributes[, 'scores']), 1]
        cat(sprintf("Deleting: %s\n", most_insignificant_attribute))
        current_attributes = current_attributes[current_attributes != most_insignificant_attribute]
      }
    }
    
  }
  
  current_attributes
}

backward_attributes = backward_selection(houses, 0.05)
forward_attributes = forward_selection(houses, 0.05)
stepwise_attributes = stepwise_selection(houses, 0.1)
exhaustive_attributes = c("BRD", "FLR", "RMS", "ST", "LOT", "GAR", "L2")

backward_model = get_model_from_attribute_list(houses, backward_attributes)
forward_model = get_model_from_attribute_list(houses, forward_attributes)
stepwise_model = get_model_from_attribute_list(houses, stepwise_attributes)
exhaustive_model = get_model_from_attribute_list(houses, exhaustive_attributes)

forward_predictions = predict(forward_model)
backward_predictions = predict(backward_model)
stepwise_predictions = predict(stepwise_model)
exhaustive_predictions = predict(exhaustive_model)
target = houses[["PRICE"]]

plot(target, forward_predictions, pch=19, col="red", xlab = "target", ylab = "prediction")
points(target, backward_predictions, pch=18, col="blue")
points(target, stepwise_predictions, pch=15, col="purple")
points(target, exhaustive_predictions, pch=12, col="green")
abline(0,1)

legend("topleft", legend=c("Forward", "Backward", "Stepwise", "Exhaustive"), col=c("red", "blue", "purple", "green"), pch=c(19, 18, 15, 12), cex=1.3)

plot(target, forward_predictions, pch=19, col="red", xlab = "target", ylab = "prediction")
title("Forward")
abline(0,1)

plot(target, backward_predictions, pch=19, col="red", xlab = "target", ylab = "prediction")
title("Backward")
abline(0,1)

plot(target, stepwise_predictions, pch=19, col="red", xlab = "target", ylab = "prediction")
title("Stepwise")
abline(0,1)

plot(target, exhaustive_predictions, pch=19, col="red", xlab = "target", ylab = "prediction")
title("Exhaustive")
abline(0,1)


