#fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileurl,destfile="CEP1ZIPDATA.zip")
#unzip the file to create the data folder "UCI HAR Dataset"
#master data 
columnsnames<-read.table("./UCI HAR Dataset/features.txt")
activitylables<-read.table("./UCI HAR Dataset/activity_labels.txt")
#testdata
testdata<-read.table("./UCI HAR Dataset/test/X_test.txt")
names(testdata)<-columnsnames[,2]
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
activitybysubjecttestdata<-read.table("./UCI HAR Dataset/test/y_test.txt")
names(subjecttest)<-"Person"
testdata<-cbind(subjecttest,testdata)
activitybysubjecttestdata = merge(x = activitybysubjecttestdata,y = activitylables,by = "V1",all.x = TRUE)
names(activitybysubjecttestdata)<-c("id","Activity")
testdata<-cbind(testdata,activitybysubjecttestdata[2])
#traindata
traindata<-read.table("./UCI HAR Dataset/train/X_train.txt")
names(traindata)<-columnsnames[,2]
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activitybysubjecttraindata<-read.table("./UCI HAR Dataset/train/y_train.txt")
names(subjecttrain)<-"Person"
traindata<-cbind(subjecttrain,traindata)
activitybysubjecttraindata = merge(x = activitybysubjecttraindata,y = activitylables,by = "V1",all.x = TRUE)
names(activitybysubjecttraindata)<-c("id","Activity")
traindata<-cbind(traindata,activitybysubjecttraindata[2])
#merging datasets
fulldata<-rbind(traindata,testdata)
pattern <- c('mean()','std()','Activity','Person')
fulldata_needed<-fulldata[,grepl(paste0(pattern,collapse="|"),colnames(fulldata))]
#Preparing Aggregate data frame
library(dplyr)
tidydata<- fulldata_needed %>% group_by(Person,Activity) %>%  summarise_each(funs(mean(., na.rm=TRUE)))
write.table(tidydata,file="tidydata.txt",row.names = FALSE,col.names = TRUE)
