# Read data

# setwd("~/UCI HAR Dataset/test")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
subjecttest <- read.table("subject_test.txt")
# setwd("~/UCI HAR Dataset/train")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
subjecttrain <- read.table("subject_train.txt")
# setwd("~/UCI HAR Dataset")
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

# Subject files: Each row identifies the subject who carried 
# out the activity. Its range is from 1 to 30.

# X files: A 561-feature vector with time and frequency domain
# variables. 

# Y files: Each row identifies the activity label

# Apply descriptive variable names columns
colnames(xtest) <- features$V2
colnames(xtrain) <- features$V2
colnames(ytest) <- "Activity_ID"
colnames(ytrain) <- "Activity_ID"
colnames(subjecttest) <- "Subject"
colnames(subjecttrain) <- "Subject"
colnames(activities) <- c("Activity_ID","ActivityName")

# Identify and extract only columns for mean and std 
meanstd <- grep(".(mean|std)\\(",features$V2)
xtest2 <- xtest[,meanstd]
xtrain2 <- xtrain[,meanstd]

# Apply descriptive activity names
ytest2 <- merge(ytest,activities, by = "Activity_ID", sort=FALSE)
ytrain2 <- merge(ytrain,activities, by = "Activity_ID", sort=FALSE)

# Merge by columns for test and train
mergetest <- cbind(subjecttest,ytest2,xtest2)
mergetrain <- cbind(subjecttrain,ytrain2,xtrain2)

# Merge test and train together by row
merge <- rbind(mergetest,mergetrain)

# Tidy data
meanstd <- features[grep(".(mean|std)\\(",features$V2),]
mergeMelt <- melt(merge,id = c("Subject","Activity"),measure.vars = meanstd$V2)

tidydata <- dcast(mergeMelt, Subject + ActivityName ~ variable, mean)
