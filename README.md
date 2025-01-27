# BellaBeats
Google Data Analytics Capstone

The data was gathered from 35 consenting FitBit users, and I sourced it from Möbius on his Kaggle webpage, which is linked below.

https://www.kaggle.com/datasets/arashnic/fitbit

**Questions to be Answered:**

What are some identifiable trends in smart device usage?

How could these trends apply to Bella Beat customers?

How could these trends improve our marketing strategy?

**Summary**

The datasets used contain information logged from 35 different Fitbit device users who consented to their data being distributed. What I was given to work with was a fairly incomplete, two-part dataset covering two months of most of the users' histories with the device. As a sample size, it has limited value for the scope of the user base but did allow for multiple options when analyzing said data due to the smaller amount provided.

**Cleaning and Transformation:**
The most glaring issue with the raw data that we were working with was the disjointed dates. With a limited amount of data, broadening the range for comparison would allow for a more complete comparison. With a year's worth of findings, cyclical changes could've been a useful measure to document. However, two months was too sparse a sample for much beyond aggregation.

**Both sets were merged along the user id and joined the 3/12/2016-4/11/2016 data with its 4/12/2016-5/12/2016 counterpart within Google Sheets.*

Wanted to dive deeper into the daily activity data and separated the sedentary, lightly active, fairly active, very active, and calories columns into a new table to do further analysis.

The next several additions below note the adjustments made to the new table that was made.

**New table "active_time" created with the intent of adding additional columns.**

**Created column "ActiveTime" that sums all activity, exclusive of sedentary time, to show how much total time was spent moving.**

**Created column "TotalWakingMin" that sums all of the activity of a user per day and will be the final component to make the last column.**

**Final column "PercentActive" added to the active_time table. Divides ActiveTime by PercentActive to find the percent of time a user is active.**

A small correction that I made was cleaning up the number format for columns that contained decimal integers. Rounding of these columns allowed for an easier time reading through the data and comparing numbers.

**On all applicable columns, rounded the number format to the tenths place for readability and ease of use on Google Sheets.*

The final problem to tackle before I could move the data to a platform where I could utilize SQL was the date format. Doing so allowed me to port the data into BigQuery to analyze it further.

**All sheets converted date format to yyyy/mm/dd on Google Sheets.*


**Findings and Conclusion:**

User Patterns:

Related to the degree of activity users participated in when they were active, most exercise was done in the lightly active zone. This trend could either be used to reinforce the idea that Bellabeat should expand its offering of light activities like walking, yoga, etc, or instead find ways to increase users' activity on higher levels.

Many features that the Fitbit offered were scantly used. This could be a problem with the scope of our dataset, however, if the results that we did gather are indicative of a significant trend, then there are several possibilities for lesser engagement. One such possibility is that Fitbit purchasers are unaware of other features within their smart device. The other rationale may be that most users purchase a Fitbit for a specific purpose. In the case of this dataset, users may only feel that the step counter/heart rate monitor is their exclusive reason for having a smartwatch. Given this, it's important that any additions to Bellabeat's functionality or product array are marketed well and the intent is known to users so that further enhancements can be ruled on without ambiguity.

Product Features:

A feature that wasn't used as much but could still show promise is the logged activity tracker. The Fitbit user base data showed that only ~15% of the sample took the time to log an activity. What Bellabeat could do differently is add a feature to the app that provides a slew of workouts to be done. Once one of the said workouts is selected, that data can automatically be transferred over as a logged activity on their calendar. An additional example of this would be linkage with a separate website that shows trails that can be run/walked on. This way, users have increased options for planned activities that they can do and even incorporate into a routine if they discover an activity/route that they enjoy doing. It likewise allows Bellabeat to garner what parts of their workouts are popular and if they should allocate more resources towards planning them.

The present WHO recommendation is 60 minutes of moderate physical activity daily. Bellabeat could help users achieve this goal by offering a feature that tracks activity with the appropriate heart rate in this range and displays the goal for the user. Ways to gamify exercise could help increase engagement on the platform. Incentives like a reduction to a course's price, or a free session of guided help might be an effective means of rewarding a user for sticking to healthy, routine activity.

Another feature that could be added to Bellabeat's catalog might be additions to help maintain good mental health. One example would be the addition of yoga, or meditation to an individual's daily routine. Bad stress can have effects that decrease physical health as well as mental health therefore providing a solution to one may better a user's overall health and the efficacy of the app.

Product Line:

A suggestion to supplement the product line would be a Bella Beats scale that could be linked to the smartwatch device. The data that was gathered lacked substantive info to base greater comparisons on. The fat percentage category was rarely used and was only tracked by users who were manually tracking their weight metrics. If Bellabeat were to manufacture its own smart scale, users could be more likely to connect with the weight log tracking as a whole, potentially leading to more consistent logging, better trend data, and a holistic view for the user that Bellabeat could frame with a dashboard. I think BMI tracking might fail to show health progress in general, but such a measure is still widely used especially for insurance reasons and it likely makes sense to continue tabulating it for the user's knowledge.

Synopsis:

Bellabeat should continue to reinforce its mission statement by continuing to focus on women's health and wellness through visually appealing and functional products and services. They should therefore focus on improving the key features that users are subscribing to such as their activity monitoring, and sleek design. They should meanwhile look to add or further develop features like planned activities or auto logging software that will help document progress for the user and relay useful insights for product development for the company. Bellabeat should also explore enhancing its approach to mental wellness, with features like daily affirmations and planned meditation so that it may document the impact that a holistic approach has for their end-user's outcomes, to the point that Bellabeat serves a comprehensive wellness need for the women that they partner with. 
