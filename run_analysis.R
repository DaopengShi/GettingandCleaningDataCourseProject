library(dplyr)
#Read data from the source files.
Xtestdata<-read.table("UCI HAR Dataset/test/X_test.txt",
                      stringsAsFactors = FALSE)

ytestdata<-read.table("UCI HAR Dataset/test/y_test.txt",
                      stringsAsFactors = FALSE)
ytestdata<-rename(ytestdata,ActivityID=V1)

subjecttestdata<-read.table("UCI HAR Dataset/test/subject_test.txt",
                            stringsAsFactors = FALSE)
subjecttestdata<-rename(subjecttestdata,SubjectID=V1)

Xtraindata<-read.table("UCI HAR Dataset/train/X_train.txt",
                       stringsAsFactors = FALSE)

ytraindata<-read.table("UCI HAR Dataset/train/y_train.txt",
                       stringsAsFactors = FALSE)
ytraindata<-rename(ytraindata,ActivityID=V1)

subjecttraindata<-read.table("UCI HAR Dataset/train/subject_train.txt",
                             stringsAsFactors = FALSE)
subjecttraindata<-rename(subjecttraindata,SubjectID=V1)
#Merge test set and train set into one set.
testset<-bind_cols(Xtestdata,ytestdata,subjecttestdata)
trainset<-bind_cols(Xtraindata,ytraindata,subjecttraindata)
wholeset<-bind_rows(testset,trainset)
#Labels the data set with descriptive variable names. 
featuresdata<-read.table("UCI HAR Dataset/features.txt",
                         stringsAsFactors = FALSE)
colnames(wholeset)<-make.names(c(featuresdata$V2,"ActivityID","SubjectID"),
                               unique = TRUE)
wholeset<-as.data.frame(wholeset)
#Extracts only the mean and standard deviation for each measurement.
desiredata1<-select(wholeset,contains("mean.",ignore.case = FALSE))
desiredata2<-select(wholeset,contains("std.",ignore.case = FALSE))
desiredata3<-select(wholeset,one_of("ActivityID","SubjectID"))
desireset<-bind_cols(desiredata1,desiredata2,desiredata3)
#Add descriptive activity names to name the activities in the data set.
activitydata<-read.table("UCI HAR Dataset/activity_labels.txt",
                         stringsAsFactors = FALSE)
desireset<-left_join(desireset,activitydata,by=c("ActivityID"="V1"))
desireset<-rename(desireset,Activity=V2)
desireset<-select(desireset,-ActivityID)
#Create tidy data set with the average of each variable for each activity 
#and each subject.
resultset<-desireset %>% 
  group_by(SubjectID,Activity) %>%
  summarise_each(funs(mean))
#Write the tidy data set into tidydataset.txt.
write.table(resultset,file="tidydataset.txt",row.names = FALSE,
            quote = FALSE,eol="\r\n")