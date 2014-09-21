##Reading training set
train_x <- read.table("cloud_data/UCI HAR Dataset/train/X_train.txt")

##Reading test set
test_x <- read.table("cloud_data/UCI HAR Dataset/test/X_test.txt")

##reading training labels
train_y <- read.table("cloud_data/UCI HAR Dataset/train/y_train.txt")

##reading test label
test_y <- read.table("cloud_data/UCI HAR Dataset/test/y_test.txt")

##subjects who took part in the training set
subject_train <- read.table("data_cloud/UCI HAR Dataset/train/subject_train.txt")

##subjects who took part in the test set
subject_test <- read.table("data_cloud/UCI HAR Dataset/test/subject_test.txt")

##activities
activity_lables <- read.table("data_cloud/UCI HAR Dataset/activity_labels.txt")


features<-read.table("data_cloud/UCI HAR Dataset/features.txt")


##============================================================================================##

##Merging the training and the test sets.
complete_x <-rbind(train_x,test_x)


##================================================================================================##
##Extracting only the measurements on the mean and standard deviation for each measurement.

colnames(complete_x) <- c(as.character(features[,2]))

mean<-grep("mean()",colnames(complete_x),fixed=TRUE)

sd<-grep("std()",colnames(complete_x),fixed=TRUE)

meansd<-complete_x[,c(mean,sd)]


#=====================================================================================================##
#Using descriptive activity names to name the activities in the data set.

complete_y<-rbind(train_y,test_y)

activity<-cbind(complete_y,meansd)

colnames(activity)[1] <- "Activity"


##========================================================================================================##
##labeling the data set with descriptive activity names.

activity_lables[,2]<-as.character(activity_lables[,2])

for(i in 1:length(activity[,1])){
  activity[i,1]<-activity_lables[activity[i,1],2]
}

##==========================================================================================================##
##Making a tidy data set with the average of each variable for each activity and each subject.

subject_all<-rbind(subject_train,subject_test)

all<-cbind(subject_all,activity)

colnames(all)[1] <- "Subject"

Tidy_data <- aggregate( all[,3] ~ Subject+Activity, data = all, FUN= "mean" )

for(i in 4:ncol(all)){
  Tidy_data[,i] <- aggregate( all[,i] ~ Subject+Activity, data = all, FUN= "mean" )[,3]
}

colnames(Tidy_data)[3:ncol(Tidy_data)] <- colnames(meansd)

##=============================================================================================================##
##Writing the data into a file.

write.table(Tidy_data, file = "tidy_data.txt", row.names=FALSE)

