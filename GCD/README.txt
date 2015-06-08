README file for run_analysis.R (Getting and Cleanning Data course project)


The purpose of this script is take the date UCI HAR Dataset and calculate the mean for each activity's data per subject in the research.


Through this file there are ** to mark author's commentary.  The notes can be found at the end of this file.


Sections in this README

1. Organization of the Script
2. Data 
3. Library Requirements
4. Some Details about the Script
5. Ouput
^. Author's Notes 






1. Organization of the Script

General Outline
1. Determine desired data
2. Read in desired and supplemental data
3. Clip together this data
4. Output a table of the averages of the readings for by activity per subject

Before running the script one must set the PATH variible found at the top of the script to point to the directory in which the data was unpacked.  In future work one may improve the user interface by taking this variable as user input.

In order to run this script be certain it is your working directory and type source("run_analysis.R").  If you store the script ourside your workind directory, either change directories or type source("COMPLETE_PATH_TO_SCRIPT") where ideally COMPLETE_PATH_TO_SCRIPT is an absolute path to the script.







2. Data

There are several files in the UCI HAR Dataset directory.  The following are quick explanations of each file.  For more information see the README that accompanies the files.

activity_labels.txt		List of 6 activities used for measurements
features.txt			List of 561 values collected (561 includes duplicates)
X_train.txt			Readings from training subjects			
X_test.txt			Readings from test subjects
y_train.txt			Activity numbers for each set of readings in X_train.txt
y_test.txt			Activity numbers for each set of readings in X_test.txt
subject_train.txt		Subject which took the readings from X_train.txt
subject_test.txt		Subject which took the readings from X_test.txt


Several assumptions were made about data.  Perhaps the most important is that the number of row of features.txt order-wise match the columns in X_test.txt and X_train.txt.   In addition, when extracting means and standard deviations, only the columns ending in mean() and std() were used.  This choice was made because meanfreq() expressed the weighted averages of frequencies instead of an average of the raw data collected. **1     







3. Library Requirements

The script requires two libraries -- dplyr and plyr.   Both need to be installed and sourced before running this script.







4. Some Details about the Script

Before clipping data, there are dimension checks to make sure the data will fit properly.  **2  In particular, 

if(length(unique(c(nrow(test_data_activity),nrow(test_subject),nrow(test_data))))==1)

which checks that there is only one distinct value for the length of test_data_activity, test_subject, and test_data (i.e. the lengths are the same distinct value).  Similar checks are performed before combining training data and row binding.

The plyr package is used for only function -- mapvalues().  This was not covered as far as I know in class, so quickly the function works like this -- mapvalues(VECTOR, VECTOR_VALUES, VECTOR_REPLACE).  It will replace component-wise which instance of VECTOR_VALUES with values in VECTOR_REPLACE found in VECTOR.   




5. Output

The script automatically generates a nuw file call output.txt.  This will be generated in the working directory.   The output should be 180x66 table of averagtes for each activity by subject.







6. Author's Notes

**1 The data set was small enough, I was ok reading it all initially.  This changed when I realized there are duplicate columns in the data.  After this, I choice to get rid of unneeded columns as quick as possible.

**2  I realize it is completely not an issue here, we know dimensions will match.  However, I due to past trauma, I could not bare to omit it.