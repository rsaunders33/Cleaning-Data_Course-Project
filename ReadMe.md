# How run_analysis.R Works

The following outlined how the script works and provides instructions for running and recreating the tidy data output.

##Assumptions
The script makes the following assumptions:
* That the .zip file has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* That is has been extracted into a local directory
* That the current working directory in R contains the extracted folder named "UCI HAR Dataset"

##Explaining the Source Data
The code book will explain this in detail as well; however, the following represents a high level description of the input data elements.

###Test vs. Train Data
In the data set, there is a variety of files that provide information on the test and train data sets.  While separate, the components of both test and train are the same.

###Components of Test and Train Data
Both test and train contain the following data components that are only applicable to the respective datasets.  All of the following datasets have the same number of row across the test or training data (e.g. y_test,x_test,subject_test all have the same number of rows).
* X_test.txt or X_train.txt - Each row represents single measurements taken during an activity for an individual(obtained from y and subject files).  Each column represents the value of the measurements taken (561 measurements in total)
* y_test.txt or y_train.txt - Each row corresponds to the X_test or X_train dataset and the numeric values for the activity a subject was engaging in when the measurement was taken (maps to activity_labels)
* subject_test.txt or subject_train.txt - Each row corresponds to the X_test or X_train dataset and represents the subject performing the activity measured

###Components that apply to both Test and Train data
There are two files that correspond to both the test and train datasets.
* activity_labels.txt - Maps the numberic value for the activites (seen in y_test or y_train) to a descriptive name
* features.txt - X_test and X_train columns representing the measures taken do not have names.  This file represents the names of the columns for these files.

##Script Steps
The following are the high level steps taken to develop a tidy data set representing the average of each variable for each activity and each subject
* Read Data
* Bind Data Sets Together
* Define Descriptive Measure Names (for relevant values only)
* Filter for Only Relevant Columns and Provide Descriptive Names
* Define Descriptive Activity Names
* Create Second Tidy Data Set - Average of each variable for each activity and each subject