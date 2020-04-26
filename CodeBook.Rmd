---
title: "CodeBook"
author: "Yasemin"
date: "24/04/2020"
output:
  pdf_document: default
  html_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## The original Dataset

Original Data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Description 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

### Each record provides:

    Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    Triaxial Angular velocity from the gyroscope.
    Its activity label.
    An identifier of the subject who carried out the experiment.

### The original dataset includes the following files:

    *'README.txt'
    *'features_info.txt': Shows information about the variables used on the feature vector.
    *'features.txt': List of all features.
    *'activity_labels.txt': Links the class labels with their activity name.
    *'train/X_train.txt': Training set.
    *'train/y_train.txt': Training labels.
    *'train/subject_train.txt': Subject IDs.
    *'test/X_test.txt': Test set.
    *'test/y_test.txt': Test labels.
    *'test/subject_test.txt': Subject IDs.

### References

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



## New datasets tidydata and summarydata (output of run_analysis.R)


The newly generated dataset includes the mean value and standard deviation for the 3-axial signals in the X, Y and Z directions for each subject:

        * Other signals were excluded from the dataset

        * Includes the subject and activity performed

        * Both final datasets (tidydata and summarydata) can be found within the folder

        * For description of script operations and steps for modifications of the original datasets, please refer to README document
                + in short: 
                        ++ tidydata.txt:  Test and training datasets were merged and mean and std features were selected and activities and features were relabeled more intuitivley.
                        ++ summarydata.txt: the tidydata dataset was summarised. The mean of single features was calculated on a per subject/per activity basis.

    

        * Signals in tidydata
                + mean(): mean value estimated in original dataset
                + std(): standard deviation estimated in original dataset
                
        * Signals in summarydata
                + XYZ- denotes axial signal
                + mean(): mean value of mean value estimated in original dataset (per subject per activity)
                + std(): mean value of standard deviation estimated in original dataset (per subject per activity)
                
        *Signal names in both datasets (Column names):
        + Acc: data based on measurments with accelerometer
        + Gyro: data based on measurments with gyrometer
        + XYZ- denotes axial signal

                + Subject: Factor w/ 30 levels "1","3","5","6",..: 1 1 1 1 1 1 2 2 2 2 ...

                + activity: Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
                
                + tBodyAcc-mean()/std()-XYZ: num

                + tGravityAcc-mean()/std()-XYZ: num

                + tBodyAccJerk-mean()/std()-XYZ: num

                + tBodyGyro-mean()/std()-XYZ: num

                + tBodyGyroJerk-mean()/std()-XYZ: num

                + tBodyAccMag-mean()/std(): num

                + tGravityAccMag-mean()/std(): num

                + tBodyAccJerkMag-mean()/std(): num

                + tBodyGyroMag-mean()/std(): num

                + tBodyGyroJerkMag-mean()/std(): num

                + fBodyAcc-XYZ-mean()/std(): num

                + fBodyAccJerk-XYZ-mean()/std(): num

                + fBodyGyro-XYZ-mean()/std(): num

                + fBodyAccMag-mean()/std(): num

                + fBodyAccJerkMag-mean()/std(): num

                + fBodyGyroMag-mean()/std(): num

                + fBodyGyroJerkMag--mean()/std(): num
 
 tidydata:
```{r}
tidydata <- read.table("tidydata.txt",header=TRUE )
str(tidydata, list.len=5)
```

summarydata:
```{r}
summarydata <- read.table("summarydata.txt", header = TRUE)
str(summarydata, list.len=5)
```
