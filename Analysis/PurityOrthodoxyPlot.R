# This is a program to plot orthodoxy vs purity on the sandwich spectrum for all respondents.

library(ggplot2)
source("Calculate.R")

makeScatterPlot <- function(categoryName, categoryTitle) {
	# Create the plot.
	dataPlot <- ggplot(data, aes(purity, orthodoxy)) # Setup the plot.
	dataPlot <- dataPlot + xlim(-1, 1) + ylim(-1, 1) # Set the graph limits.
	dataPlot <- dataPlot + geom_point(aes_string(colour = categoryName), size = 0.75) # Add the data points.
	dataPlot <- dataPlot + geom_smooth(method = lm, formula = y ~ x, fullrange = TRUE, se = FALSE, colour = "black", size = 0.5, linetype="dashed") # Add the line of best fit.
	dataPlot <- dataPlot + geom_smooth(method = lm, formula = y ~ poly(x, 2), fullrange = TRUE, se = FALSE, colour = "blue", size = 0.5, linetype="dotted") # Add the curve of best fit.
	dataPlot <- dataPlot + geom_smooth(method = loess, level = 0.99, colour = "red", size = 0.5) # Add the confidence curve.
	dataPlot <- dataPlot + labs(x = "Purity", y = "Orthodoxy", colour = categoryTitle) # Give axes and legend proper labels.
	#dataPlot <- dataPlot + geom_text(x = -0.25, y = 0.75, label = lm_eqn(data), parse = TRUE)
	ggsave(paste(categoryTitle, "PurityVsOrthodoxy.pdf", sep = ""), plot=dataPlot, width=5.5, height=3)
}

makeScatterPlot("stream", "Stream")
makeScatterPlot("grade", "Grade")
makeScatterPlot("background", "Ethnic Background")
