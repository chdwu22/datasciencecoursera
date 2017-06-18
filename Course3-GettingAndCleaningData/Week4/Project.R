setwd("C:\\Users\\Chengde\\Desktop\\data science JHU\\Course3-GettingAndCleaningData\\Week4")

#read features
features <- readLines("UCI HAR Dataset\\features.txt")
#remove the indices at the front
features <- sapply(features, function(x) strsplit(x, " "))
features <- matrix(unlist(features, use.names = FALSE), nrow = 2)[2,]
#extract the variables related to mean and standard deviation
mean_idx <- grep("mean", features)
std_idx <- grep("std", features)
combined_idx <- sort(c(mean_idx, std_idx))
features <- features[combined_idx]
#remove empty paretheses '()' and replace hiphen, comma, single parenthesis with underscore
features <- gsub('\\()', '', features)
features <- gsub('-', '_', features)
features <- gsub(',', '_', features)
features <- gsub('\\(', '_', features)
features <- gsub(')', '_', features)
features <- gsub('__', '_', features)
features <- gsub('_$', '', features)
features

#function to arrange raw data into matrix
to_matrix <- function(raw_data)
{
  dat <- trimws(raw_data)
  dat <- gsub('* ', ' ', dat)
  dat <- sapply(dat, function(x) strsplit(x, ' '))
  dat <- lapply(dat, function(x){x[!x ==""]})
  dat <- lapply(dat, as.numeric)
  var_cnt <- length(dat[[1]])
  matrix(unlist(dat, use.names = FALSE), ncol = var_cnt, byrow = TRUE)
}

#read train data
train_data <- readLines("UCI HAR Dataset\\train\\X_train.txt")
test_data <- readLines("UCI HAR Dataset\\test\\X_test.txt")
train_activity <- as.integer(readLines("UCI HAR Dataset\\train\\Y_train.txt"))
test_activity <- as.integer(readLines("UCI HAR Dataset\\test\\Y_test.txt"))
train_subject <- as.integer(readLines("UCI HAR Dataset\\train\\subject_train.txt"))
test_subject <- as.integer(readLines("UCI HAR Dataset\\test\\subject_test.txt"))

#convert to one single matirx
train_data <- to_matrix(train_data)
test_data <- to_matrix(test_data)

#select the data that are only related to mean and standard deviation
train_data <- train_data[,combined_idx]
test_data <- test_data[,combined_idx]

# add lables
train_data <- cbind(train_activity, train_data)
train_data <- cbind(train_subject, train_data)
test_data <- cbind(test_activity, test_data)
test_data <- cbind(test_subject, test_data)


df <- as.data.frame(rbind(train_data, test_data))
colnames(df) <- c("subject", "activity", features)
str(df)
nrow(df)
ncol(df)
#write to csv file
write.table(df, file = "tidy_data1.csv", sep = ",", row.names = FALSE)

##########################
#calculate average
df_ave <- split(df, list(df$activity, df$subject))
df_ave <- lapply(df_ave, function(x) apply(x, 2, mean))
df_ave <- as.data.frame(matrix(unlist(df_ave), ncol = ncol(df), byrow=TRUE))
colnames(df_ave) <- c("subject", "activity", features)

#write to csv file
write.table(df_ave, file = "tidy_data_average.csv", sep = ",", row.names = FALSE)
