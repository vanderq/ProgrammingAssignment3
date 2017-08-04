############################# Introduction ##############################
This document describes how the R run_analysis.R script can be used to import the "Human Activity Recognition Using Smartphones Dataset", and transform it into a tidy dataset that can be used for further analysis.

The "Human Activity Recognition Using Smartphones Dataset" dataset is a collection of files that can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The dataset is regarding a study performed to be able to recognize activities based on smartphone data.
More information can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

############################# Prerequisites ##############################
In order to run the script the following prerequisites need to be met:
- R should be installed
- package dplyr should be installed in the used R installation
- The "Human Activity Recognition Using Smartphones Dataset" should be downloaded and its content extracted out of the zip file
- The working directory in R should contain the extracted datafiles and -folders
- The run_analysis.R script should be placed into the working directory as well.


############################# Dataset explanation #########################
The "Human Activity Recognition Using Smartphones Dataset" contains several data files.
For a full description we refer the reader to the README that accompanies the dataset.
The following files are of interest with respect to the run_analysis.R script:
- activity_labels.txt: contains records that can be used to obtain the description of an activity related to an activity id
- features.txt: contains a list all the measured features that are part of the test and the train set. These are actually the column/variable names of the measurements.
- test/subject_test.txt: contains per record the id of the subject
- test/y_test.txt: contains per record the id of the activity performed
- test/X_test.txt: contains the measurment data per record
- The train/... folder contains similar files regarding the training dataset

############################# Script explanation ##########################
The run_analysis.R script will use the "Human Activity Recognition Using Smartphones Dataset", import the required files, and will generate a tidy dataset containing the average values of the mean() and std() features per subject(id) and activity.

The script is doing this by performing the following steps:
- import the activity labels, and assign descriptive column names
- import the features, and assign descriptive column names

Then for both the test and train set respectively the following steps are performed:
- import the subject data, and assign descriptive column names
- import the activity data, and assign descriptive column names
- merge the activity data with the activity labels, such that the activity dataset contains a column with the activity description
- import the data set with the measurements
- use the imported features to assign those as column names to the imported measurements
- extract the mean() and std() columns, next to the subjectid and the activity columns

After the previous steps have been done for the test and the training dataset, both are combined into 1 dataset
For this dataset we set descriptive column names.
As a last step we group the dataset by subjectid and activity, and calculate the average value of all the measurement columns


