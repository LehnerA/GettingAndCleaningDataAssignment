library(dplyr)

# function to load the data sets
mergeSmartphoneData <- function(directory, activity.labels, feature.labels)
{
    # load training data sets
    train.data <- loadData(paste0(directory, "/train"), "train")
    # load test data sets
    test.data <- loadData(paste0(directory, "/test"), "test")
    
    # make data frame of test data
    smartphone.data.test <- as.data.frame(as.data.frame(test.data))
    # make data frame of train data
    smartphone.data.train <- as.data.frame(as.data.frame(train.data))
    
    # setup column names of smartphone dataset
    smartphone.data.names <- c("subjectId", "dataType", "activity", as.character(feature.labels[[2]]))
    
    # write the column names of the data sets to allow combining them
    colnames(smartphone.data.test) <- smartphone.data.names
    colnames(smartphone.data.train) <- smartphone.data.names
    
    # combine both train and test data sets to a complete data set
    smartphone.data <- rbind(smartphone.data.test, smartphone.data.train)
    
    #  replace the activity numbers with the according labels
    smartphone.data$activity <- lapply(smartphone.data$activity, function(x)
    {
        if(x == 1)
        {
            x <- as.character(activity.labels[[1,2]])
        }
        else if (x == 2)
        {
            x <- as.character(activity.labels[[2,2]])
        }
        else if (x == 3)
        {
            x <- as.character(activity.labels[[3,2]])
        }
        else if (x == 4)
        {
            x <- as.character(activity.labels[[4,2]])
        }
        else if (x == 5)
        {
            x <- as.character(activity.labels[[5,2]])
        }
        else if (x == 6)
        {
            x <- as.character(activity.labels[[6,2]])
        }
    })
    
    # make a factor of the activities
    smartphone.data$activity <- as.factor(unlist(smartphone.data$activity))
    
    return(smartphone.data)
}

extractMeanAndStdValues <- function(dataset, feature.labels)
{
    # get all column names with mean and standard deviation values
    mean.std.colnames <- grep("mean\\(\\)|std\\(\\)", unlist(feature.labels[[2]]), value = TRUE)
    # extract these columns as well as the subject id data type and activity
    return(dataset[, c("subjectId", "dataType", "activity", mean.std.colnames)])
}

loadData <- function(directory, datatype)
{
    # read the subject ids of the data set
    data.subjects <- read.table(paste0(directory, "/subject_", datatype, ".txt"))
    # read the data set
    data.set <- read.table(paste0(directory, "/X_", datatype, ".txt"))
    # read the activities for the data set
    data.activity <- read.table(paste0(directory, "/y_", datatype, ".txt"))
    
    # return a list of all the read values -> include the data type (training or test set value)
    return(list(data.subjects, rep(toupper(datatype), nrow(data.subjects)), data.activity, data.set))
}

calculateMeansForColumns <- function(dataset)
{
    require(dplyr)
    # group data by subject id and activity
    # summarize all numeric values by calculating the mean value
    # ungroup the data and arrange by subject id
    avg <- dataset %>%
               group_by(subjectId, activity) %>%
               summarize_if(is.numeric, mean) %>%
               ungroup() %>%
               arrange(subjectId)
    # set the column names of the newly calculated columns by adding "mean"
    colnames(avg)[-(1:2)] <- paste(colnames(avg)[-(1:2)], "mean", sep ="-")
    
    return(avg)
}

# read the text files from the folder "UCI HAR Dataset" into a single data set
directory <- "UCI HAR Dataset"

# get activity labels
activity.labels <- read.table(paste0(directory, "/activity_labels.txt"))

# get features
feature.labels <- read.table(paste0(directory, "/features.txt"))

# 1st, 3rd, 4th step: merge smartphone data into one data set, set the activity names, set the variable names
merged.smartphone.data <- mergeSmartphoneData(directory, activity.labels, feature.labels)

# 2nd step: extract only mean and standard deviation
extracted.smartphone.data <- extractMeanAndStdValues(merged.smartphone.data, feature.labels)

# 5th step: new data set -> average of each variable for each activity and each subject
avg.smartphone.data <- calculateMeansForColumns(extracted.smartphone.data)

# write the table with the data
write.table(avg.smartphone.data, "accelerometer_data_set_averages.txt", sep = " ", row.names = FALSE, col.names = FALSE, quote = FALSE)
