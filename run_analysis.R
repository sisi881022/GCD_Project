
#1. Merges the training and the test sets to create one data set.
train.files<- list.files("./train/",pattern=".txt")
test.files<- list.files("./test/",,pattern=".txt")
train<- do.call(cbind,lapply(paste("./train/",train.files,sep=""),function(x) read.table(x,header=F)))
test<- do.call(cbind,lapply(paste("./test/",test.files,sep=""),function(x) read.table(x,header=F)))
dat<- rbind(train,test)
colnames(dat)[1]<- "SubjectID"
colnames(dat)[563]<- "ActivityID"

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# select features 
feature<- read.table("features.txt", col.names= c("index","feature"))
mean.std<- unlist(lapply(c("-mean\\(\\)","-std\\(\\)"),grep,feature$feature))
# extract data
dat.ex <- dat[,c(1,(mean.std+1),ncol(dat))]

#3. Uses descriptive activity names to name the activities in the data set
activity<- read.table("activity_labels.txt")
colnames(activity)<-c("ActivityID","Activity")
dat.ex<- merge(dat.ex,activity,by="ActivityID")

#4. Appropriately labels the data set with descriptive variable names. 
feature.ex <- feature[mean.std,]
colnames(dat.ex)[3:68]<- as.character(feature.ex$feature)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
avg.dat.ex<- aggregate(subset(dat.ex,select=-c(SubjectID,ActivityID,Activity)), by=list("SubjectID"=dat.ex$SubjectID,"Activity"=dat.ex$Activity), mean)
library(reshape2)
dat.tidy<- melt(avg.dat.ex,id=c("SubjectID","Activity"))

mean.std2<- do.call(cbind,lapply(c("-mean\\(\\)","-std\\(\\)"), grep, feature$feature))
#colnames(mean.std2)<- c("mean","std")
featureName <- str_replace(feature[mean.std2[,1], 2], "-mean\\(\\)", "")
#mean.std2<- as.data.frame(cbind(featureName,mean.std2))

col<- featureName
d.mean<- avg.dat.ex[,1:35]
d.std<- avg.dat.ex[,c(1,2,36:ncol(avg.dat.ex))]
colnames(d.mean)[3:35]<- colnames(d.std)[3:35]<- col
dat.mean<- melt(d.mean,id=c("SubjectID","Activity"))
colnames(dat.mean)<- c("SubjectID","Activity","Feature","Mean")
dat.std<- melt(d.std,id=c("SubjectID","Activity"))
colnames(dat.std)<- c("SubjectID","Activity","Feature","STD")
dat.tidy<- merge(dat.mean,dat.std,by=c("SubjectID","Activity","Feature"))
write.csv(dat.tidy, './tidyset.txt', row.names=F)
