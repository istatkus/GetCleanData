# Repository GetCleanData
Created for the Coursera Get and Clean Data Course
The purpose is to demonstrate getting data, working with data and cleaning data.
## The repository contains
1. run_analysis.R
2. CodeBook.md which describes the initial raw data, and describes the steps to clean the data  
3. README.MD

## run_analysis.R
The data consists of multiple files : Activity Labels, Subjects for train and test,  Ativities for train and test, Train and Test files each with 561 columns of measures. In later steps we will bind the Subject  for test, Activity for test and X_Test to form a single table. We will do the same with Train. Note that the final product will only contain the features that pertain to means and std.


Step 1: Get the data from the site by downloading and unzipping  
If the file is there do not redownload  
Else download  
And unzip  
Step 2: Prepare the table for Activity Label Dimension to use later to swap out the Activity id for its user friendly name   
Step 3: Prepare the table that will be used to assign the column headers of the measures  
Tidied the column names by removing the braces ()  
Selected only the columns with measures that represented means and std  
This will be used to subset the columns from the measure tables  
Step 4: Read the Train and Test tables Each has 561 columns of measures  
Each row is an observation per subject/activity id  with feature measures as a column  
Selected only the columns identified earlier that represent means and std  
Step 5: Use the feature vector to add column headers to the measures tables  
Step 6: Read the activity vectors for test and train  
This tells me for each row in the measures table what the activity was for that row     
Step 7: Read the subject vector ids who was subject in each row of the measures (X_)  
Step 8: Combine the Subject Vector, Activity and Measures into one table  
Step 9: Combine test and train into one table  
Step 10 : Switch out Activity id for its List of Value Name and convert to factor  
Step 11: Gather the wide format into a narrow one so the column becomes a row  
Summarizing to a subject, activity a single measure and  
Calculate its mean for all observations  
Step 12 write it out  


### Running run_analysis.R  
 
 In RStudio 
 1. to Open: File --> Open --> Select the Project Folder --> run_analysis.R
 2. to Run:  Code --> Run Region --> Run All or CTRL ALT R



