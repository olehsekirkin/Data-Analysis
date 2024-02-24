USE solar_power;

-- Create table for Plant_1_Generation_Data

CREATE TABLE plant_1_generation_data (
    DATE_TIME DATETIME,
    PLANT_ID BIGINT,
    SOURCE_KEY VARCHAR(255),
    DC_POWER FLOAT,
    AC_POWER FLOAT,
    DAILY_YIELD FLOAT,
    TOTAL_YIELD FLOAT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\olehs\\Desktop\\data\\Plant_1_Generation_Data.csv'
INTO TABLE plant_1_generation_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Create table for Plant_1_Weather_Sensor_Data

CREATE TABLE plant_1_weather_sensor_data (
    DATE_TIME DATETIME,
    PLANT_ID BIGINT,
    SOURCE_KEY VARCHAR(255),
    AMBIENT_TEMPERATURE FLOAT,
    MODULE_TEMPERATURE FLOAT,
    IRRADIATION FLOAT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\olehs\\Desktop\\data\\Plant_1_Weather_Sensor_Data.csv'
INTO TABLE plant_1_weather_sensor_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Create table for Plant_2_Generation_Data

CREATE TABLE plant_2_generation_data (
    DATE_TIME DATETIME,
    PLANT_ID BIGINT,
    SOURCE_KEY VARCHAR(255),
    DC_POWER FLOAT,
    AC_POWER FLOAT,
    DAILY_YIELD FLOAT,
    TOTAL_YIELD FLOAT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\olehs\\Desktop\\data\\Plant_2_Generation_Data.csv'
INTO TABLE plant_2_generation_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Create table for Plant_2_Weather_Sensor_Data

CREATE TABLE plant_2_weather_Sensor_data (
    DATE_TIME DATETIME,
    PLANT_ID BIGINT,
    SOURCE_KEY VARCHAR(255),
    AMBIENT_TEMPERATURE FLOAT,
    MODULE_TEMPERATURE FLOAT,
    IRRADIATION FLOAT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\olehs\\Desktop\\data\\Plant_2_Weather_Sensor_Data.csv'
INTO TABLE plant_2_weather_Sensor_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM plant_2_weather_Sensor_data
