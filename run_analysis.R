library(dplyr)

filename <- "HAR_dataset.zip"

## Downloads the file of the dataset and unzipes it
if (!file.exists(filename)){
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(URL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}


#reads data from the files downloaded
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
training_set <- read.table("UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("UCI HAR Dataset/train/Y_train.txt")
train <- bind_cols(subject_train, training_labels, training_set)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/Y_test.txt")
test <- bind_cols(subject_test, test_labels, test_set)


#creates a list of the features
features <- read.table("UCI HAR Dataset/features.txt")
features <- as.character(features[, 2])


#creates a list of the activities 
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities <- as.character(activities[, 2])


#merges test and train with the proper columns (subject, activity and features)
column_names <- c("subject", "activity", features)
HarDF <- bind_rows(test, train)
colnames(HarDF) <- column_names


#removes columns that are not means or standard deviations
mean_or_std <- grepl("mean()", column_names, fixed = TRUE) | grepl("std()", column_names, fixed = TRUE)
new_variables <- grepl("subject", column_names, fixed = TRUE) | grepl("activity", column_names, fixed = TRUE) | mean_or_std
mean_std_HarDF <- HarDF[, new_variables]
mean_std_HarDF <- arrange(mean_std_HarDF, subject, activity)


<<<<<<< HEAD
#adds the proper names of the activities
=======
#adds the proper names of the activities to the DataFrame
>>>>>>> Creates a tidy data set of HAR
factor_Har <- factor(mean_std_HarDF$activity)
HarDF_activities <- factor(factor_Har, labels = activities)
mean_std_HarDF <- mutate(mean_std_HarDF, activity = HarDF_activities)


#groupes the data frame and computes the mean of each variable (except subject and activity)
groupedDF <- group_by(mean_std_HarDF, subject, activity)
tidyDF <- summarise_all(groupedDF, funs(mean))
colnames(tidyDF) <- column_names[new_variables]
tidyDF <- as.data.frame(tidyDF)


#creates a txtfile with the tidy data
write.table(tidyDF, "tidyDF.txt", row.name=FALSE)