# Download and unzip dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip")

# Load necessary libraries
library(dplyr)

# Read data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")


# Merge the training and the test sets to create one data set
subject <- rbind(subject_train, subject_test)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
merged_data <- cbind(subject, y, x)


# Extract only the measurements on the mean and standard deviation for each measurement
selected_features <- features$feature[grep("mean\\(\\)|std\\(\\)", features$feature)]
selected_data <- merged_data[, c("subject", "activity", selected_features)]


# Use descriptive activity names to name the activities in the data set
selected_data$activity <- activities[selected_data$activity, 2]


# Appropriately label the data set with descriptive variable names
names(selected_data)[-c(1, 2)] <- selected_features
names(selected_data) <- gsub("^t", "Time", names(selected_data))
names(selected_data) <- gsub("^f", "Frequency", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- selected_data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean = ~mean(.)))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)


