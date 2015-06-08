#This script reads in and analyzes the data set given in UCI HAR Dataset.  The general structure is --
#	Determine desired data
#	Read in desired and supplemental data
#	Clip together this data
#	Output a table of the averages of the readings for by activity per subject
#
#For more information consult README.txt


library(dplyr)
library(plyr)
#path to the data set directory
PATH<-"/Users/jon/Coursera/R/Dataset/"


#Determine the desired columns to use
features<-read.table(paste0(PATH, "features.txt"),stringsAsFactors=FALSE)

#grab indices and names of columns with mean or std in them 
feature_indices<-grep("mean\\(\\)|std\\(\\)", features$V2, value = FALSE)
feature_names<-grep("mean\\(\\)|std\\(\\)", features$V2, value = TRUE)

#check there are no duplicates mean/std columns
if(length(feature_indices)!=length(unique(feature_names))) stop("There are still duplicate columns!") else{
	print(paste("There are", length(feature_indices), "unique columns to select from training and test data"))	
}

#construct a class vector to load only the needed columns
vec = as.character(rep("NULL", nrow(features)))
Vec<-replace(vec,feature_indices, "numeric")

#Read in the two test and training data
test_data<-read.table(paste0(PATH, "test/X_test.txt"), colClasses=Vec)
training_data<-read.table(paste0(PATH, "train/X_train.txt"), colClasses=Vec)

#read supplemental tables
test_data_activity<-read.table(paste0(PATH, "test/y_test.txt"),col.names="Activity")
training_data_activity<-read.table(paste0(PATH, "train/y_train.txt"),col.names="Activity")
test_subject<-read.table(paste0(PATH, "test/subject_test.txt"), col.names="Subject")
training_subject<-read.table(paste0(PATH, "train/subject_train.txt"),col.names="Subject")
activities<-read.table(paste0(PATH, "activity_labels.txt"),stringsAsFactors=FALSE)



#check dimension and bind columns test data
if(length(unique(c(nrow(test_data_activity),nrow(test_subject),nrow(test_data))))==1){
	complete_test_table<-bind_cols(test_subject,test_data_activity, test_data)
	
#let user know it went well
	print(paste("....test data has been combined into a table  of", nrow(complete_test_table), "by", ncol(complete_test_table)))
     }         
       
#check dimension and bind columns training data
if(length(unique(c(nrow(training_data_activity),nrow(training_subject),nrow(training_data))))==1){
	complete_training_table<-bind_cols(training_subject,training_data_activity, training_data)
	
#let user know it went well
	print(paste("....training data has been combined into a table  of", nrow(complete_training_table), "by", ncol(complete_training_table)))
     }  
       


#check dimension and bind rows
if(ncol(complete_training_table)==ncol(complete_test_table)){
		complete_table<-bind_rows(complete_test_table,complete_training_table)

#let user know it went well
	print(paste("....all data has been combined into a table  of", nrow(complete_table), "by", ncol(complete_table)))
	
}
      
      
       
#update colnames for complete_table
if((length(feature_names)+2)==ncol(complete_table)){
	colnames(complete_table)<-c("Subject", "Activity", feature_names)
 }      
#replace the activity numbers with strings
complete_table$Activity<-mapvalues(complete_table$Activity, as.character(1:6), activities$V2)
     
     
#group by activity and summarize
final_summary<-summarise_each(group_by(complete_table, Activity,Subject) ,funs(mean),c(-Subject, -Activity))

#output table into file called output.txt
write.table(final_summary, "output.txt", row.names=FALSE)
