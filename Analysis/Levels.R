# Output the levels for certain columns of interest in the input.

# Define the constants for what columns data is in inside the CSV file.
GRADE_COLUMN <- 1 # What column the grade data is in.
SUBJECTS_COLUMN <- 2 # What column the favourite subjects data is in.
BACKGROUND_COLUMN <- 3 # What column the ethnic background data is in.
STREAM_COLUMN <- 4 # What column the stream data is in.
QUESTIONS_START <- 6 # What column the food questions start at.
QUESTIONS_END <- 48 # What column the food questions end at.
lockBinding("GRADE_COLUMN", globalenv())
lockBinding("SUBJECTS_COLUMN", globalenv())
lockBinding("BACKGROUND_COLUMN", globalenv())
lockBinding("STREAM_COLUMN", globalenv())
lockBinding("QUESTIONS_START", globalenv())
lockBinding("QUESTIONS_END", globalenv())

respondents <- read.csv("NoOutliers.csv") # Read in the CSV.

print(paste(nrow(respondents), "respondents"))

summary(respondents[,GRADE_COLUMN])
print(paste(length(levels(respondents[,GRADE_COLUMN])), "grades"))

#summary(respondents[,SUBJECTS_COLUMN])
#print(paste(length(levels(respondents[,SUBJECTS_COLUMN])), "subjects."))

summary(respondents[,BACKGROUND_COLUMN])
print(paste(length(levels(respondents[,BACKGROUND_COLUMN])), "ethnic backgrounds"))

summary(respondents[,STREAM_COLUMN])
print(paste(length(levels(respondents[,STREAM_COLUMN])), "streams"))
