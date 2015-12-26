### The goal of this script is to prepare tidy data that can be used for later analysis.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
library(plyr)

setwd("~/src/R/Coursera/GCD-Smartphones/")

# reading the activity labels
activity_labels <- read.table("Dataset/activity_labels.txt")[,2]

# reading features
features <- read.table("Dataset/features.txt")

# reading subject files
subject_train <- read.table("Dataset/train/subject_train.txt", header = FALSE)
subject_test  <- read.table("Dataset/test/subject_test.txt", header = FALSE)

# reading X data files
training_x <- read.table("Dataset/train/X_train.txt", header = FALSE)
test_x <- read.table("Dataset/test/X_test.txt", header = FALSE)

# reading y data files
training_y <- read.table("Dataset/train/y_train.txt", header = FALSE)
test_y <- read.table("Dataset/test/y_test.txt", header = FALSE)

# Merging the training and test data sets
merged_x <- rbind(training_x, test_x)
merged_y <- rbind(training_y, test_y)
merged_subject <- rbind(subject_train, subject_test)

# setting names to variables
names(merged_subject) <- c("SubjectID")
names(merged_y) <- c("Activity")
names(merged_x) <- features$V2

# creating a single data set
data <- cbind(merged_x, merged_y, merged_subject)

# Extract Mean and SD columns
cols_mean_and_sd <- grep(".*mean.*|.*std.*", names(data), ignore.case = TRUE)

# Add subjectID and Activity to the required_columns data
required_columns <- c(cols_mean_and_sd, 562, 563)

# create a new data frame for just required columns
filtered_data <- data[,required_columns]

# use descriptive names to name activities
filtered_data$Activity <- as.character(filtered_data$Activity)
for (i in 1:6) {
  filtered_data$Activity[filtered_data$Activity == i] <- as.character(activity_labels[i])
}

# Update labels to be more descriptive
names(filtered_data)<- gsub("Acc", "Accelerometer", names(filtered_data))
names(filtered_data)<- gsub("^t", "Time", names(filtered_data))
names(filtered_data)<- gsub("^f", "Frequency", names(filtered_data))
names(filtered_data)<- gsub("-std()", "-STD", names(filtered_data))
names(filtered_data)<- gsub("-mean()", "-Mean", names(filtered_data))
names(filtered_data)<- gsub("angle", "Angle", names(filtered_data))
names(filtered_data)<- gsub("Gyro", "Gyroscope", names(filtered_data))
names(filtered_data)<- gsub("Mag", "Magnitude", names(filtered_data))
names(filtered_data)<- gsub("tBody", "TimeBody", names(filtered_data))
names(filtered_data)<- gsub("gravity", "Gravity", names(filtered_data))

# Set subjectID and Activity to Factors
filtered_data$Activity <- as.factor(filtered_data$Activity)
filtered_data$SubjectID <- as.factor(filtered_data$SubjectID)

# Create a tidy data set
tidy_data <- aggregate(. ~ SubjectID + Activity, data = filtered_data, FUN = mean)
tidy_data <- tidy_data[order(tidy_data$SubjectID, tidy_data$Activity),]

# Write new data set to file
write.table(tidy_data, file = "tidydata.txt", row.names = FALSE)