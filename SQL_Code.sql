/* 
Below are the queries I used within BigQuery to parse and analyze the data for my project. Each separate entry will be accompanied by its purpose.
A limitation I had was the ability to remove values or columns within the software I was using as it was not possible unless the original data source was altered after.
*/

--Counts the unique number of users on each table using joins. (35 total users surveyed)
SELECT 
  COUNT(DISTINCT da.Id) AS act_id, 
  COUNT(DISTINCT sd.Id) AS sleep_id, 
  COUNT(DISTINCT wl.Id) AS weight_id, 
  COUNT(DISTINCT actt.Id) AS actt_id
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
FULL JOIN `new-project-437320.fitbit_user_data.sleep_day` AS sd ON da.Id = sd.Id
FULL JOIN `new-project-437320.fitbit_user_data.weight_log` AS wl ON da.Id = wl.Id
FULL JOIN `new-project-437320.fitbit_user_data.active_time` AS actt ON da.Id = actt.Id;

--Checks users that are present within all tables. (9 total shared users)
SELECT DISTINCT
  da.Id AS act_id,
  sd.Id AS sleep_id, 
  wl.Id AS weight_id, 
  actt.Id AS actt_id
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
JOIN `new-project-437320.fitbit_user_data.sleep_day` AS sd ON da.Id = sd.Id
JOIN `new-project-437320.fitbit_user_data.weight_log` AS wl ON da.Id = wl.Id
JOIN `new-project-437320.fitbit_user_data.active_time` AS actt ON da.Id = actt.Id;

--Sets the basis for a new column to check percent activity across users. "total_waking_minutes" is then added to the csv file on Google Sheets.
SELECT 
  DISTINCT actt.Id,
  (da.SedentaryMinutes + da.LightlyActiveMinutes + da.FairlyActiveMinutes + da.VeryActiveMinutes) AS total_waking_minutes
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
FULL JOIN `new-project-437320.fitbit_user_data.sleep_day` AS sd ON da.Id = sd.Id
FULL JOIN `new-project-437320.fitbit_user_data.weight_log` AS wl ON da.Id = wl.Id
FULL JOIN `new-project-437320.fitbit_user_data.active_time` AS actt ON da.Id = actt.Id;

--Uses the previously made column "total_waking_minutes" to calculate our new column "percent_active" and assess how active the user base is with the time that they are conscious.
--New column is again added to the Google Sheet.
SELECT 
  DISTINCT actt.Id,
  ((ActiveTime/TotalWakingMin) * 100) AS percent_active
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
FULL JOIN `new-project-437320.fitbit_user_data.sleep_day` AS sd ON da.Id = sd.Id
FULL JOIN `new-project-437320.fitbit_user_data.weight_log` AS wl ON da.Id = wl.Id
FULL JOIN `new-project-437320.fitbit_user_data.active_time` AS actt ON da.Id = actt.Id
WHERE (ActiveTime/TotalWakingMin) IS NOT NULL 
  AND (ActiveTime/TotalWakingMin) != 0
ORDER BY percent_active DESC;

--Gives an average value for each user's percent activity if they've tracked multiple days of entries.
SELECT 
  actt.Id,
  AVG(PercentActive) AS avg_percent_active
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
FULL JOIN `new-project-437320.fitbit_user_data.sleep_day` AS sd ON da.Id = sd.Id
FULL JOIN `new-project-437320.fitbit_user_data.weight_log` AS wl ON da.Id = wl.Id
FULL JOIN `new-project-437320.fitbit_user_data.active_time` AS actt ON da.Id = actt.Id
WHERE PercentActive IS NOT NULL 
  AND PercentActive != 0
GROUP BY actt.Id
ORDER BY avg_percent_active DESC;

--Finds the average percent active across the group. The average percent for the group is 32.3%.
SELECT 
  AVG(PercentActive) AS overall_avg_percent_active,
  COUNT(*) AS valid_record_count
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
FULL JOIN `new-project-437320.fitbit_user_data.sleep_day` AS sd ON da.Id = sd.Id
FULL JOIN `new-project-437320.fitbit_user_data.weight_log` AS wl ON da.Id = wl.Id
FULL JOIN `new-project-437320.fitbit_user_data.active_time` AS actt ON da.Id = actt.Id
WHERE PercentActive IS NOT NULL 
  AND PercentActive != 0;

