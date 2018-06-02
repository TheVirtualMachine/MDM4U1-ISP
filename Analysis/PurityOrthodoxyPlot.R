# This is a program to plot orthodoxy vs purity on the sandwich spectrum for all respondents.

library(ggplot2)
source("Calculate.R")

makeScatterPlot <- function(categoryName, categoryTitle) {
	# Create the plot.
	dataPlot <- ggplot(data, aes(purity, orthodoxy)) # Setup the plot.
	#dataPlot <- dataPlot + coord_cartesian(xlim = c(-1, 1), ylim = c(-1, 1)) # Set the graph limits.
	dataPlot <- dataPlot + geom_point(aes_string(colour = categoryName), size = 0.75) # Add the data points.
	dataPlot <- dataPlot + geom_smooth(method = loess, level = 0.95, colour = "black", size = 0.5) # Add the confidence curve.
	dataPlot <- dataPlot + geom_smooth(method = lm, se = FALSE, colour = "black", size = 0.5, linetype="dashed") # Add the line of best fit.
	dataPlot <- dataPlot + labs(x = "Purity", y = "Orthodoxy", colour = categoryTitle) # Give axes and legend proper labels.
	ggsave(paste(categoryTitle, "PurityVsOrthodoxy.pdf", sep = ""), plot=dataPlot, width=5.5, height=3)
}

makeScatterPlot("stream", "Stream")
makeScatterPlot("grade", "Grade")
makeScatterPlot("background", "Ethnic Background")
