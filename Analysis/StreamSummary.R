# This is a program to calculate and plot the orthodoxy score on the sandwich spectrum for all respondents.
# Unless otherwise specified, throughout this file, "sandwich question" refers to a question about either sandwiches or ingredients.

library(ggplot2)
source("Calculate.R")

data <- data[data$cat %in% names(table(data$cat))[table(data$cat) > 1],] # Remove all categories only occurring once, as these data are not helpful for a box plot.

# Create the purity plot.
dataPlot <- ggplot(data, aes(cat, purity, fill=cat), ) # Setup the plot.
dataPlot <- dataPlot + geom_boxplot() # Add the data points.
dataPlot <- dataPlot + labs(x = "Academic Stream", y = "Purity") # Give axes and legend proper labels.
dataPlot <- dataPlot + theme(legend.position = "none")
ggsave("StreamsPurity.pdf", plot=dataPlot, width=9, height=8)

# Create the orthodoxy plot.
dataPlot <- ggplot(data, aes(cat, orthodoxy, fill=cat), ) # Setup the plot.
dataPlot <- dataPlot + geom_boxplot() # Add the data points.
dataPlot <- dataPlot + labs(x = "Academic Stream", y = "Orthodoxy") # Give axes and legend proper labels.
dataPlot <- dataPlot + theme(legend.position = "none")
ggsave("StreamsOrthodoxy.pdf", plot=dataPlot, width=9, height=8)
