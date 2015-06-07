library(dplyr)



#path to the data set directory
PATH<-"/Users/jon/Coursera/R/Dataset/"

#load tables -- for larger tables check if it already exists in workshpace
if(!("training_data" %in% ls() )) training_data<-read.table(paste0(PATH, "train/X_train.txt"))
if(!("test_data" %in% ls() )) test_data<-read.table(paste0(PATH, "test/X_test.txt"))
test_data_activity<-read.table(paste0(PATH, "test/y_test.txt"))
training_data_activity<-read.table(paste0(PATH, "train/y_train.txt"))
test_subject<-read.table(paste0(PATH, "test/subject_test.txt"))
training_subject<-read.table(paste0(PATH, "train/subject_train.txt"))
features<-read.table(paste0(PATH, "features.txt"))
activities<-read.table(paste0(PATH, "activity_labels.txt"))


#find the dimensions of these tables/created mostly to make error handling more readable
dim_test_data<-dim(test_data)
dim_training_data<-dim(training_data)
dim_test_activity<-dim(test_data_activity)
dim_training_activity<-dim(training_data_activity)
dim_test_subject<-dim(test_subject)
dim_training_subject<-dim(training_subject)

#catch cbind errrs and check for the same number of rows

tryCatch(complete_test_table<-cbind(test_subject,test_data_activity, test_data),
        simpleError=function(error) {if(!length(unique(c(dim_test_activity[1],dim_test_subject[1],dim_test_data[1])))==1){print("Dimension mismatch in test data")}
                    else{print(error)}})

tryCatch(complete_training_table<-cbind(training_subject,training_data_activity, training_data),
        simpleError=function(error) {if(!length(unique(c(dim_training_activity[1],dim_training_subject[1],dim_training_data[1])))==1){print("Dimension mismatch in training data")}
                    else{print(error)}})


#rbind training data and test data given they have the same number of columns

tryCatch(complete_table<-rbind(complete_training_table, complete_test_table),
        simpleError=function(error) {if(ncol(complete_training_table)!=ncol(complete_test_table)){print("Dimension mismatch between test and training data")}
                    else{print(error)}})








#Clean up workspace













