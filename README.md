# BellaBeats
Google Data Analytics Capstone

The data was gathered from 35 consenting FitBit users, and I sourced it from Möbius on his Kaggle webpage, which is linked below.

https://www.kaggle.com/datasets/arashnic/fitbit

**Questions to be Answered:**

What are some identifiable trends in smart device usage?

How could these trends apply to Bella Beat customers?

How could these trends improve our marketing strategy?

**Summary**

The datasets used contain information logged from ~30 different Fitbit device users who consented to their data being distributed. What I was given to work with was a fairly incomplete, two-part dataset covering two months of most of the users' histories with the device. As a sample size, it has limited value for the scope of the user base but did allow for multiple options when analyzing said data due to the smaller amount provided.

**Cleaning and Transformation:**
The most glaring issue with the raw data that we were working with was the disjointed dates. With a limited amount of data, broadening the range for comparison would allow for a more complete comparison. With a year's worth of findings, cyclical changes could've been a useful measure to document. However, two months was too sparse a sample for much beyond aggregation.

**Both sets were merged along the user id and joined the 3/12/2016-4/11/2016 data with its 4/12/2016-5/12/2016 counterpart within Google Sheets.*

Wanted to dive deeper into the daily activity data and separated the sedentary, lightly active, fairly active, very active, and calories columns into a new table to do further analysis.

**New table "active_time" created with the intent of adding additional columns.**

**Created column "ActiveTime" that sums all activity, exclusive of sedentary time, to show how much total time was spent moving.**

**Created column "TotalWakingMin" that sums all of the activity of a user per day and will be the final component to make the last column.**

**Final column "PercentActive" added to the active_time table. Divides ActiveTime by PercentActive to find the percent of time a user is active.**

A small correction that I made was cleaning up the number format for columns that contained decimal integers. Rounding of these columns allowed for an easier time reading through the data and comparing numbers.

**On all applicable columns, rounded the number format to the tenths place for readability and ease of use on Google Sheets.*

The final problem to tackle before I could move the data to a platform where I could utilize SQL was the date format. Doing so allowed me to port the data into BigQuery to analyze it further.

**All sheets converted date format to yyyy/mm/dd on Google Sheets.*



**Findings and Conclusion:**
