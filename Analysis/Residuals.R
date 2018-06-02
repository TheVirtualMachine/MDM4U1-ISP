# This program creates a residual plot of the respondents.

library(ggplot2)
library(broom)

source("Calculate.R")

residualPlotData <- data

# Create the linear model.
mod <- lm(orthodoxy ~ purity, data = residualPlotData)
df <- augment(mod)
#print(df[which(df$.resid < -0.76),])
which(df$.resid < -0.76)

# Create the residual plot.
dataPlot <- ggplot(df, aes(.fitted, .resid)) + geom_point()
dataPlot <- dataPlot + coord_cartesian(ylim = c(-1, 1)) # Set the graph limits.
dataPlot <- dataPlot + labs(x = "Fitted Value", y = "Residual") # Give axes proper labels.
ggsave("LinearResidualPlot.pdf", plot=dataPlot, width=5.5, height=3)

# Create the loess model.
mod <- loess(orthodoxy ~ purity, data = residualPlotData)
df <- augment(mod)
#print(df[which(df$.resid < -0.8),])
which(df$.resid < -0.80)

# Create the residual plot.
dataPlot <- ggplot(df, aes(.fitted, .resid)) + geom_point()
dataPlot <- dataPlot + coord_cartesian(ylim = c(-1, 1)) # Set the graph limits.
dataPlot <- dataPlot + labs(x = "Fitted Value", y = "Residual") # Give axes proper labels.
ggsave("LoessResidualPlot.pdf", plot=dataPlot, width=5.5, height=3)
