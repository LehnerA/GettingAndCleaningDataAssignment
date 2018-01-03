# CodeBook for Human Activity Recognition Using Smartphones Dataset
The raw data set (Version 1.0) is provided by:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

## Data Input
The input data for the analysis are the training and the test sets including the list of all features, activity labels as well as training and test labels.
The description of these files can be found in "UCI HAR Dataset/README.txt".
The file "UCI HAR Dataset/features_info.txt" gives detailled description how the values have been collected and preprocessed.

This is a list of files used for data analysis:
- features.txt
- activity_labels.txt
- train/X_train.txt
- train/y_train.txt
- train/subject_train.txt
- test/X_test.txt
- test/y_test.txt
- test/subject_test.txt

## Data Processing
The training and test data sets have been merged to a single data set where the numeric activities have been replaced by the activity labels.
Afterwards, only measurements on mean and standard deviation variables have been extracted from the data set to form a new data set being the basis for the output data set.
These are all variables including mean() and std() in the header.

## Data Output
The output is a set of mean values for the following groups:
- subject
- activity type

The mean value is calculated for every variable in the data set for each subject and each activity type.
As described in "UCI HAR Dataset/features_info.txt" the signals include time domain and frequency domain signals denoted with the prefix 't' and 'f' respectively.
Furthermore the infix 'Acc' denotes accelerometer signals and the infix 'Gyro' denotes gyroscope signals.
The time domain signals' units for accelerometer signals are 'g' (standard gravity units) and for gyroscope signals are 'radians/second'.
The frequency domain signals' units follow the same convention as the time domain signals. The units for accelerometer signals are 'g/Hz' and for gyroscope signals 'radians/(second * Hz)'.
The postfix '-mean' for every variable denotes the average for the variable for the corresponding group (subject and activity type).

### Structure of the data (columns)
1 subject id (int 1 - 30)
2 activity (factor with 6 levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
3 tBodyAcc-mean()-X-mean
4 tBodyAcc-mean()-Y-mean
5 tBodyAcc-mean()-Z-mean
6 tBodyAcc-std()-X-mean
7 tBodyAcc-std()-Y-mean
8 tBodyAcc-std()-Z-mean
9 tGravityAcc-mean()-X-mean
10 tGravityAcc-mean()-Y-mean
11 tGravityAcc-mean()-Z-mean
12 tGravityAcc-std()-X-mean
13 tGravityAcc-std()-Y-mean
14 tGravityAcc-std()-Z-mean
15 tBodyAccJerk-mean()-X-mean
16 tBodyAccJerk-mean()-Y-mean
17 tBodyAccJerk-mean()-Z-mean
18 tBodyAccJerk-std()-X-mean
19 tBodyAccJerk-std()-Y-mean
20 tBodyAccJerk-std()-Z-mean
21 tBodyGyro-mean()-X-mean
22 tBodyGyro-mean()-Y-mean
23 tBodyGyro-mean()-Z-mean
24 tBodyGyro-std()-X-mean
25 tBodyGyro-std()-Y-mean
26 tBodyGyro-std()-Z-mean
27 tBodyGyroJerk-mean()-X-mean
28 tBodyGyroJerk-mean()-Y-mean
29 tBodyGyroJerk-mean()-Z-mean
30 tBodyGyroJerk-std()-X-mean
31 tBodyGyroJerk-std()-Y-mean
32 tBodyGyroJerk-std()-Z-mean
33 tBodyAccMag-mean()-mean
34 tBodyAccMag-std()-mean
35 tGravityAccMag-mean()-mean
36 tGravityAccMag-std()-mean
37 tBodyAccJerkMag-mean()-mean
38 tBodyAccJerkMag-std()-mean
39 tBodyGyroMag-mean()-mean
40 tBodyGyroMag-std()-mean
41 tBodyGyroJerkMag-mean()-mean
42 tBodyGyroJerkMag-std()-mean
43 fBodyAcc-mean()-X-mean
44 fBodyAcc-mean()-Y-mean
45 fBodyAcc-mean()-Z-mean
46 fBodyAcc-std()-X-mean
47 fBodyAcc-std()-Y-mean
48 fBodyAcc-std()-Z-mean
49 fBodyAccJerk-mean()-X-mean
50 fBodyAccJerk-mean()-Y-mean
51 fBodyAccJerk-mean()-Z-mean
52 fBodyAccJerk-std()-X-mean
53 fBodyAccJerk-std()-Y-mean
54 fBodyAccJerk-std()-Z-mean
55 fBodyGyro-mean()-X-mean
56 fBodyGyro-mean()-Y-mean
57 fBodyGyro-mean()-Z-mean
58 fBodyGyro-std()-X-mean
59 fBodyGyro-std()-Y-mean
60 fBodyGyro-std()-Z-mean
61 fBodyAccMag-mean()-mean
62 fBodyAccMag-std()-mean
63 fBodyBodyAccJerkMag-mean()-mean
64 fBodyBodyAccJerkMag-std()-mean
65 fBodyBodyGyroMag-mean()-mean
66 fBodyBodyGyroMag-std()-mean
67 fBodyBodyGyroJerkMag-mean()-mean
68 fBodyBodyGyroJerkMag-std()-mean
