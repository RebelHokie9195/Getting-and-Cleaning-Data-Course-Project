#This is code to complete the course project for Getting and Cleaning Data.
#There are 5 objectives of this project/assignment, which are enumerated below.
#This code is structured to complete those objectives in order.

#Objective 1: Merges the training and the test sets to create one data set.

#Create a data directory if it does not already exist.
if(!file.exists("./data")){dir.create("./data")}

#Name of the zipped file where the data is stored.
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Download the zipped file.
download.file(fileURL, destfile = "./data/Dataset.zip")

#Unzip the files in the zipped file.
unzip("./data/Dataset.zip",exdir="./data")

#Create tables based upon unzipped files.
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./data/UCI HAR Dataset/features.txt")
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./data/UCI HAR Dataset/train/Y_train.txt")

#Rename columns of data sets with feature names.
names(X_test)<-features[,2]
names(X_train)<-features[,2]

#Rename columns of test subject identifiers.
names(subject_test)<-as.character("Subject Number")
names(subject_train)<-as.character("Subject Number")

#Rename columns of activity levels.
names(Y_test)<-as.character("Activity")
names(Y_train)<-as.character("Activity")

#Add subject identifier and activity label columns to data sets.
X_test<-cbind(subject_test,Y_test, X_test)
X_train<-cbind(subject_train,Y_train, X_train)

#Combine training and test data sets.
mergedData<-rbind(X_train,X_test)


#Objective 2: Extracts only the measurements on the mean and standard deviation for each measurement.

#Get the columns with -mean() or -std() in their names.
meansanddevsindices<-grep("-mean\\(\\)|-std\\(\\)",names(mergedData))
meansanddevs<-mergedData[meansanddevsindices]

#Get all the desired columns in one table, including subject number and activity.
subjectandactivity<-mergedData[1:2]
extractedData<-cbind(subjectandactivity,meansanddevs)


#Objective 3. Uses descriptive activity names to name the activities in the data set.

#Merge table of extracted data and table of activity labels.
extractedData<-merge(extractedData,activity_labels,by.x="Activity",by.y="V1")

#Reorder columns again by cutting and pasting.
Subject<-extractedData[,2]
Activity<-extractedData[,69]
dataOnly<-extractedData[,3:68]
extractedData2<-cbind(Subject,Activity,dataOnly)


#4. Appropriately labels the data set with descriptive variable name

#Decode the abbreviated column names.
colnames<-names(extractedData2)
colnames<-gsub("^t","Time Domain ",colnames)
colnames<-gsub("^f","Frequency Domain ",colnames)
colnames<-gsub("Body{1}", "Body ",colnames)
colnames<-gsub("BodyBody","Body Body ",colnames)
colnames<-gsub("Acc","Accelerometer ",colnames)
colnames<-gsub("Jerk","Jerk ",colnames)
colnames<-gsub("Gyro","Gyroscope ",colnames)
colnames<-gsub("mean\\(\\)","Mean ",colnames)
colnames<-gsub("std\\(\\)","Standard Deviation ",colnames)
colnames<-gsub("\\-","",colnames)
colnames<-gsub("X","X-axis ",colnames)
colnames<-gsub("Y","Y-axis ",colnames)
colnames<-gsub("Z","Z-axis ",colnames)
colnames<-gsub("Mag","Magnitude ",colnames)
names(extractedData2)<-colnames


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)

#Melt the data around the id variables of Subject and Activity.
meltedData<-melt(extractedData2,id=c("Subject","Activity"))

#Cast the melted data separately around Subjects and Activities.
Means<-dcast(meltedData,Subject+Activity~variable,mean)

#Write the tidy data to a file.
write.table(Means, './data/TidyData.txt',row.names=FALSE,sep='\t')
