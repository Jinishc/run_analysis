run_analysis.R
============

Getting and Cleaning Data course project

##Background

Working on data provided by Samsung of the users carrying out various activities with the phone being tied on their waist.
The final aim is to output a **tidy data set**.

##Script
The script first reads the data once the data is downloaded and unzipped.

Following are the steps involved:

1. Integrating test and training sets using rbind()
2. Extracting only the measurements on the mean and standard deviation for each measurement making use of grep()
3. Using descriptive activity names to name the activities in the data set
4. labeling the data set with descriptive activity names
5. Finally, Making a tidy data set with the average of each variable for each activity and each subject.


##Information about the Variables used can be found in the **codebook**
