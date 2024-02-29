-- Ensuring that all DATE_TIME columns in all tables are stored as DATETIME, if they were stored otherwise they are converted already

ALTER TABLE plant_1_generation_data MODIFY DATE_TIME DATETIME;
ALTER TABLE plant_1_weather_sensor_data MODIFY DATE_TIME DATETIME;
ALTER TABLE plant_2_generation_data MODIFY DATE_TIME DATETIME;
ALTER TABLE plant_2_weather_sensor_data MODIFY DATE_TIME DATETIME;

-- This can be applied to AC_POWER, DAILY_YIELD, etc, in order to ensure that they are stored as numeric data types (FLOAT in this case)

ALTER TABLE plant_1_generation_data MODIFY DC_POWER FLOAT;
ALTER TABLE plant_1_generation_data MODIFY AC_POWER FLOAT;
ALTER TABLE plant_2_generation_data MODIFY DC_POWER FLOAT;
ALTER TABLE plant_2_generation_data MODIFY AC_POWER FLOAT;

-- Validate that numeric columns do not contain outliers or non valid values like negative values. There is not such thing among any of these tables

SELECT * FROM plant_1_generation_data WHERE DC_POWER < 0;
SELECT * FROM plant_1_generation_data WHERE AC_POWER < 0;
SELECT * FROM plant_2_generation_data WHERE DC_POWER < 0;
SELECT * FROM plant_2_generation_data WHERE AC_POWER < 0;

-- Check for consistency and typos on the PLANT_ID and SOURCE_KEY values

SELECT DISTINCT PLANT_ID FROM plant_1_generation_data;
SELECT DISTINCT PLANT_ID FROM plant_2_generation_data;
SELECT DISTINCT PLANT_ID FROM plant_1_weather_sensor_data;
SELECT DISTINCT PLANT_ID FROM plant_2_weather_sensor_data;
SELECT DISTINCT SOURCE_KEY FROM plant_1_generation_data;
SELECT DISTINCT SOURCE_KEY FROM plant_2_generation_data;
SELECT DISTINCT SOURCE_KEY FROM plant_1_weather_sensor_data;
SELECT DISTINCT SOURCE_KEY FROM plant_2_weather_sensor_data;

-- Identify any missing or NULL values in any of the columns

SELECT * FROM plant_1_generation_data WHERE DC_POWER IS NULL

-- This process should be done with every column at every table to check for, like I said, missing or NULL values. In case of finding any there are different
-- options on how to handle them: if integrity of the dataset is important, I would consider averages or interpolation (1), or if the data points with empty cells
-- are not that crucial, I would just delete them (2), for each case:

-- (1) Using overall average:

UPDATE plant_1_generation_data
SET DC_POWER = (SELECT AVG(DC_POWER) FROM plant_1_generation_data WHERE DC_POWER IS NOT NULL)
WHERE DC_POWER IS NULL;

-- (2) Delete:

DELETE FROM plant_1_generation_data WHERE DC_POWER IS NULL;

-- Outliers can lead your conclusions into being inaccurate, so we need a way of identifying them and fixing the data
-- Here we use the Standard Deviation to identify outliers in DC_POWER

SELECT g.DC_POWER, stats.mean_power, stats.stddev_power
FROM Plant_1_Generation_Data g
JOIN (
    SELECT AVG(DC_POWER) AS mean_power, STD(DC_POWER) AS stddev_power
    FROM Plant_1_Generation_Data
) stats
WHERE g.DC_POWER < (stats.mean_power - 2 * stats.stddev_power) OR 
      g.DC_POWER > (stats.mean_power + 2 * stats.stddev_power);
