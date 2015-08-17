# Getting and Cleaning Data Course Project CodeBook
The following outlines how the run_analysis.R script works

##Objective of Script
The purpose of the script is to piece together information regarding testing and training measures taken from a phone.  The following is important to mention about the dataset.
* Data collects the activity being performed
* Data collects the subject id for the individual performing the action
* Data collects 561 different measurements taken at a single point in time for each activity and subject
* Multiple sets of measurements are taken for each activity and subject

It is important to note that we are not using all of the data but are specifically looking for
1. Only the mean() and std() measurements (a subset of the 561 measurements)
2. Consolidating multiple sets of measurements into a single mean of measurements across each activity and subject (one row for each activity and subject)

##Explaining the Source Data
The code book will explain this in detail as well; however, the following represents a high level description of the input data elements.

###Test vs. Train Data
In the data set, there is a variety of files that provide information on the test and train data sets.  While separate, the components of both test and train are the same.

###Components of Test and Train Input Data
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

###Read Data
This code is denoted by the "Read in Raw Data" and utilizes read.table to read in all the data tables mentioned above.

###Binding
1. Subject and activity are added to independent test and train data set (utilizing cbind)
2. Combine the above test and train data utilizing rbind

###Define Descriptive Measure Names (for relevant values only)
1. Find Rows in features that Contain "mean() or std()"
2. Identify measure names in features using step 1 numeric vector
3. Create a method to generate a descriptive name from a raw measure input
4. Apply this function over all elements of the measure names using the vector from step 2

####More on Measure Names
After thorough review of the measure names, below is a list of components and definitions used to help drive the function mentioned above (in Step 3)
* If the measure contains mean() then the measure name is "Average", else we know it is "Standard Deviation"
* If the measure name starts with "t" then we know it is a time measure, else we know it starts with "f" and is a frequency measure
* If the measure contains gyro, then we know that the measure represents an angular velocity and not an acceleration measure
* If the measure contains gravity, then we know the measure utilizes the gravity acceleration, else it is the phone body acceleration
* If the measure contains jerk, then we know the measure is a jerk measurement
* If the measure ends in -X, -Y, or -Z then we know it is measuring an axis, else we know it is a Magnitude measurement

All of the above logic is combined to make a logical and descriptive name.

###Filter for Only Relevant Columns and Provide Descriptive Names
1. Using the descriptive names from the previous step, we add both "Activity.ID" and "Subject" to the beginning to create a character vector of measure names
2. Select only relevant columns from merged data from "Binding" step 2 utilizing the measure locations obtained from "Defining Desciptive Measure Names" step 1
3. Set the column names of the resulting dataset to the character vector from step 1

###Define Descriptive Activity Names
1. Merge the activity.labels data with the dataset obtained from the last step
2. Reorder the dataset and changing the activity.name default value
3. Remove the activity id from the dataset

###Create Second Tidy Data Set
1. Melt the data, setting the Activity Name and Subject as variable ids
2. dcast the data to provide the original format but the measures representing the mean across activities and subjects
3. Write the data to a table named "Tidy Data.txt" and notify the user

##Output Data Format
The output represents a tidy data set (in a text file) with the averages of each measurement for each activity and each subject.  There are 180 rows (30 unique subjects and 6 unique activities) and 68 columns (The activity and subject are dimensions and the 66 different measurements are variables).

###Rows (180)
There are 180 rows.  Each row represents the average of measurements across unique activities performed by unique subjects

###Columns (68)
Activity.Name - Represents the activity being performed at the time of measurement
Type: Character

Subject - Represents the id for a unique subject performing an activity  where measurements were taken
Type: Character

Measurement Values (Column 3 to 68) - Represents the average of the measurement being taken during a unique activity on a unique subject.  There are 66 measure averages.
Value Type: Numeric
Units: Angular Velocity - rad/s
       Acceleration - m/s^2
