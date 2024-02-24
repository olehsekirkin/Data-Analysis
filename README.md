# The-Data-Projects

<p align="center">
  <img src="https://pipedream.com/s.v0/app_1YMhwo/logo/orig" alt="Title" width="125px" height="125px">
</p>

A series of unconnected projects where I explore different aspects of data analysis, divided into four parts; data cleaning and transformation, data analysis, data visualization, and data engineering/science. These projects are heavily focused on the use of SQL, with occasional additional support from Python and Excel

## Data Cleaning & Transformation

For this first part of this set of projects I used a dataset I foudn on Kaggle, named 'Solar Power Generation Data' by Ani Kannal. This information was collected from two solar power facilities in India over a period of 34 days and consists of two sets of files. Each set includes a dataset for power production and another for sensor readings. The power production data is recorded at the inverter level, where each inverter is connected to several strings of solar panels. On the other hand, the sensor data is compiled at the plant level, using a strategically positioned array of sensors across the facility

Through this process I tried to apply as many techniques as I could remember in order to do the proper cleaning and transformation of data where necessary (applied the queries even if not necessary in this case)

First things first the dataset was divided into 4 .csv files, which had to be prepared to be uploaded into SQL. Being MySQL import wizard that slow, I had to use LOAD DATA LOCAL INFILE in order to load my data fast, so first I had to modify the dates on the .csv files with a short Python code and pandas.

Once the files were ready, I uploaded them (project1query1.sql) and started: type casting and validation techniques were applied at 'project1query2', then normalization of the data at 'project1query3', data aggregation and summary statistics were applied at 'project1query4' and finally categorization and segmentation of the data was applied at 'project1query5'.

## Data Analysis
