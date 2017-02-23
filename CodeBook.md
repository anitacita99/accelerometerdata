## Raw Data
- full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- raw data [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "raw accelerometer data")

### dictionaries
- activityDict: mapping of 6 ids to activity names
- featureDict: mapping of 561 ids to feature names

### raw test data
- subjectTest: 2947 subject Ids
- dataTest: 2947 data observations of 561 variables
- dataActivityIdsTest: 2947 activity Ids

### raw training data
- subjectTrain: 7352 subject Ids
- dataTrain: 7352 data observations of 561 variables
- dataActivityIdsTrain: 7352 activity Ids

## Intermediate Data

### merged raw data: test + training data
- subject: 10299 subject Ids
- dataAll: 10299 data observations of 561 variables
- dataActivityIds: 10299 activity Ids
- dataActivityNames: : 10299 activity Names

### filtered raw data: mean and standard deviation only
- meanAndStdDevFeatures: mapping of id to feature name of 66 mean and standard deviation features
    - mean and standard deviation of body, gravity, and jerk acceleration signals tBodyAcc-XYZ, tGravityAcc-XYZ, and tBodyAccJerk-XYZ
    - full list and details in ./UCI HAR Dataset/features_info.txt
- dataMeanAndStdDevOnly: 10299 data observations of 66 mean and standard deviation variables

## Final tidy data sets
- answer1MeanAndStdDevData: tidy data set of 10299 data observations of 66 mean and standard deviation variables for each subject[30] and activity[6]
- answer2MeanAndStdDevAvgs: tidy data set of 180 data observations representing the average of each mean and standard deviation variable[66] for each activity[6] and each subject [30]