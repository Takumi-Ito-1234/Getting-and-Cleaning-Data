library(dplyr)

#Merges the training and the test sets to create one data set.
#fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileurl, "./data.zip", method = "curl")
#unzip("./data.zip")

df_feature <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
df_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
df_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
df_all <- rbind(df_train, df_test)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
TF_mean_std <- grepl("mean\\(\\)", df_feature$V2) | grepl("std\\(\\)", df_feature$V2)
df_mean_std <- df_all[, TF_mean_std]

#Uses descriptive activity names to name the activities in the data set
col_name <- df_feature[TF_mean_std, ]

#Appropriately labels the data set with descriptive variable names. 
names(df_mean_std) <- col_name$V2

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
df2 <- lapply(df_mean_std, mean)

write.table(df_mean_std, "./data.txt", quote = FALSE, row.names = FALSE)

col_name$V1 <- 1:nrow(col_name)
write.table(col_name, "./feature.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
