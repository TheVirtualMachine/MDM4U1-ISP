# This program creates a residual plot of the respondents using the quadratic method.

library(ggplot2)

source("Calculate.R")

significanceData <- data

# Create the linear model.
linearModel <- lm(orthodoxy ~ purity, data = significanceData)
quadraticModel <- lm(orthodoxy ~ poly(purity, 2), data = significanceData)

print("Linear model")
print("--------------------------------------------------")
print("Coefficients")
coef(linearModel)
print("Correlations")
paste("r =", cor(significanceData$purity, y = significanceData$orthodoxy))
paste("r^2 =", summary(linearModel)$r.squared)
paste("p =", summary(linearModel)$coefficients[2,4])

print("==================================================")

print("Quadratic model")
print("--------------------------------------------------")
print("Coefficients")
coef(quadraticModel)
print("Correlations")
paste("r^2 =", summary(quadraticModel)$r.squared)
#paste("p =", summary(quadraticModel)$coefficients[,4])
summary(quadraticModel)
