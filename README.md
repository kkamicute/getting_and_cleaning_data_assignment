# getting_and_cleaning_data_assignment

This repository is the assignment submitted for the Coursera course "getting and cleaning data".

Data used for assignment are https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
I used files named X_train, y_train, subject_train, X_test, y_test, subject_test, activity_labels, features, and features_info.

=====Follow these steps("run_analysis.R") and you'll get the same result("tidydata.txt") as I did===== 

1. Load files( X_train, y_train, subject_train, X_test, y_test, subject_test, activity_labels, features) using read.table.

2. Merge data sets. First, by using cbind(), merge subject_train, y_train, X_train as one data set, and then merge subject_test, y_test, X_test as another. Second, by using rbind(), merge the two data sets to make data frame named "dataset".

3. Read "features_info.txt" to understand the types of variables. Next, using grep() and regular expressions, get the numeric vector which indicates the locations of mean and std variables. Using this vector, extract those variables.

4. Now, we want to give specific names to the elements in the activity column. Use for loop and sub().

5. This time, we want to give specific names to the name of each column. This task is done by creating a character vector containing all the specific names, and then assigning that vector to the names(dataset).

6. Finally, we want to make a tidy set that contains average of each variable by subject and activity, respectively. I used apply() function, and tapply() as an annonymous function. Next, use rbind() to make one data frame.

7. Use write.table() to export the tidy set created in step 6. 

