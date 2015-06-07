library(dplyr)
#path to the data set directory
PATH<-"/Users/jon/Coursera/R/Dataset/"

#After realizing there were duplicates of columns.  I decided to remove the duplicates and selected the needed columns from the test and training data immediately

#Assume the 561 rows of features.txt correspond directly to the columns of X_test.txt and X_train.txt in order

features<-read.table(paste0(PATH, "features.txt"))

#grab indices and names of desired features
feature_indices<-grep("mean|std", features$V2, value = FALSE)
feature_names<-grep("mean|std", features$V2, value = TRUE)
#check there are no duplicates mean/std columns
if(length(feature_indices)!=length(unique(feature_names))) stop("There are still duplicate columns!") else{
	V= paste("There are", length(feature_indices), "unique columns to select from training and test data")
print(V)	
}

#construct a class vector to load only the needed columns

vec = as.character(rep("NULL", nrow(features)))
Vec<-replace(vec,feature_indices, "numeric")

#Read in the two test and training data
test_data<-read.table(paste0(PATH, "test/X_test.txt"), colClasses=Vec)
training_data<-read.table(paste0(PATH, "train/X_train.txt"), colClasses=Vec)

test_data_activity<-read.table(paste0(PATH, "test/y_test.txt"),col.names("Activity"))
training_data_activity<-read.table(paste0(PATH, "train/y_train.txt"),col.names("Activity"))
test_subject<-read.table(paste0(PATH, "test/subject_test.txt"), col.names("Subject"))
training_subject<-read.table(paste0(PATH, "train/subject_train.txt"),col.names("Subject"))

activities<-read.table(paste0(PATH, "activity_labels.txt"))