--References the span of dates holding logged info in our dataset. Date range is 3/12/2016-5/1/2016.
SELECT DISTINCT ActivityDate
FROM `new-project-437320.fitbit_user_data.daily_activity`; 

--Shows the number of unique users that entered data on a given day. Results show that no more than 3 unique users logged data on any given day. 
--(This limits comparison of the test population as a whole as we do not have the same time frame logged for all users.)
SELECT 
  ActivityDate,
  COUNT(DISTINCT da.Id) AS distinct_users_per_day
FROM `new-project-437320.fitbit_user_data.daily_activity` da
GROUP BY ActivityDate
ORDER BY ActivityDate;

--I ran one last query to determine how much variance we had with the population's tracking data. This query tracks how many separate days each user logged data.
--There was one user that logged 18 days of activity, otherwise, every other user ranged between 4 and 1 different days of entry.
--Based on what I've found out, there is a small amount of data to work with to track trends based on dates across users. It would be more applicable to average the activity provided overall.
SELECT 
  DISTINCT da.Id,
  COUNT(DISTINCT ActivityDate)
FROM `new-project-437320.fitbit_user_data.daily_activity` da
  GROUP BY da.Id;

--This is the query that tells us the averages that we can plot to check for correlation between steps and calories. RERFERENCE *Average Steps and Calories.png
SELECT 
  da.Id,
  SUM(da.Calories) AS total_calories,
  SUM(da.TotalSteps) AS total_steps,
  (SUM(da.Calories) / COUNT(da.ActivityDate)) AS avg_calories,
  (SUM(da.TotalSteps) / COUNT(da.ActivityDate)) AS avg_steps
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
WHERE da.Calories IS NOT NULL AND da.TotalSteps IS NOT NULL
GROUP BY da.Id
ORDER BY da.Id;

--Grabs the next table for analysis. Shows how many unique users reported to the weight log dataset. (13 total unique users.)
SELECT
  DISTINCT wl.Id
FROM `new-project-437320.fitbit_user_data.weight_log` AS wl;

--Displays total logged weight entries per user. Two users had many logged entries compared to the whole (44,33), while the rest did not log above 6 entries.
SELECT 
  wl.Id,
  COUNT(wl.Id) AS num_entries
FROM `new-project-437320.fitbit_user_data.weight_log` AS wl
GROUP BY wl.Id
ORDER BY num_entries DESC;

--Final function to check how users were using the Fitbit to track weight measures. Ten of thirteen users manually reported their weight data.
--There was little if any correlation to a method that resulted in a user tracking more data overall in this sample.
SELECT 
  wl.Id,
  COUNT(wl.Id) AS num_entries,
  SUM(
    CASE 
    WHEN wl.IsManualReport = TRUE THEN 1 
    ELSE 0 
    END) AS num_manual_entries
FROM `new-project-437320.fitbit_user_data.weight_log` AS wl
GROUP BY wl.Id
ORDER BY num_entries DESC;

--Pulls the number of users that logged an activity for a distance. Five total users used the Fitbit function to log an activity prior to completing it.
SELECT
  da.Id,
  COUNT(da.Id) AS num_logs,
  SUM(da.TotalDistance) AS total_distance,
  SUM(da.LoggedActivitiesDistance) AS total_logged_activities_distance
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
WHERE da.LoggedActivitiesDistance IS NOT NULL AND da.LoggedActivitiesDistance != 0
GROUP BY da.Id
ORDER BY num_logs DESC;

--Ran the previous query without the 'where' clause to grab and chart the total sample. Data shows little adoption of the logged activities function and data does not strongly correlate to 'more use = more logged activity'.
SELECT
  da.Id,
  COUNT(da.Id) AS num_logs,
  SUM(da.TotalDistance) AS total_distance,
  SUM(da.LoggedActivitiesDistance) AS total_logged_activities_distance
FROM `new-project-437320.fitbit_user_data.daily_activity` AS da
GROUP BY da.Id
ORDER BY num_logs DESC;
