# This program creates a residual plot of the respondents using the quadratic method.

library(ggplot2)
library(broom)

source("Calculate.R")

residualPlotData <- data

# Create the quadratic model.
mod <- lm(orthodoxy ~ poly(purity, 2), data = residualPlotData)
df <- augment(mod)

# Create the residual plot.
dataPlot <- ggplot(df, aes(.fitted, .resid)) + geom_point()
dataPlot <- dataPlot + coord_cartesian(ylim = c(-1, 1)) # Set the graph limits.
dataPlot <- dataPlot + labs(x = "Fitted Value", y = "Residual") # Give axes proper labels.
ggsave("QuadraticResidualPlot.pdf", plot=dataPlot, width=5.5, height=3)
