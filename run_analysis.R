##Read features file to get column names
featuresPath <- "./UCI HAR Dataset/features.txt"
allFeatures <- read.table(featuresPath)
featureArray <- as.character(allFeatures[,2])

##Read Train Activity Codes from y_train
trainActivitiesPath <- "./UCI HAR Dataset/train/y_train.txt"
trainActivities <- read.table(trainActivitiesPath)

##Read Train Subject Codes from subject_train
subjectActivitiesPath <- "./UCI HAR Dataset/train/subject_train.txt"
subjectActivities <- read.table(subjectActivitiesPath)

##Read Training Measurements
trainMeasurementsPath <- "./UCI HAR Dataset/train/X_train.txt"
trainMeasurements <- read.table(trainMeasurementsPath,col.names = featureArray)

##Instert activities and subjects as columns in trainMeasurements
completeTrainMeasurements <- cbind(trainMeasurements,trainActivities,subjectActivities)

##Rename train activities and subjects columns
colnames(completeTrainMeasurements)[562] <- "activity"
colnames(completeTrainMeasurements)[563] <- "subject"

##Read Test Activity Codes from y_test
testActivitiesPath <- "./UCI HAR Dataset/test/y_test.txt"
testActivities <- read.table(testActivitiesPath)

##Read Test Subject Codes from subject_test
subjectActivitiesPath <- "./UCI HAR Dataset/test/subject_test.txt"
subjectActivities <- read.table(subjectActivitiesPath)

##Read Test Measurements
testMeasurementsPath <- "./UCI HAR Dataset/test/X_test.txt"
testMeasurements <- read.table(testMeasurementsPath,col.names = featureArray)

##Instert activities and subjects as columns in testMeasurements
completeTestMeasurements <- cbind(testMeasurements,testActivities,subjectActivities)

##Rename train activities and subjects columns
colnames(completeTestMeasurements)[562] <- "activity"
colnames(completeTestMeasurements)[563] <- "subject"

##Merge completeTestMeasurements and completeTrainMeasurements
completeMeasurements <- merge(completeTestMeasurements,completeTrainMeasurements,all=TRUE)

##Extract mean() and std() columns from completeMeasurements set
###Substract column index from features having mean and std measurements
featuresMeanStd <- grep("-(mean|std)\\(\\)", featureArray)
featuresMeanStd <- append(featuresMeanStd,562,after = 67)
featuresMeanStd <- append(featuresMeanStd,563,after = 68)
###Create set using only column index from Mean - Std measurements - activity - subject 
tidyMeanStdMeasurements <- completeMeasurements[,featuresMeanStd]

##Rename activities with descriptive names
tidyMeanStdMeasurements$activity <- sub("1","walking",as.character(tidyMeanStdMeasurements$activity))
tidyMeanStdMeasurements$activity <- sub("2","walking_upstairs",as.character(tidyMeanStdMeasurements$activity))
tidyMeanStdMeasurements$activity <- sub("3","walking_downstairs",as.character(tidyMeanStdMeasurements$activity))
tidyMeanStdMeasurements$activity <- sub("4","sitting",as.character(tidyMeanStdMeasurements$activity))
tidyMeanStdMeasurements$activity <- sub("5","standing",as.character(tidyMeanStdMeasurements$activity))
tidyMeanStdMeasurements$activity <- sub("6","lying",as.character(tidyMeanStdMeasurements$activity))

##Edit column names for tidy set
tidyColNames <- colnames(tidyMeanStdMeasurements)
tidyColNames <- gsub('[.]','',tidyColNames)
tidyColNames <- tolower(tidyColNames)

##Rename column names
colnames(tidyMeanStdMeasurements) <- tidyColNames

##Create new set with averages for 66 mean and std measurements in tidyMeanStdMeasurements
tidyAverageMeanStdMeasurements <- ddply(tidyMeanStdMeasurements, .(subject, activity), function(x) colMeans(x[, 1:66]))

##Generate txt file with averages for Mean and Std measurements by activity and subject
write.table(tidyAverageMeanStdMeasurements, "tidyAverageMeanStdMeasurements.txt", row.name=FALSE)