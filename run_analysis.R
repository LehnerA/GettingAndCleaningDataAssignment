library(dplyr)

# function to load the data sets
mergeSmartphoneData <- function(directory, activity.labels, feature.labels)
{
    # load training data sets
    train.data <- loadData(paste0(directory, "/train"), "train")
    # load test data sets
    test.data <- loadData(paste0(directory, "/test"), "test")
    
    # combine data
    smartphone.data.test <- as.data.frame(as.data.frame(test.data))
    
    smartphone.data.train <- as.data.frame(as.data.frame(train.data))
    
    # setup column names of smartphone dataset
    smartphone.data.names <- c("subjectId", "dataType", "activity", as.character(feature.labels[[2]]))
    
    colnames(smartphone.data.test) <- smartphone.data.names
    colnames(smartphone.data.train) <- smartphone.data.names
    
    smartphone.data <- rbind(smartphone.data.test, smartphone.data.train)
    
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
    
    smartphone.data$activity <- as.factor(unlist(smartphone.data$activity))
    
    return(smartphone.data)
}

extractMeanAndStdValues <- function(dataset, feature.labels)
{
    mean.std.colnames <- grep("mean\\(\\)|std\\(\\)", unlist(feature.labels[[2]]), value = TRUE)
    return(dataset[, c("subjectId", "dataType", "activity", mean.std.colnames)])
}

loadActivityLabels <- function(filename)
{
    return(read.table(filename))
}

loadFeatureLabels <- function(filename)
{
    return(read.table(filename))
}

loadData <- function(directory, datatype)
{
    data.subjects <- read.table(paste0(directory, "/subject_", datatype, ".txt"))
    data.set <- read.table(paste0(directory, "/X_", datatype, ".txt"))
    data.activity <- read.table(paste0(directory, "/y_", datatype, ".txt"))
    
    return(list(data.subjects, rep(toupper(datatype), nrow(data.subjects)), data.activity, data.set))
}

calculateMeansForColumns <- function(dataset)
{
    require(dplyr)
    avg <- dataset %>%
               group_by(subjectId, activity) %>%
               summarize_if(is.numeric, mean) %>%
               ungroup() %>%
               arrange(subjectId)
    colnames(avg)[-(1:2)] <- paste(colnames(avg)[-(1:2)], "mean", sep ="-")
    
    return(avg)
}

# read the text files from the folder "UCI HAR Dataset" into a single data set
directory <- "UCI HAR Dataset"

# get activity labels
activity.labels <- loadActivityLabels(paste0(directory, "/activity_labels.txt"))

# get features
feature.labels <- loadFeatureLabels(paste0(directory, "/features.txt"))

# 1st, 3rd, 4th step: merge smartphone data into one data set, set the activity names, set the variable names
merged.smartphone.data <- mergeSmartphoneData(directory, activity.labels, feature.labels)

# 2nd step: extract only mean and standard deviation
extracted.smartphone.data <- extractMeanAndStdValues(merged.smartphone.data, feature.labels)

# 5th step: new data set -> average of each variable for each activity and each subject
avg.smartphone.data <- calculateMeansForColumns(extracted.smartphone.data)
