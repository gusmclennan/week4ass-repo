# run_analysis.R script description

## Code logic

This program assembles the data contained within the various data files included within the 'UCI Har Dataset' ZIP file, to create a merged master tidy data set.  The following logic was applied:
1) Load the test and training data sets (X_test.txt and X_train.txt) into data frames
2) Load the subject data for each respective data set (subject_train.txt and subject_test.txt) into data frames
3) Load the training labels for each respective data set (y_train.txt and y_test.txt) into data frames
4) Append subject and training labels as new column to the Train and Test datasets
5) Merge test and training data sets into one consolidated data frame (df_total)
6) Load feature names from feature.txt to a data frame, then transpose features names to df_total as column names for variables

The next step is to subset the total data set for only measures involving mean and standard deviation.

The activity labels were then loaded into a separate data frame and applied to the subsetted data frame to replace activity codes with their associated labels.

The final step was to create a separate data frame which groups the data by subject and activity, and calculates the mean for each variable.  An output tidy data file is generated from the new data frame as 'Assignment Week 4 - Merged Mean Data.txt'
