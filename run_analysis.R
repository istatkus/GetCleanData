## Get and Clean Data Assignment
## Set up the environment
## Class: Get and Clean Data 
## Objective take data from smartphone activity tracker and tidy it
##
## Acknowledge
##[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
##A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
## 21th European Symposium on Artificial Neural Networks, Computational Intelligence and 
## Machine Learning,ESANN 2013. Bruges, Belgium 24-26 April 2013. 
##

setwd("C:/Users/irene/Desktop/CourseraDS/GetCleanData/prj")
library(dplyr)
library(tidyr)
library(stringr)
library(reshape2)
##
## Step 1: Get the data by Downloading and unzipping

myfile <- "C:/Users/irene/Desktop/CourseraDS/GetCleanData/prj/getdata_dataset.zip"

if ( !file.exists (myfile)){
    fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, myfile)
    } 
if ( !file.exists("UCI HAR Dataset")) { 
  unzip( myfile) 
}

## Step 2: Prepare the table for Activity to use later to swap out the code

activityLov <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Step 3: Prepare the table for the feature column headers to use later
##         ran into double column name issue with select trying new approach 
##         but left the replace to remove brackets

features <- read.table("./UCI HAR Dataset/features.txt")
##         saving off the second column that has the names

features <-features[,2]

##         use names and removing the brackets by replacing with a null string
features2 <-str_replace(features, "[()]","") ## left one of the brackets behind 
features2 <-str_replace(features2, "[()]","")  ## removed the other side of the bracket

##         grep uses pattern match to identify where the columns with mean,Mean,std
##         subsetting my list of columns (features2) picking only the menas/std

features <- grep("*mean*|*std*|*Mean*", features2)
Colnames <- features2[features]

## Step 4: Read the Train and Test tables 561 columns of measures each
##         use same subsetting as for columns to pick the measures that match the mean 
##         and std columns

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")[features]
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")[features]

##         tested it dim(X_train) ## head(X_train) ## Had no column headers

## Step 5: Use the feature vector to add column headers to the measures tables

names(X_train) <-Colnames  ## add column headers
names(X_test) <- Colnames  ## add column headers

## Step 6: Read the activity vectors for test and train tells me Walkng etc

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test  <- read.table("./UCI HAR Dataset/test/y_test.txt")

##         tested it: dim(y_train) The activity id head(y_train) had no column name
##         Add a column header to the activity so you know its the activity

a <- "Activity"            ## Create a column header called Activity
names(y_train) <-a         ## Add it to y_train
names(y_test) <-a          ## Add it to y_test

## Step 7: Read the subject vector ids who was subject in each row of the measures (X_)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test  <- read.table("./UCI HAR Dataset/test/subject_test.txt")

##         tested it: unique(subject_train) ## range from 1:30
##         head(subject_train) ##had no column header

s<-"Subject"              ## Create one so we remember its the subject of the observation
names(subject_train) <-s  ## Add it to Subject Train
names(subject_test)  <-s  ## Add it to Subject Test

## Step 8 : Combine the Subject activity and Measures into one table 

trainfact <-cbind(cbind(subject_train, y_train), X_train)
testfact  <-cbind(cbind(subject_test,  y_test),  X_test)

##         head(trainfact) ## Now have Subject, Activity, Measure Columns

## Step 9: Combine test and train into one table

combinedData <-rbind(trainfact,testfact)

##         write.table(combinedData, "tester.txt",  row.names = FALSE,  quote = FALSE)
##         test case will be subject 1 LAYING first measure tBodyAcc-mean-X .22159824

## Step 10 : Switch out Activity id for its List of Value Name and convert to factor

combinedData$Activity <- factor(combinedData$Activity, 
                                levels = activityLov[,1], labels = activityLov[,2])

## also convert Subject to Factor, this is just the participant number

combinedData$Subject <- as.factor(combinedData$Subject)

## Step11: Gather or couldve melted the wide format into a narrow one
##         so each column of measures becomes a measure name in a row

tidydata <- combinedData %>%
            gather( Variable , Value, -Subject, -Activity)

## head(tidydata) now have a subject, activity, a measure, value for a observation
##         but there are multiple observations per subject/activity/measure_name

tidydata$Variable <-as.factor(tidydata$Variable)

## Step 11 summarizing to a subject, activity a single measure and 
##         calculate its mean for all observations
##         got aggregate from the R is for Everyone Book by Lander
##         having syntax errors with group by and summarize

tidydata  <-aggregate( Value ~ Subject + Activity + Variable, data = tidydata, FUN = mean)

## Step 12 write it out
##         head(tidydata) now there is one average observation for each subject, activity measure

write.table(tidydata, "tidydata.txt",  row.names = FALSE,  quote = FALSE)


## Acknowledging R for Everyone, Jared Lander 
## and numerous posts attempting to compare or explain the suble differences
## in syntax dplyr, plyr, tidyr, reshape 
## the above steps may contain some extra or un-needed steps, but it helped me verify
## based on my interpretation of the requirement


