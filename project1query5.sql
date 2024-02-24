-- Now I am going to categorize or segment my data into new groups, here I will use a lot of CASE() and try to generate useful information for further analysis

-- Categorizing Power Output into Efficiency Bands

SELECT DATE_TIME,
       AC_POWER,
       CASE
           WHEN AC_POWER < 250 THEN 'Low Efficiency'
           WHEN AC_POWER BETWEEN 250 AND 500 THEN 'Moderate Efficiency'
           WHEN AC_POWER > 500 THEN 'High Efficiency'
           ELSE 'Unknown' END AS Efficiency_Band
FROM plant_1_generation_data;

-- Segmenting Weather Data based on Temperature Ranges

SELECT DATE_TIME,
       AMBIENT_TEMPERATURE,
       CASE
           WHEN AMBIENT_TEMPERATURE < 20 THEN 'Cool'
           WHEN AMBIENT_TEMPERATURE BETWEEN 20 AND 30 THEN 'Moderate'
           WHEN AMBIENT_TEMPERATURE > 30 THEN 'Hot'
           ELSE 'Unknown' END AS Temperature_Range
FROM plant_1_weather_sensor_data;

-- Analyzing Generation Data with Weather Conditions

SELECT g.DATE_TIME,
       g.AC_POWER,
       w.IRRADIATION,
       CASE
           WHEN w.IRRADIATION < 0.2 THEN 'Low Irradiation'
           WHEN w.IRRADIATION BETWEEN 0.2 AND 0.5 THEN 'Moderate Irradiation'
           WHEN w.IRRADIATION > 0.5 THEN 'High Irradiation'
           ELSE 'Unknown' END AS Irradiation_Level,
       CASE
           WHEN g.AC_POWER < 250 THEN 'Low Efficiency'
           WHEN g.AC_POWER BETWEEN 250 AND 500 THEN 'Moderate Efficiency'
           WHEN g.AC_POWER > 500 THEN 'High Efficiency'
           ELSE 'Unknown' END AS Efficiency_Band
FROM plant_1_generation_data g
JOIN plant_1_weather_sensor_data w ON g.DATE_TIME = w.DATE_TIME;




