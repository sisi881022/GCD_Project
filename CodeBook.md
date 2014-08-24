GCD_Project
===========

Getting and Cleaning Data Course Project

## Files from Dataset needed for this project
- "activity_label.txt": list the activity labels with id
- "features.txt": list all feature names in the dataset
- "test/subject_test.txt": subject id for test dataset
- "test/X_test.txt": test dataset for all features
- "test/y_test.txt": the activity id for test dataset
- "train/subject_train.txt": subject id for train dataset
- "train/X_train.txt": train dataset for all features
- "train/y_train.txt": the activity id for train dataset

## Variables in Original Dataset

- activity: There are 6 different types of activities which coded from 1 to 6
- subject: The range from 1 to 30
- feature: 561 different feature vectors with time and frequency domain variables, and we are only interested in mean and standard deviation in this project

## Data Transformation
1. Merges the training and the test sets to create one data set
 * input: read in test and train datasets separately with subject, features, and activity id
 * output: the data frame "dat" which merged test and train by rows
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  * input: "features.txt"
  * output: 
    * the vector "mean.std" has only features we interested in (mean and standard deviation)
     * the data frame "dat.ex" which is the subset of "dat" with mean and standard deviation from all features
3. Uses descriptive activity names to name the activities in the data set
  * input: "activity_labels.txt"
  * output: "dat.ex" with a new varible of activity labels
4. Appropriately labels the data set with descriptive variable names. 
  * input: "mean.std" and "dat.ex" from previous steps
  * output: "dat.ex" with labels of column names
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  * input: "dat.ex" from last step
  * output: 
     * the data frame "avg.dat.ex" summarised the average of "dat.ex"
     * the melted data frame "dat.mean" only has mean features by melt() funtion from "reshape2" package from "avg.dat.ex"
     * the melted data frame "dat.std" has standard deviation from "avg.dat.ex"
     * the tidy data frame (final result) "dat.tidy" merged "dat.mean" and "dat.std" by each varible for each activity and each subject
     * "tidyset.txt" writed "dat.tidy" in text format

## Final dataset
The tidy dataset with 5940 rows with 5 variables which are:
- "SubjectID":  there are 1, 2, 10-22
- "Activity": the 6 activity labels
- "Feature": There are 33 signals
- "Mean": the average of mean values by the signals for each activity and subject
- "STD": the average of standard deviation values by the signals for each activity and subject

