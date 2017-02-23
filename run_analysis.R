library(plyr)
library(dplyr)

# download the raw data zip file and unzip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "rawData.zip")
unzip("rawData.zip")

# read test and training data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subjectId"))
dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")
dataActivityIdsTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activityId"))

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subjectId"))
dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
dataActivityIdsTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activityId"))

# 1. Merges the training and the test sets to create one data set. 
subject <- bind_rows(subjectTest, subjectTrain)
dataAll <- bind_rows(dataTest, dataTrain)
dataActivityIds <- bind_rows(dataActivityIdsTest, dataActivityIdsTrain)

# read list of feature variables and select just the mean and standard deviation features
featureDict <- read.table("UCI HAR Dataset/features.txt", col.names = c("featureId", "featureName"))
meanAndStdDevFeatures <- featureDict[grep("mean\\(\\)|std\\(\\)", featureDict$featureName, ignore.case = TRUE),]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dataMeanAndStdDevOnly <- dataAll[,meanAndStdDevFeatures$featureId]

# 3. Uses descriptive activity names to name the activities in the data set 
activityDict <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityName"))
dataActivityNames <- mapvalues(as.character(dataActivityIds$activityId), from = as.character(activityDict$activityId), to = as.character(activityDict$activityName))

# 4. Appropriately labels the data set with descriptive variable names. 
colnames(dataMeanAndStdDevOnly) <- as.vector(meanAndStdDevFeatures$featureName)

# unify the columns into a single table: subject Ids, activity names, and mean and std dev data
answer1MeanAndStdDevData <- bind_cols(subject, as.data.frame(dataActivityNames), dataMeanAndStdDevOnly)
names(answer1MeanAndStdDevData)[1]<-"subject"
names(answer1MeanAndStdDevData)[2]<-"activity"

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
answer2MeanAndStdDevAvgs <- group_by(answer1MeanAndStdDevData, activity, subject, add = TRUE) %>%
  summarise_all(mean)