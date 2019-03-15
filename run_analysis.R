#list files in the folders
testfile<-list.files(path='~/R/data/UCI HAR Dataset/test/',pattern = ".txt",full.names = TRUE)
testinertialfile<-list.files(path='~/R/data/UCI HAR Dataset/test/Inertial Signals/',pattern = ".txt",full.names = TRUE)
trainfile<-list.files(path='~/R/data/UCI HAR Dataset/train/',pattern = ".txt",full.names = TRUE)
traininertialfile<-list.files(path='~/R/data/UCI HAR Dataset/train/Inertial Signals/',pattern = ".txt",full.names = TRUE)
#read .txt test files
SubjectTest<-read.table(testfile[[1]])
xtest<-read.table(testfile[[2]])
testlabel<-read.table(testfile[[3]])
bodyacc_xtest<-read.table(testinertialfile[[1]])
bodyacc_ytest<-read.table(testinertialfile[[2]])
bodyacc_ztest<-read.table(testinertialfile[[3]])
bodygyro_xtest<-read.table(testinertialfile[[4]])
bodygyro_ytest<-read.table(testinertialfile[[5]])
bodygyro_ztest<-read.table(testinertialfile[[6]])
totalacc_xtest<-read.table(testinertialfile[[7]])
totalacc_ytest<-read.table(testinertialfile[[8]])
totalacc_ztest<-read.table(testinertialfile[[9]])

#read .txt training files
SubjectTrain<-read.table(trainfile[[1]])
xtrain<-read.table(trainfile[[2]])
trainlabel<-read.table(trainfile[[3]])
bodyacc_xtrain<-read.table(traininertialfile[[1]])
bodyacc_ytrain<-read.table(traininertialfile[[2]])
bodyacc_ztrain<-read.table(traininertialfile[[3]])
bodygyro_xtrain<-read.table(traininertialfile[[4]])
bodygyro_ytrain<-read.table(traininertialfile[[5]])
bodygyro_ztrain<-read.table(traininertialfile[[6]])
totalacc_xtrain<-read.table(traininertialfile[[7]])
totalacc_ytrain<-read.table(traininertialfile[[8]])
totalacc_ztrain<-read.table(traininertialfile[[9]])

# mergefile function with merge test and training files, find out the measurement name and store the merged file in the global environment
# x and y arguments will be the test and trainnin file of the same measurement 
# the mergefile should have 10299 obvervations for each measurement
mergefile<-function(x,y){
        testname=deparse(substitute(x)) #find out the test name
        measurement=gsub('[Tt]est','',as.character(testname)) #remove the 'test' string in the test name
        df<-rbind(x,y) #merge test and train files
        assign(as.character(measurement),df,envir = .GlobalEnv) #save merged file to the global environment for downloading
        }

#merge files
mergefile(SubjectTest,SubjectTrain)
mergefile(testlabel,trainlabel)
mergefile(xtest,xtrain)
mergefile(bodyacc_xtest,bodyacc_xtrain)
mergefile(bodyacc_ytest,bodyacc_ytrain)
mergefile(bodyacc_ztest,bodyacc_ztrain)
mergefile(bodygyro_xtest,bodygyro_xtrain)
mergefile(bodygyro_ytest,bodygyro_ytrain)
mergefile(bodygyro_ztest,bodygyro_ztrain)
mergefile(totalacc_xtest,totalacc_xtrain)
mergefile(totalacc_ytest,totalacc_ytrain)
mergefile(totalacc_ztest,totalacc_ztrain)

#remove used files
remove(SubjectTest,xtest,testlabel,bodyacc_xtest,bodyacc_ytest,bodyacc_ztest,bodygyro_xtest,bodygyro_ytest,bodygyro_ztest,totalacc_xtest,totalacc_ytest,totalacc_ztest)
remove(SubjectTrain,xtrain,trainlabel,bodyacc_xtrain,bodyacc_ytrain,bodyacc_ztrain,bodygyro_xtrain,bodygyro_ytrain,bodygyro_ztrain,totalacc_xtrain,totalacc_ytrain,totalacc_ztrain)

#getting mean and standard deviation for each measurement
bodyacc_xmean=apply(bodyacc_x,1,mean);bodyacc_xsd=apply(bodyacc_x,1,sd)
bodyacc_ymean=apply(bodyacc_y,1,mean);bodyacc_ysd=apply(bodyacc_y,1,sd)
bodyacc_zmean=apply(bodyacc_z,1,mean);bodyacc_zsd=apply(bodyacc_z,1,sd)
bodygyro_xmean=apply(bodygyro_x,1,mean);bodygyro_xsd=apply(bodygyro_x,1,sd)
bodygyro_ymean=apply(bodygyro_y,1,mean);bodygyro_ysd=apply(bodygyro_y,1,sd)
bodygyro_zmean=apply(bodygyro_z,1,mean);bodygyro_zsd=apply(bodygyro_z,1,sd)
totalacc_xmean=apply(totalacc_x,1,mean);totalacc_xsd=apply(totalacc_x,1,sd)
totalacc_ymean=apply(totalacc_y,1,mean);totalacc_ysd=apply(totalacc_y,1,sd)
totalacc_zmean=apply(totalacc_z,1,mean);totalacc_zsd=apply(totalacc_z,1,sd)

#create new data frame with means and sds for each measurement
meansd<-data.frame(bodyacc_xmean,bodyacc_ymean,bodyacc_zmean,bodyacc_xsd,bodyacc_ysd,bodyacc_zsd,
                   bodygyro_xmean,bodygyro_ymean,bodygyro_zmean,bodygyro_xsd,bodygyro_ysd,bodygyro_zsd,
                   totalacc_xmean,totalacc_ymean,totalacc_zmean,totalacc_xsd,totalacc_ysd,totalacc_zsd)

#label activity names
library(plyr)
label[[1]]<-revalue(as.factor(label[[1]]),c('1'='WALKING','2'='WALKING UPSTAIR','3'='WALKING DOWNSTAIRS','4'='SITTING','5'='STANDING','6'='LAYING'))

#average of each variable for each activity and each subject.
colnames(Subject)<-'ID'; colnames(label)<-'activity'
meanbyidactivity<-cbind(Subject,label,meansd)
meanbyidactivity %>% group_by(ID,activity) %>% summarize_at(vars(bodyacc_xmean:totalacc_zsd),mean)
#write files to .txt
write.table(meanbyidactivity,file='~/R/data/UCI HAR Dataset/tidy data/meanbyidactivity.txt',row.names = FALSE)


