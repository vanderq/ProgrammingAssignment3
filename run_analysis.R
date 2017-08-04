library(plyr)
library(dplyr)
# Read the Activity Labels from the CSV-file. No header line, separator is a blank space
# After that we set descriptive variable names
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE)
colnames(activityLabels) <- c("activityid", "activity")

# Read the Features from the CSV-file. No header line, separator is a blank space
# After that we set descriptive variable names
features <- read.csv("UCI HAR Dataset/features.txt", sep=" ", header=FALSE)
colnames(features) <- c("featureid", "feature")

# Read the Features from the CSV-file. No header line, separator is a blank space
# After that we set descriptive variable names
subjectTests <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep=" ", header=FALSE)
colnames(subjectTests) <- c("subjectid")

# Read the Features from the CSV-file. No header line, separator is a blank space
# After that we set descriptive variable names
activityTests <- read.csv("UCI HAR Dataset/test/y_test.txt", sep=" ", header=FALSE)
colnames(activityTests) <- c("activityid")

# merge the activityLabels with the activityTests, such that the activityTests contain also the description of the activity as a variable
activityTests <- join(activityTests, activityLabels, by="activityid")

# Read the Features from the CSV-file. No header line, separator is any combination of blank space 
testValues <- read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
# Use the imported features to set the column names of the testValues
colnames(testValues) <- features$feature

# Combine the subject, activity and test data to form 1 dataset
fullTestSet <- data.frame(subjectTests, activityTests, testValues)
# Only extract the columns with mean, std or our id columns
filteredTestSet <- fullTestSet[,grepl("mean\\.|std\\.|subjectid|activity", colnames(fullTestSet))]
# Remove the activityid column
filteredTestSet <- select(filteredTestSet, -activityid)

# Now we perform the same steps for the training data set.

# Read the Features from the CSV-file. No header line, separator is a blank space
# After that we set descriptive variable names
subjectTrainings <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep=" ", header=FALSE)
colnames(subjectTrainings) <- c("subjectid")

# Read the Features from the CSV-file. No header line, separator is a blank space
# After that we set descriptive variable names
activityTrainings <- read.csv("UCI HAR Dataset/train/y_train.txt", sep=" ", header=FALSE)
colnames(activityTrainings) <- c("activityid")
# merge the activityLabels with the activityTrainings, such that the activityTrainings contain also the description of the activity as a variable
activityTrainings <- join(activityTrainings, activityLabels, by="activityid")

# Read the Features from the CSV-file. No header line, separator is any combination of blank space 
trainingValues <- read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
# Use the imported features to set the column names of the testValues
colnames(trainingValues) <- features$feature

# Combine the subject, activity and test data to form 1 dataset
fullTrainingSet <- data.frame(subjectTrainings, activityTrainings, trainingValues)
# Only extract the columns with mean, std or our id columns
filteredTrainingSet <- fullTrainingSet[,grepl("mean\\.|std\\.|subjectid|activity", colnames(fullTrainingSet))]
# Remove the activityid column
filteredTrainingSet <- select(filteredTrainingSet, -activityid)

# Combine the test and the training set into 1 data frame
completeSet <- rbind(filteredTestSet, filteredTrainingSet)

# Set the column names to something more meaningfull
colnames(completeSet) <- c("subjectid", "activity", "meanbodyaccelerationX", "meanbodyaccelerationY", "meanbodyaccelerationZ",
                           "stdbodyaccelerationX","stdbodyaccelerationY","stdbodyaccelerationZ",
                           "meangravityaccelerationX", "meangravityaccelerationY","meangravityaccelerationZ",
                           "stdgravityaccelerationX", "stdgravityaccelerationY","stdgravityaccelerationZ",
                           "meanjerkbodyaccelerationX", "meanjerkbodyaccelerationY","meanjerkbodyaccelerationZ",
                           "stdjerkbodyaccelerationX", "stdjerkbodyaccelerationY","stdjerkbodyaccelerationZ",
                           "meangyrobodyX", "meangyrobodyY","meangyrobodyZ",
                           "stdgyrobodyX", "stdgyrobodyY","stdgyrobodyZ",
                           "meanjerkgyrobodyX", "meanjerkgyrobodyY","meanjerkgyrobodyZ",
                           "stdjerkgyrobodyX", "stdjerkgyrobodyY","stdjerkgyrobodyZ",
                           "meanbodyaccelerationmag", "stdbodyaccelerationmag",
                           "meangravityaccelerationmag", "stdgravityaccelerationmag",
                           "meanjerkbodyaccelerationmag", "stdjerkbodyaccelerationmag",
                           "meanbodygyromag", "stdbodygyromag",
                           "meanjerkbodygyromag", "stdjerkbodygyromag",
                           "meanfourierbodyaccelerationX", "meanfourierbodyaccelerationY","meanfourierbodyaccelerationZ",
                           "stdfourierbodyaccelerationX", "stdnfourierbodyaccelerationY","stdfourierbodyaccelerationZ",
                           "meanfourierjerkbodyaccelerationX", "meanfourierjerkbodyaccelerationY","meanfourierjerkbodyaccelerationZ",
                           "stdfourierjerkbodyaccelerationX", "stdfourierjerkbodyaccelerationY","stdfourierjerkbodyaccelerationZ",
                           "meanfourierbodygyroX", "meanfourierbodygyroY","meanfourierbodygyroZ",
                           "stdfourierbodygyroX", "stdfourierbodygyroY","stdfourierbodygyroZ",
                           "meanfourierbodyaccelerationmag", "stdfourierbodyaccelerationmag", 
                           "meanfourierjerkbodyaccelerationmag", "stdfourierjerkbodyaccelerationmag", 
                           "meanfourierbodygyromag", "stdfourierbodygyromag",
                           "meanfourierjerkbodygyromag", "stdfourierjerkbodygyromag"
                           )

# Last but not least we group the data frame by the subjectid and the activity, and calculate the mean value for all columns
completeSet <- group_by(completeSet, subjectid, activity)
summarizedSet <- summarize_all(completeSet, mean)