# Cleaning and analysing accelerometer data

## Loading data sets
The script reads training and test data sets created by "DITEN - Università degli Studi di Genova" (Human Activity Recognition Using Smartphones Dataset - www.smartlab.ws).
The training and test sets are combined to a single data frame including column names as well as the subject id's of the test persons, both provided by separate text files.
Furthermore the activity id's are replaced by textual names.

## Extracting data set
After merging the data sets, only columns with mean and standard deviation values are extracted using a regular expression.

## Modifying and creating new data set
The next step includes using the dplyr package to group the new data set by subject id and activity. For every group, the mean values for every columns are calculated and combined to a new data set.
The column names of the new data set is changed to agree with the newly calculated values.
This data set is written to a new text file.