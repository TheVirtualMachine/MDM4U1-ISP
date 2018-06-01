# This program creates a residual plot of the respondents broken down by their categorical data.

library(ggplot2)
library(broom)

source("Calculate.R")

residualPlotData <- data

# Create the linear model.
mod <- loess(orthodoxy ~ purity, data = residualPlotData)
df <- augment(mod)

# Create the residual plot.
dataPlot <- ggplot(df, aes(.fitted, .resid)) + geom_point()
dataPlot <- dataPlot + labs(x = "Fitted Value", y = "Residual") # Give axes proper labels.
ggsave("ResidualPlot.pdf", plot=dataPlot, width=9, height=8)
