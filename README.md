GettingCleaningData
===================
### Reading data

Six txt files are read as data for this exercise:
- X_test.txt
- y_test.txt
- X_train.txt
- y_train.txt
- features.txt
- activity_labels.txt

#### X files
A 561-feature vector with time and frequency domain variables.

#### Y files
Each row identifies the activity label

#### Subject Files
Each row identifies the subject who carried out the activity. Its range is from 1 to 30.

### Apply descriptive variable names columns
Descriptive variable names are applied to X files, Y files, Subject files, and activity files as follows:
- colnames(xtest) <- features$V2
- colnames(xtrain) <- features$V2
- colnames(ytest) <- "Activity_ID"
- colnames(ytrain) <- "Activity_ID"
- colnames(subjecttest) <- "Subject"
- colnames(subjecttrain) <- "Subject"
- colnames(activities) <- c("Activity_ID","ActivityName")

### Identify and extract only columns for mean and standard deviation

meanstd <- grep(".(mean|std)\\(",features$V2)
xtest2 <- xtest[,meanstd]
xtrain2 <- xtrain[,meanstd]

### Descriptive Acitivity Names
Apply descriptive activity names to Y file rows via merge operations.
- ytest2 <- merge(ytest,activities, by = "Activity_ID", sort=FALSE)
- ytrain2 <- merge(ytrain,activities, by = "Activity_ID", sort=FALSE)

### Merge by columns for test and train
Augmented x files, y files, and subject files are merged via column binding operations.
- mergetest <- cbind(subjecttest,ytest2,xtest2)
- mergetrain <- cbind(subjecttrain,ytrain2,xtrain2)

### Final merge
mergetest and mergetrain data is merged via row binding operation.
- merge <- rbind(mergetest,mergetrain)

### Tidy data
Final tidy data containing only averages (or means) for all variables by Subject and ActivityName is processed via reshaping final merge from above.
- meanstd2 <- features[grep(".(mean|std)\\(",features$V2),]
- mergeMelt <- melt(merge,id = c("Subject","Activity"),measure.vars = meanstd2$V2)
- tidydata <- dcast(mergeMelt, Subject + ActivityName ~ variable, mean)

