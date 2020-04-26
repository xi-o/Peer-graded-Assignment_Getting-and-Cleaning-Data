
library(dplyr)
library(data.table)

# description  of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# download data


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


if (!dir.exists("Dataset/UCI HAR Dataset")) {
        
        download.file(url, "dataset.zip")

        unzip("dataset.zip", exdir = "Dataset")

        unlink("dataset.zip", recursive = T)

        date.downloaded <- date()
        }


## read data into R

        #train data set
        subject_train <- read.table("Dataset/UCI HAR Dataset/train/subject_train.txt")
        xtrain <- read.table("Dataset/UCI HAR Dataset/train/X_train.txt")
        ytrain <- read.table("Dataset/UCI HAR Dataset/train/y_train.txt")

        #test data set
        subject_test <- read.table("Dataset/UCI HAR Dataset/test/subject_test.txt")
        xtest <- read.table("Dataset/UCI HAR Dataset/test/X_test.txt")
        ytest <- read.table("Dataset/UCI HAR Dataset/test/y_test.txt")

        #labels
        activitylabels <- read.table("Dataset/UCI HAR Dataset/activity_labels.txt")
        features <- read.table("Dataset/UCI HAR Dataset/features.txt")
        
# 1. run_analysis.R merges the training and the test sets to create one data set

        # make one dataset for train data set (add subject id and activtiy)
        
                 train_merged <- xtrain %>%
                                        mutate(subject = as.factor(subject_train$V1), activity = as.factor(ytrain$V1)) %>%
                                        select(subject, activity, V1:V561)
                
        # make one test dataset (add subject id and activity)
        
                test_merged <- xtest %>%
                                        mutate(subject = as.factor(subject_test$V1), activity = as.factor(ytest$V1)) %>%
                                        select(subject, activity, V1:V561)
        

        # merge the two datasets (train_merged and test_merged)
        
        mergeddata <- merge(train_merged, test_merged, all=T) 


# 2. run_analysis.R extracts only the measurements on the mean and standard deviation for each measurement

        #indices for mean and standard dev

        index <- grep("mean\\(|std\\(",features$V2)
        
        #only use indexed columns, aka the ones that contain mean or std
        
        meandata <- select(mergeddata, subject, activity, index+2)
        

# 3. run_analysis.R uses descriptive activity names to name the activities in the data set (from activitylabels)
        
        meandata <- mutate(meandata, activity = recode(activity, "1"="WALKING", "2"="WALKING_UPSTAIRS",
                                                        "3"="WALKING_DOWNSTAIRS", "4"="SITTNG", 
                                                        "5"="STANDING", "6"="LYING"))
        

# 4. run_analysis.R appropriately labels the data set with descriptive variable names (from features)
        
        col.from <- names(meandata[3:68]) # names of columns in dataset (old names)
        
        col.to <- as.character(features$V2[index][!is.na(features$V2[index])]) #new column names 
        
        setnames(meandata, col.from, col.to)
        
        #write tidy dataset into a text file "tidydata.txt"
        
        write.table(meandata, "tidydata.txt", row.names = FALSE)


        
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.


        summarydata <- meandata %>%
                        
                        group_by(subject,activity) %>%
                        summarise_all(mean)

        #write summarised dataset into a text file "summarydata".txt
        
        write.table(summarydata, "summarydata.txt", row.names = FALSE)

        
        
                        
                        
                        
                        