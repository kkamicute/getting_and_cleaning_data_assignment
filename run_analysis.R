# Read all the files
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")

y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")

subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

# Merge the training and the test sets to create one data set.
trainSet <- cbind(subject_train, y_train, X_train)
testSet <- cbind(subject_test, y_test, X_test)
dataset <- rbind(trainSet, testSet)

# Extract only mean and std (after checking "features.txt" and "features_info.txt")
meanLocation <- grep(".*mean()[^Freq]", features$V2)
stdLocation <- grep(".*std()", features$V2)

meanTable <- dataset[meanLocation + 2 ]
stdTable <- dataset[stdLocation + 2]

# Use descriptive activity names to name the activities in the data set
labels <- activity_labels$V2
for(i in c(1:6)){dataset[,2] <- sub(i, labels[i], dataset[,2])}

# label the data set with descriptive variable names
nameVector <- names(dataset)
featureVector <- as.character(features$V2)
nameVector[1] <- "Subject"
nameVector[2] <- "Activity"
nameVector[3:563] <- featureVector

names(dataset) <- nameVector

# create a second, independent tidy data set with the average of each variable for each activity and each subject

#library(dplyr)
#subjectGroup <- group_by(dataset[,-2], Subject)
#activityGroup <- group_by(dataset[,-1], Activity)
#averageBySubject <- summarize(subjectGroup, mean)
#averageByActivity <- summarize(activityGroup, mean)
#newDataset <- rbind(averageBySubject, averageByActivity)

averageBySubject <- apply(dataset[,-c(1:2)], 2, function(x) tapply(x, dataset$Subject, mean)) 
averageByActivity <- apply(dataset[,-c(1:2)], 2, function(x) tapply(x, dataset$Activity, mean))
newDataset <- rbind(averageBySubject, averageByActivity)

write.table(newDataset, "tidydata.txt", row.names = FALSE)