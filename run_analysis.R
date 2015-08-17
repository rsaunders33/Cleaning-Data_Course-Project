### Load Libraries

        library(dplyr)
        library(reshape2)


### Read in Raw Data

        #Read Test Data
        X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
        y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
        subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
        
        #Read Train Data
        X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
        y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
        subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
        
        #Read Activity Labels
        ActivityMap<-read.table("UCI HAR Dataset/activity_labels.txt")
        
        #Read Features
        features<-read.table("UCI HAR Dataset/features.txt")


### Binding

        #add Activity and Subject to test and train data
        test<-cbind(y_test,subject_test,X_test)
        train<-cbind(y_train,subject_train,X_train)
                       
        #Combine test and train data
        data.combined<-rbind(test,train)


### Define Descriptive Names for Measures
        
        #Find Rows in features that Contain "mean() or std()"
        measures.loc<-grep("mean[(][)]|std[(][)]",features[,2],ignore.case=TRUE)
        
        #Identify Label in features that Contain "mean() or std()"
        measures.names<-as.character(features[measures.loc,2])

        #Convert Cryptic Measure Name into Descriptive Name (see Read.Me for more info)
        convertMeasure<-function(x){
                string.measure<-ifelse(grepl("mean[(][)]",x,ignore.case=TRUE),"Average of","Standard Deviation of")
                string.signal<-ifelse(grepl("^t",x,ignore.case=TRUE),"Time","Frequency")
                string.accOrGyro<-ifelse(grepl("gyro",x,ignore.case=TRUE),"Angular Velocity","Acceleration")
                string.acctype<-ifelse(grepl("gravity",x,ignore.case=TRUE),"Gravity","Body")
                string.jerkLogic<-ifelse(grepl("jerk",x,ignore.case=TRUE),"Jerk Series","Series")
                string.axis<-ifelse(grepl("[-]X$|[-]Y$|[-]Z$",x,ignore.case=TRUE),paste("(Across",substr(x,nchar(x),nchar(x)),"axis)"),"(Magnitude)")
                paste(string.measure, string.acctype, string.accOrGyro, string.signal, string.jerkLogic, string.axis)
        }
        
        measure.descrnames<-sapply(measures.names,convertMeasure)

        
### Filter out only columns that have mean() or std() measures from measures.loc from above
        
        #Make a Vector of Locations to Filter (add 1 and 2 to account for Activity and Subject - Add 2 to measures.loc as well)
        filter.loc<-c(1,2,measures.loc+2)
        
        #Select only above columns from the xandy merged data set
        data.final<-data.combined[,filter.loc]

        
### Rename Columns to descriptive names
        
        #Create vector of descriptive names, starting with Activity and Subject
        measures.final<-c("Activity.ID","Subject",measure.descrnames)

        #Assign to data.final column names
        colnames(data.final)<-measures.final


### Change Activity ID to Descriptive Name
        
        #Merge Activity Map with Final Data to add column for Activity Name
        data.final<-merge(data.final,ActivityMap,by.x="Activity.ID", by.y="V1",all=TRUE)
        
        #Move Activity Name to the Beginning and rename (also remove activity id)
        new.order<-c(length(data.final),2:length(data.final)-1)
        data.final<-data.final[,new.order]
        colnames(data.final)[1]<-"Activity.Name"
        
        #Remove Activity ID
        data.final<-select(data.final,-Activity.ID)
  
        
### Create Second Tidy Data Set with average of each variable for each activity and each subject
        
        #Melt Data
        data.melt <- melt(data.final,id.vars=c("Activity.Name","Subject"),value.name="Value",variable.name="Measure")
        
        #dcast data to original format where value represents mean
        avg.data.final<-dcast(data.melt,Activity.Name + Subject ~ Measure,mean,value.var="Value")

        #Write Data to Table and Tell the User
        write.table(avg.data.final,"Tidy Data.txt")
        print("A file called Tidy Data.txt has been placed in your working directory. Use read.table to view the output")