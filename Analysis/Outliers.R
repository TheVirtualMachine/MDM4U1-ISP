# This program removes outliers.

source("Calculate.R")

outlierData <- data

# Create the quadratic model.
mod <- lm(orthodoxy ~ poly(purity, 2), data = outlierData)
resid <- unname(mod$residuals)

# Compute the cutoffs.
q1 <- unname(quantile(resid)[2])
q3 <- unname(quantile(resid)[4])
icq = q3 - q1
lowCutoff = q1 - 1.5 * icq
highCutoff = q3 + 1.5 * icq

remove <- -which(resid < lowCutoff | resid > highCutoff)
removed <- respondents[remove,]
print(remove)

write.csv(removed, file = "NoOutliers.csv", row.names = FALSE)
