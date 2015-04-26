This REPO includes the run_analysis.R script and de Code Book describing the variables included in the tidyAverageMeanStdMeasurements dataset.

run_analysis.R is a script in R programing language that uses the following files as inputs:
-features.txt
-y_train.txt
-X_train.txt
-y_test.txt
-X_test.txt

The output of this script is the file:
-tidyAverageMeanStdMeasurements.txt

run_analysis.R works as follows:
- Read features file to get column names for the 561 original measurements and store it in a character array "featureArray"
##For the train activities:
- Read train activity codes from y_train file and store it in "trainActivities"
- Read train subject codes from subject_train file and store it in "subjectActivities"
- Read training measurements from X_train file. It uses the featureArray to assign the column names to the 561 measurements and store it in "trainMeasurements". 
- Instert activities and subjects as columns in "trainMeasurements" from the "trainActivities" and "subjectActivities" sets.
- Rename train activities and subjects columns as "activity" and "subject"
- Generate "completeTrainMeasurements" with 561 measurements, activity and subject columns.

##For the test activities:
- Read test activity codes from y_test file and store it in "testActivities"
- Read test subject codes from subject_test file and store it in "subjectActivities"
- Read testing measurements from X_test file. It uses the featureArray to assign the column names to the 561 measurements and store it in "testMeasurements". 
- Instert activities and subjects as columns in "testMeasurements" from the "testActivities" and "subjectActivities" sets.
- Rename test activities and subjects columns as "activity" and "subject"
- Generate "completeTestMeasurements" with 561 measurements, activity and subject columns.

- Merge completeTestMeasurements and completeTrainMeasurements in completeMeasurements data set.

- Substracts column indexes from features having mean and std measurements in the "featureArray" to use them to subset the "completeMeasurements" set.
- Appends the activity and subject column index to the "featuresMeanStd" vector to complete the measurements, activity and subject subset.
- From "completeMeasurements" set substracts the columns which index is included in "featuresMeanStd" vector and generates a new set "tidyMeanStdMeasurements".
- Replace the number in the activity code with a descriptive name according to the following list:
	- "1" - "walking"
	- "2" - "walking_upstairs"
	- "3" - "walking_downstairs"
	- "4" - "sitting"
	- "5" - "standing"
	- "6" - "lying"
- Edit column names present in the "tidyMeanStdMeasurements" by creating a new column names vector "tidyColNames" where names are all descriptive, lower case and no special characters.
- Rename column names in the "tidyMeanStdMeasurements" set using the "tidyColNames" vector.

- Creates new set with averages for 66 mean and std measurements in "tidyMeanStdMeasurements".
- Generate txt file with averages for Mean and Std measurements by activity and subject.