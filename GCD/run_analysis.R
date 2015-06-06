#path to the data set directory
PATH<-"/Users/jon/Coursera/R/Dataset/"

#load tables -- for larger tables check if it already exists in workshpace
if(!("training_data" %in% ls() )) training_data<-read.table(paste0(PATH, "train/X_train.txt"))
if(!("test_data" %in% ls() )) test_data<-read.table(paste0(PATH, "test/X_test.txt"))
test_datay<-read.table(paste0(PATH, "test/y_test.txt"))
training_datay<-read.table(paste0(PATH, "train/y_train.txt"))
test_subject<-read.table(paste0(PATH, "test/y_test.txt"))
training_subject<-read.table(paste0(PATH, "train/y_train.txt"))
features<-read.table(paste0(PATH, "features.txt"))
activities<-read.table(paste0(PATH, "activity_labels.txt"))