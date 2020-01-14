# Samsung_HAR_Dataset (getting and cleaning data project)

This is the process that "run_analysis.R" follows to get the tidy data of the HAR database:

1. Downloads the zip file of the dataset and unzipes it
2. Extracts all the info of train, test, activity and features
3. Merges rows of the train and test dataframes
4. Renames the name of the columns with "subject", "activity" and all the features
5. Keeps only the means and standard deviations of the variables. Removes any column without the string "mean()" or "std()"
6. Reassigns the values of activity with their proper name 
7. Groups the dataset by subject and activity
8. Computes the mean of each variable for each subject and each activity.  

The script returns a file called "tidyDF.txt" that contains the tidy data.
