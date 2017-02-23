# accelerometerdata
## Coursera Getting and Cleaning Data week 4 assignment

An analysis of accelerometer data recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted Samsung Galaxy S smartphone.

## Raw Data
- full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- raw data [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "raw accelerometer data")

## CodeBook.md
Describes the variables, the data, and actions performed to clean up and transform the data.

## run_analysis.R:
1. loads raw data
2. cleans and transforms data into 2 tidy sets:
    * mean and standard deviation measurements for each subject and activity
    * average of each variable for each activity and each subject