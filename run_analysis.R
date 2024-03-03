#Reading Training Folder
Training_set <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
Training_subject <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
Training_activity <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/train/Y_train.txt", header=FALSE, sep="")

#Reading Test Folder
Test_set <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
Test_subject <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
Test_activity <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/test/Y_test.txt", header=FALSE, sep="")

activity_labels <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")
names(activity_labels) <- c("ID", "Activity")
features <- read.table("C:/Users/Sugyeong/Desktop/coursera/week4/UCI HAR Dataset/features.txt", header=FALSE, sep="")

#Q1

Training_merge <- cbind(Training_subject, Training_activity, Training_set)
Test_merge <- cbind(Test_subject, Test_activity, Test_set)
merge <- rbind(Training_merge, Test_merge)
names(merge) <- c("Subject", "Activity", features[,2])

#Q2
mean <- select(merge, contains("mean"))
std <- select(merge, contains("std"))

#Q3
merge$Activity <- replace(merge$Activity, merge$Activity=="1", activity_labels[1,2])
merge$Activity <- replace(merge$Activity, merge$Activity=="2", activity_labels[2,2])
merge$Activity <- replace(merge$Activity, merge$Activity=="3", activity_labels[3,2])
merge$Activity <- replace(merge$Activity, merge$Activity=="4", activity_labels[4,2])
merge$Activity <- replace(merge$Activity, merge$Activity=="5", activity_labels[5,2])
merge$Activity <- replace(merge$Activity, merge$Activity=="6", activity_labels[6,2])

#4: refer to line 20

#5: bandenergy variables are excluded because they are duplicated
merge <- merge[c(-303:-344, -382:-423, -461:-502)]
SecondData <- merge %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))

write.table(SecondData, "SecondData.txt", row.name=FALSE)
