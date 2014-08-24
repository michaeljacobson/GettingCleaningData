GettingCleaningData
===================
### Reading and consolidating data
Six txt files are read as data for this exercise:
- X_test.txt
- y_test.txt
- X_train.txt
- y_train.txt
- features.txt
- activity_labels.txt

Prior to this exercise, data was randomly partitioned into two sets, where 70% of subjects were selected for generating the training data and 30% the test data. 

Descriptive variable names are applied to all data before specific variables (mean and standard deviation) are extracted to be merged with defined subjects and activities.

Finally, a final merge operation combines (by row) merged test and training data.

### Tidy data file
A tidy data file has been reshaped from the merged and consolidated data using melt and dcast operations from the reshape2 package. Means for all mean() and standard deviation (std()) variables are calculated against distinct subjects and activity names.


