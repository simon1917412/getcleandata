The purpose of this repo is to present the information that is required for the getting and cleaning data course project.

Link to course project:

https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

The purpose of the project is to take the below data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Apply the following transformations:

1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement.
3) Apply descriptive activity names to name the activities in the data set
4) Appropriately label the data set with descriptive variable names.
5) Create an independent tidy data set with the average of each variable for each activity and each subject.

The file used to produce those transformations should be then saved down to a repo, along with a codebook, and a readme file explaining how the script works.

The script downloads and unzips the raw data before applying the transformations listed above


This repo contains the following files:

1) README.md - this file that details the purpose of the repo, the files contained within it
2) Codebook.md - this file describes the contents of the data set and the transformations undertaken to produce it from the underlying raw data set
3) run_analysis.r - the r file that was used to create the tidy data set by applying the above list of transformations to the raw data
4) tidyData.txt - the file containing the output tidy data set
