# download the raw data zip file and unzip
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "rawData.zip")
# unzip("rawData.zip")

# read test and training data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")
dataLablesTest <- read.table("UCI HAR Dataset/test/y_test.txt")

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
dataLablesTrain <- read.table("UCI HAR Dataset/train/y_train.txt")

# 1. Merges the training and the test sets to create one data set. 
subject <- bind_rows(subjectTest, subjectTrain)
colnames(subject) <- c("subjectId")
data <- bind_rows(dataTest, dataTrain)
dataLables <- bind_rows(dataLablesTest, dataLablesTrain)
colnames(dataLables) <- c("activityId")

# read list of feature variables and select just the mean or standard deviation variables
features <- read.table("UCI HAR Dataset/features.txt")
meanOrStdCol <- features[grep("mean\\(\\)|std\\(\\)", features$V2, ignore.case = TRUE),]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanOrStdData <- data[,meanOrStdCol$V1]

# 3. Uses descriptive activity names to name the activities in the data set 
activityDict <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLbls <- mapvalues(as.character(dataLables$activityId), from = as.character(activityDict$V1), to = as.character(activityDict$V2))

# 4. Appropriately labels the data set with descriptive variable names. 
colnames(meanOrStdData) <- as.vector(meanOrStdCol$V2)

# unify the mean and std data into a single table
answer1 <- bind_cols(subject, as.data.frame(activityLbls), meanOrStdData)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
answer2 <- group_by(answer1, activityLbls, subjectId, add = TRUE) %>%
  summarise_all(mean)