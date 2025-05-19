CREATE DATABASE bangalore_traffic_db;
USE bangalore_traffic_db;

SELECT * FROM banglore_traffic_dataset;

#top 5 most congested areas
SELECT  `Area Name` ,AVG(`Congestion Level`) from banglore_traffic_dataset
GROUP BY `Area Name`
ORDER BY AVG(`Congestion Level`) DESC
LIMIT 5;


#Peak Traffic Times
SELECT date, HOUR(date) AS hour, SUM(`traffic volume`) AS total_traffic
FROM banglore_traffic_dataset
GROUP BY date, hour
ORDER BY total_traffic DESC
LIMIT 10;

#Impact of Weather on Traffic
SELECT `weather conditions`, AVG(`traffic volume`) AS avg_traffic
FROM banglore_traffic_dataset
GROUP BY `weather conditions`
ORDER BY avg_traffic DESC;

#Identify Areas with Highest Incident Reports
SELECT `area name`, COUNT(`incident reports`) AS total_incidents
FROM banglore_traffic_dataset
GROUP BY `area name`
ORDER BY count(`incident reports`) DESC
LIMIT 10;


#Find Areas Where Road Efficiency Is the Worst
SELECT `area name`, AVG(`average speed` / `road capacity utilization`) AS efficiency_score
FROM banglore_traffic_dataset
GROUP BY `area name`
ORDER BY efficiency_score ASC
LIMIT 5;

#Find Most Disrupted Days Due to Weather
SELECT date, `weather conditions`, SUM(`traffic volume`) AS total_traffic,
       (LAG(SUM(`traffic volume`)) OVER (ORDER BY date) - SUM(`traffic volume`)) / 
       LAG(SUM(`traffic volume`)) OVER (ORDER BY date) * 100 AS traffic_drop_percentage
FROM banglore_traffic_dataset
GROUP BY date, `weather conditions`
ORDER BY traffic_drop_percentage DESC
LIMIT 7;

#Identifies high-risk areas with frequent incidents.
SELECT `area name`, COUNT(`incident reports`) AS total_incidents,
       ROUND(SUM(`incident reports`) / SUM(`traffic volume`) * 100, 2) AS incident_density
FROM banglore_traffic_dataset
GROUP BY `area name`
ORDER BY incident_density DESC;







#ALTER TABLE banglore_traffic_dataset
#RENAME COLUMN  'Area Name'
#to Area_Name;
