use coimbatore_city_traffic;


-- Retrieve Signal Details
SELECT signal_id, location_id, status
FROM congestion;


-- Count of Signals Grouped by Status
SELECT status, COUNT(*) AS signal_count
FROM congestion
GROUP BY status;


-- Top 5 Locations with Highest Number of Accidents
SELECT l.location_name, COUNT(a.incident_id) AS total_accidents
FROM accident a
JOIN location l ON a.location_id = l.location_id
GROUP BY l.location_name
ORDER BY total_accidents DESC
LIMIT 5;

-- Location-Wise Deaths Due to Accidents
SELECT l.location_name, SUM(a.deaths_occurred) AS total_deaths
FROM accident a
JOIN location l ON a.location_id = l.location_id
GROUP BY l.location_name
ORDER BY total_deaths DESC;

-- Average Congestion Level by Zone
SELECT l.zone, AVG(
  CASE 
    WHEN c.congestion_level = 'High' THEN 3
    WHEN c.congestion_level = 'Medium' THEN 2
    WHEN c.congestion_level = 'Low' THEN 1
  END
) AS avg_congestion_score
FROM congestion c
JOIN location l ON c.location_id = l.location_id
GROUP BY l.zone
ORDER BY avg_congestion_score DESC;


-- Accidents Distribution by Time of Day
SELECT 
  CASE 
    WHEN HOUR(a.date_time) BETWEEN 6 AND 12 THEN 'Morning'
    WHEN HOUR(a.date_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN HOUR(a.date_time) BETWEEN 17 AND 21 THEN 'Evening'
    ELSE 'Night'
  END AS time_of_day,
  COUNT(a.incident_id) AS accident_count
FROM accident a
GROUP BY time_of_day
ORDER BY accident_count DESC;


-- Average Vehicle Speed per Zone
SELECT l.zone, AVG(t.average_speed) AS avg_speed
FROM traffic t
JOIN location l ON t.location_id = l.location_id
GROUP BY l.zone
ORDER BY avg_speed DESC;

-- Weather Condition Impact on Traffic Volume
SELECT t.weather_condition, AVG(t.traffic_volume) AS avg_traffic_volume
FROM traffic t
GROUP BY t.weather_condition
ORDER BY avg_traffic_volume DESC;

-- Vehicle Type Distribution in Traffic
SELECT 
  SUM(t.count_of_cars) AS total_cars,
  SUM(t.count_of_bikes) AS total_bikes,
  SUM(t.count_of_buses) AS total_buses
FROM traffic t;


-- Impact of Temperature on Average Speed
SELECT 
  CASE
    WHEN temperature_celsius < 20 THEN 'Cold'
    WHEN temperature_celsius BETWEEN 20 AND 30 THEN 'Moderate'
    ELSE 'Hot'
  END AS temp_category,
  AVG(average_speed_kmph) AS avg_speed
FROM traffic
GROUP BY temp_category
ORDER BY avg_speed DESC;
