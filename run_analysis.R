#Read data
dataActivitytest<-read.table("./test/y_test.txt",header=F)
dataActivitytrain<-read.table("./train/y_train.txt",header=F)
dataSubjecttest<-read.table("./test/subject_test.txt",header=F)
dataSubjecttrain<-read.table("./train/subject_train.txt",header=F)
dataFeaturestest<-read.table("./test/X_test.txt",header=F)
dataFeaturestrain<-read.table("./train/X_train.txt",header=F)

#View the structures of the data
str(dataActivitytest)
str(dataActivitytrain)
str(dataSubjecttest)
str(dataSubjecttrain)
str(dataFeaturestest)
str(dataFeaturestrain)

#Activity labels
ActivityLabels<-read.table("activity_labels.txt",header=FALSE)

#Features
features<-read.table("features.txt",header=FALSE)

#Rename Features columns
colnames(dataFeaturestest)<-features[,2]
colnames(dataFeaturestrain)<-features[,2]

#Merge X, Y and subject
x<-rbind(dataFeaturestest,dataFeaturestrain)
y<-rbind(dataActivitytest,dataActivitytrain)
subject<-rbind(dataSubjecttest,dataSubjecttrain)

#Mean and Std
mean_std_features<-grep("-(mean|std)\\(\\)",features[, 2])
x<-x[,mean_std_features]

#loading library fot Tidy Data
library(data.table)

#Rename columns
y[,1]<-ActivityLabels[y[,1],2]
colnames(y)="Activity"
colnames(subject)="Subject"

#Generate the Tidy Data
Data<-cbind(x,y,subject)
Data.table=data.table(Data)
tidyData=aggregate(Data[,names(Data) != c('Activity','Subject')],by=list(Activity=Data$Activity,Subject = Data$Subject),mean)
write.table(tidyData, "tidyData.txt", row.name=FALSE)
