## Comments
##
##
## Retrieve raw data file and unzip
##
## Open relevant libraries
library(dplyr)

## Define file URL
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Download ZIP file to specific folder in working directory
download.file(fileURL, destfile = "week4ass_data/temp.zip", mode = "wb")

## Unzip ZIP file to Week4Ass folder (outDir)
outDir <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data"
unzip("C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/temp.zip", exdir = outDir)

## Load test and training datasets into respective dataframes from data (TXT) files
train_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/train/X_train.txt"
test_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/test/X_test.txt"
df_train <- read.table(train_fl, sep = "") 
df_test <- read.table(test_fl, sep = "") 

## Load Subject data for each respective dataset into data frames to append to datasets
train_sub_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/train/subject_train.txt"
test_sub_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/test/subject_test.txt"
df_train_sub = read.table(train_sub_fl, sep = "")
df_test_sub = read.table(test_sub_fl, sep = "")

## Load Training lables for each respective dataset into data frames to append to datasets
train_lab_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/train/y_train.txt"
test_lab_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/test/y_test.txt"
df_train_lab = read.table(train_lab_fl, sep = "")
df_test_lab = read.table(test_lab_fl, sep = "")

## Append Subject and Training labels as new columns to Train and Test datasets 
df_train <- cbind(df_train_sub, df_train_lab, df_train)
df_test <- cbind(df_test_sub, df_test_lab, df_test)

## Assignment Step 1 - Merge datasets within dataframes
df_total <- rbind(df_train, df_test)

## Load feature names from features.txt to a dataframe, so they can be later appended to merged dataset
features_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/features.txt"
features <- read.table(features_fl)

## Assignment Step 3 - Transpose features dataframe and add subject and activity code column titles
df_features <- t(features)
sub_col <- "subject"
activity <- "activity_code"
df_features <- cbind(sub_col, activity, df_features)

## Assignment Step 2 - Subset complete data frame (df_total) for just columns that include mean() OR std()
colnames(df_total) <- df_features[2,]
df_total <- df_total[, grep("subject|activity_code|*mean()*|*std()*", colnames(df_total))]

## Assignment Step 4 - Load activity labels to lookup data frame (df_act_lab), and perform lookup to replace
## activity codes in df_total
activ_lab_fl <- "C:/Users/Gus McLennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/activity_labels.txt"
df_act_lab = read.table(activ_lab_fl, sep = "")

df_total$activity_code <- df_act_lab[,2][match(df_total$activity_code, df_act_lab[,1])]

## Load new lookup table that contains descriptive variable names 
## features_fl <- "C:/Users/gus.mclennan/Documents/Working dir/week4ass_data/UCI HAR Dataset/features_desc.txt"
## features_desc <- read.table(features_fl)

## Assignment step 5 - Create second data frame (df_mean) which groups data by subject and activity, and calculates
## the mean of each variable
df_mean <- df_total %>%
  group_by(subject, activity_code) %>%
  summarise_all(funs(mean))
 
## Generate output file of mean data from data frame df_mean
write.table(df_mean, file = "Assignment Week 4 - Merged Mean Data.txt", row.name=FALSE)