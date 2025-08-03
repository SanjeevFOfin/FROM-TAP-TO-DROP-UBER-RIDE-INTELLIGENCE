use uber_db;

SELECT * from uber_data_sql;

#1.Trip Status Distribution
SELECT
  'Trip Completed' AS Status,
  COUNT(*) AS Total_Trips
FROM uber_data_sql
WHERE TRIM(LOWER(Status)) = 'trip completed'

UNION ALL

SELECT
  'Cancelled' AS Status,
  COUNT(*) AS Total_Trips
FROM uber_data_sql
WHERE TRIM(LOWER(Status)) = 'cancelled'

UNION ALL

SELECT
  'No Cars Available' AS Status,
  COUNT(*) AS Total_Trips
FROM uber_data_sql
WHERE TRIM(LOWER(Status)) = 'no cars available';

#2. Requests by Pickup Point and Status
SELECT `Pickup point`, Status, COUNT(*) AS Total
FROM uber_data_sql
GROUP BY `Pickup point`, Status
ORDER BY `Pickup point`;

#3.Requests by Request Period and Status
SELECT `Request Period`, Status, COUNT(*) AS Total
FROM uber_data_sql
GROUP BY `Request Period`, Status
ORDER BY `Request Period`;

#4.Cancellation Rate by Pickup Point
SELECT 
  `Pickup point`,
  COUNT(*) AS Total_Requests,
  SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled,
  ROUND(100 * SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Cancellation_Rate_Percent
FROM uber_data_sql
GROUP BY `Pickup point`;

#5.Average Trip Duration by Request Period
SELECT 
  `Request Period`,
  ROUND(AVG(TIME_TO_SEC(`Trip Duration`) / 60), 2) AS Avg_Trip_Duration_Minutes
FROM uber_data_sql
WHERE Status = 'Trip Completed'
GROUP BY `Request Period`
ORDER BY `Request Period`;

#6.Daily Request Breakdown status
SELECT 
  RT_Date,
  COUNT(*) AS Total_Requests,
  SUM(CASE WHEN TRIM(LOWER(Status)) = 'trip completed' THEN 1 ELSE 0 END) AS Completed_Trips,
  SUM(CASE WHEN TRIM(LOWER(Status)) = 'cancelled' THEN 1 ELSE 0 END) AS Cancelled_Trips,
  SUM(CASE WHEN TRIM(LOWER(Status)) = 'no cars available' THEN 1 ELSE 0 END) AS No_Cars_Trips
FROM uber_data_sql
GROUP BY RT_Date
ORDER BY RT_Date;

#7.Peak Request Hour

SELECT HOUR(`RT_Time`) AS Request_Hour, COUNT(*) AS Total_Requests
FROM uber_data_sql
GROUP BY Request_Hour
ORDER BY Total_Requests DESC;




