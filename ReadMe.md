# Getting and Cleaning Data Course Project

The following are the contents of the repository
1. ReadMe.md - Looks like you found this file  ;-)
2. Codebook.md - Codebook to show input data format, transformations, and output format
3. run_analysis.R - R script to run in Rstudio (takes input data and outputs tidy data)
4. Tidy Data.txt - Output of the run_analysis.R script

##Assumptions
The script makes the following assumptions:
* That you have the packages "dplyr" and "reshape2" installed
* That the .zip file has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* That the .zip above has been extracted into a local directory
* That the current working directory in R contains the run_analysis.R script
* That the current working directory in R contains the extracted folder named "UCI HAR Dataset"

##Running the script
1. See Assumptions Above and Please Adhere to Them
2. Run command: source("run_analysis.R")

##Output
The script will place a file called "Tidy Data.txt" in your working directory.  This is the output of step 5 of the assignment.

##Viewing the Output
Please use the command: View(read.table("Tidy Data.txt"))