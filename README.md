# Getting and Cleaning Data: Course Project

## Description
This repository hosts the R code and documentation files for the "Getting and Cleaning Data" Course Project.

```run_analysis.R``` is a script that tidies up and produces aggregate data for the original data set[1].

The script performs the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to Run The Script

1. Download and extract the archive to a folder named ```Dataset```.
2. Execute the ```run_analysis.R``` on that dataset which will output the results to a text file named tidydata.txt.

## Notes

A codebook is available in the repository and is named CodeBook.md.


## Dependencies
```run_ananlysis.R``` requires ```reshape```, ```plyr``` and ```data.table``` packages.


Reference:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012