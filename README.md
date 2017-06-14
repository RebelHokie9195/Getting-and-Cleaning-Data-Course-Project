# Getting-and-Cleaning-Data-Course-Project
This repository contains the required submissions for Coursera Getting and Cleaning Data course project

This project utilizes the following dataset:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The assignment was as follows:

    You should create one R script called run_analysis.R that does the following:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set.
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity   and each subject.

This repository contains my R script in a file entitled run_analysis.R.  This file accomplishes these objectives in the following steps:

1.  Merges the training and the test set.
  a.  Create a data directory if it does not already exist.
  b.  Download the zipped file where the data is stored online (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into the data directory.
  c.  Unzip the files in the zipped file.
  d.  Create tables based upon unzipped files.
    i.  activity_labels.txt: a text description for each numeric, coded variable for activity  
    ii.  features.txt: contains the list of abbreviated variable (column) names for the collected data
    iii.  subject_test.txt:  contains the number of the test participant for each row of data in the test set
    iv.  X_test.txt:  contains the data for each variable in each row of the test set
    v.  Y_test.txt: contains the numeric, coded activity for each row of data in the test set
    vi.  subject_train.txt:  contains the number of the test participant for each row of data in the training set
    vii.  X_train.txt:  contains the data for each variable in each row of the training set
    viii.  Y_train.txt:  contains the numeric, coded activity for each row of data in the training set
  e.  Rename columns of data sets with feature names.
  f.  Rename columns of test subject identifiers.
  g.  Rename columns of activity levels.
  h.  Add subject identifier and activity label columns to data sets.
  i.  Combine training and test data sets.  This set is called mergedData.

2.  Extracts only the measurements on the mean and standard deviation for each measurement.
  a.  
