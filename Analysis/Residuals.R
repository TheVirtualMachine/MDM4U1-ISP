# This program creates a residual plot of the respondents.

library(ggplot2)
library(broom)

source("Calculate.R")

residualPlotData <- data

# Create the linear model.
mod <- lm(orthodoxy ~ purity, data = residualPlotData)
df <- augment(mod)

# Create the residual plot.
dataPlot <- ggplot(df, aes(.fitted, .resid)) + geom_point()
dataPlot <- dataPlot + labs(x = "Fitted Value", y = "Residual") # Give axes proper labels.
ggsave("LinearResidualPlot.pdf", plot=dataPlot, width=9, height=8)

# Create the loess model.
mod <- loess(orthodoxy ~ purity, data = residualPlotData)
df <- augment(mod)

# Create the residual plot.
dataPlot <- ggplot(df, aes(.fitted, .resid)) + geom_point()
dataPlot <- dataPlot + labs(x = "Fitted Value", y = "Residual") # Give axes proper labels.
ggsave("LoessResidualPlot.pdf", plot=dataPlot, width=9, height=8)
