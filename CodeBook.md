# CodeBook

## Data
The dataset is collected from the accelerometers of the Samsung Galaxy S smartphone. It contains measurements on the mean and standard deviation for each measurement.

## Variables
- `subject`: Subject identifier
- `activity`: Activity performed by the subject
- `tBodyAcc-mean()-X`, `tBodyAcc-mean()-Y`, `tBodyAcc-mean()-Z`: Mean body acceleration in X, Y, Z directions
- `tBodyAcc-std()-X`, `tBodyAcc-std()-Y`, `tBodyAcc-std()-Z`: Standard deviation of body acceleration in X, Y, Z directions
- ...

## Transformations
- Merged the training and test sets.
- Extracted only the measurements on the mean and standard deviation.
- Used descriptive activity names.
- Labeled the dataset with descriptive variable names.
- Created a tidy dataset with the average of each variable for each activity and each subject.
