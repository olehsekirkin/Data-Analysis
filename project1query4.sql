-- Now we can proceed with data aggregation and summary statistics. If it's in our interest we could create new columns for this information, but I am just
-- going to check for it in this case:

-- For this exercise I will execute queries ignoring the previous normalization process, and getting the data straight from the original tables.

-- Plant 1, Total Daily Yield for Each Day

SELECT DATE(DATE_TIME) AS Day, SUM(DAILY_YIELD) AS Total_Daily_Yield
FROM plant_1_generation_data
GROUP BY DATE(DATE_TIME);

-- Plant 1, Average, Min, and Max AC Power Output

SELECT DATE(DATE_TIME) AS Day, AVG(AC_POWER) AS Average_AC_Power, MIN(AC_POWER) AS Min_AC_Power, MAX(AC_POWER) AS Max_AC_Power
FROM plant_1_generation_data
GROUP BY DATE(DATE_TIME);

-- Plant 1, Average Daily Ambient and Module Temperature

SELECT DATE(DATE_TIME) AS Day, AVG(AMBIENT_TEMPERATURE) AS Average_Ambient_Temperature, AVG(MODULE_TEMPERATURE) AS Average_Module_Temperature
FROM plant_1_weather_sensor_data
GROUP BY DATE(DATE_TIME);

-- Plant 1, Maximum Daily Irradiation

SELECT DATE(DATE_TIME) AS Day, MAX(IRRADIATION) AS Max_Irradiation
FROM plant_1_weather_sensor_data
GROUP BY DATE(DATE_TIME);

-- Data is shown with ALL the decimals in the calculations, in case we want to round it we should execute the queries with ROUND():

-- For example, if we want to ROUND the Average, Min, Max AC Power Output:

SELECT DATE(DATE_TIME) AS Day, 
       ROUND(AVG(AC_POWER), 2) AS Average_AC_Power, 
       ROUND(MIN(AC_POWER), 2) AS Min_AC_Power, 
       ROUND(MAX(AC_POWER), 2) AS Max_AC_Power
FROM plant_1_generation_data
GROUP BY DATE(DATE_TIME);






