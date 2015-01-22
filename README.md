This is a brief describing of how my run_analysis.R script work
=============
###step 1
Load dplyr package into R for using the functions.
###step 2
Using read.table function to read data from 6 source files(X_test.txt,y_test.txt,subject_test.txt,X_train.txt,y_train.txt,subject_train.txt).
###step 3
Using bind_cols and bind_rows functions to merge the test and train set into one set.
###step 4
Using the variables in the features.txt file to label the data set with corresponding variable names.
###step 5
Using select and bind_cols functions to extracts only the mean and standard deviation for each measurement.
###step 6
Using the activity names in activity_labels.txt file to add descriptive activity names to name the activities in the data set.
###step 7
Using group_by and summarise_each functions to create tidy data set with the average of each variable for each activity and each subject.
###step 8
Using write.table function to write the tidy data set into a txt file named tidydataset.txt.