{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf200
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red33\green91\blue198;\red249\green249\blue249;
}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c16078\c44706\c81961;\cssrgb\c98039\c98039\c98039;
}
\margl1440\margr1440\vieww12840\viewh12340\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 Data and data transformation\
\
Data: Human Activity Recognition Using Smartphones Dataset\
Version 1.0\
\
The original data sets include test (30%) and training (70%) data sets for the project. The objective of the R script is to merge the test and training data sets to create a single data set that cont\cf2 ain the average of each variable for each activity and each subject. The data transformation steps are as follows:\
\cf0 \
1.Test and training data is downloaded as UCI HAR Dataset in the working directory \'91~/R/data/\'91 from the following url:\
\pard\pardeftab720\partightenfactor0
\cf3 \cb4 \expnd0\expndtw0\kerning0
\ul \ulc3 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip\cf0 \cb1 \kerning1\expnd0\expndtw0 \ulnone \
\
2. Each data set is read in using read.table\
\
3. For each measurement, including subjects and activities, test and training data sets are merged by row using mergefile function. The resulting merged files are stored in the global environment for future use.\
\
4. Original test and training files are removed from the workspace.\
\
5. Mean and standard deviation are calculated for each measurement by row using apply function, resulting in a new data frame, meansd.\
\
6. Activity descriptions are added as factor to the merged label file.\
\
7. Aggregate the means for each measurement by groups of subject ID and activity time.\
\
8. Write .txt file to the working directory.
\fs28 \
\
}