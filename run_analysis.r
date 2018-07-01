#Download and Unzip DataSet
if(!file.exists("./4project")){dir.create("./4project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./4project/Dataset.zip")

unzip(zipfile="./4project/Dataset.zip",exdir="./4project")

#Read in Training Data
x_train <- read.table("./4project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./4project/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./4project/UCI HAR Dataset/train/subject_train.txt")

#Read in Test Data
x_test <- read.table("./4project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./4project/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./4project/UCI HAR Dataset/test/subject_test.txt")

#Read in Features and Labels
features <- read.table('./4project/UCI HAR Dataset/features.txt')

activityLabels = read.table('./4project/UCI HAR Dataset/activity_labels.txt')

#Assign Column Names

colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Merge Test and Train Data

mrgtrain <- cbind(y_train, subject_train, x_train)
mrgtest <- cbind(y_test, subject_test, x_test)
mrgdata<- rbind(mrgtrain, mrgtest)

colnames <-colnames(mrgdata)

#Subset Data by column names we want

mean_and_std <- (grepl("activityId" , colnames) | 
                   grepl("subjectId" , colnames) | 
                   grepl("mean.." , colnames) | 
                   grepl("std.." , colnames) 
)

submrgdata <- mrgdata[ , mean_and_std == TRUE]

#take the average of each variable for each activity and each subject


final <- aggregate(. ~subjectId + activityId, submrgdata, mean)

#bring in activity description

final<- merge(final, activityLabels,
                    by='activityId',
                    all.x=TRUE)

#final tidy up of variable names

colNames<-colnames(final)

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(final)<-colNames

#ordering by subjext id then activity id

col_idx <- grep("activityType", names(final))
final <- final[, c(col_idx, (1:ncol(final))[-col_idx])]
final <- final[order(final$subjectId, final$activityId),]

#Save Tidy Data Set

write.table(final, './4project/tidyData.txt',row.names=FALSE)
