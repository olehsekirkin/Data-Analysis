-- Database normalization is a process used in relational database design to organize tables and their relationships in a way that reduces redundancy and dependency. 
-- The goal of normalization is to isolate data so that additions, deletions, and modifications can be made in just one table and then propagated through the rest of 
-- the database via the defined relationships.

-- First we create tables

-- Plants table
CREATE TABLE plants (
    PLANT_ID VARCHAR(255) NOT NULL,
    Location VARCHAR(255),
    Capacity DECIMAL(10, 2),
    PRIMARY KEY (PLANT_ID)
);

-- Source table
CREATE TABLE sources (
    SOURCE_KEY VARCHAR(255) NOT NULL,
    PLANT_ID VARCHAR(255) NOT NULL,
    Source_Type VARCHAR(255),
    FOREIGN KEY (PLANT_ID) REFERENCES Plants(PLANT_ID),
    PRIMARY KEY (SOURCE_KEY)
);

CREATE TABLE generation_data (
    GENERATION_ID INT AUTO_INCREMENT NOT NULL,
    SOURCE_KEY VARCHAR(255) NOT NULL,
    DATE_TIME DATETIME,
    DC_POWER DECIMAL(10, 2),
    AC_POWER DECIMAL(10, 2),
    DAILY_YIELD DECIMAL(10, 2),
    TOTAL_YIELD BIGINT,
    PRIMARY KEY (GENERATION_ID),
    FOREIGN KEY (SOURCE_KEY) REFERENCES Sources(SOURCE_KEY)
);

CREATE TABLE weather_sensor_data (
    WEATHER_ID INT AUTO_INCREMENT NOT NULL,
    SOURCE_KEY VARCHAR(255) NOT NULL,
    DATE_TIME DATETIME,
    AMBIENT_TEMPERATURE DECIMAL(5, 2),
    MODULE_TEMPERATURE DECIMAL(5, 2),
    IRRADIATION DECIMAL(5, 3),
    PRIMARY KEY (WEATHER_ID),
    FOREIGN KEY (SOURCE_KEY) REFERENCES Sources(SOURCE_KEY)
);

-- We do this for every plant

INSERT INTO plants (PLANT_ID, Location, Capacity) VALUES ('P1', 'Location 1', 100.00);

-- And we do this for every source

INSERT INTO sources (SOURCE_KEY, PLANT_ID, Source_Type) VALUES ('SK1', 'P1', 'Generation Unit');

-- Then we can query the data! For example if we look to get generation data for a specific plant, on a specific day, it would look like:

SELECT g.DATE_TIME, g.DC_POWER, g.AC_POWER, g.DAILY_YIELD, g.TOTAL_YIELD
FROM generation_data g
JOIN sources s ON g.SOURCE_KEY = s.SOURCE_KEY
WHERE s.PLANT_ID = 'P1' AND DATE(g.DATE_TIME) = '2023-01-01';



