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

--


--Sorted selected columns without the possibility of null values within the activity date section.
SELECT da.Calories, sd.HoursAsleep, da.Id, da.ActivityDate
FROM `new-project-437320.fitbit_user_data.daily_activity` as da
RIGHT JOIN `new-project-437320.fitbit_user_data.sleep_day` as sd
ON da.Id = sd.Id AND da.ActivityDate = sd.Date
WHERE da.ActivityDate IS NOT NULL
ORDER BY da.ActivityDate, da.Id ASC;
