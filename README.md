# The-Data-Projects

<p align="center">
  <img src="https://pipedream.com/s.v0/app_1YMhwo/logo/orig" alt="Title" width="125px" height="125px">
</p>

A series of unconnected projects where I explore different aspects of data analysis, divided into four parts; data cleaning and transformation, data analysis, data visualization, and data engineering/science. These projects are heavily focused on the use of SQL, with occasional additional support from Python and Excel

## Data Cleaning & Transformation

For this first part of this set of projects I used a dataset I foud on Kaggle, named 'Solar Power Generation Data' by Ani Kannal. This information was collected from two solar power facilities in India over a period of 34 days and consists of two sets of files. Each set includes a dataset for power production and another for sensor readings. The power production data is recorded at the inverter level, where each inverter is connected to several strings of solar panels. On the other hand, the sensor data is compiled at the plant level, using a strategically positioned array of sensors across the facility

Through this process I tried to apply as many techniques as I could remember in order to do the proper cleaning and transformation of data where necessary (applied the queries even if not necessary in this case)

First things first the dataset was divided into 4 .csv files, which had to be prepared to be uploaded into SQL. Being MySQL import wizard that slow, I had to use LOAD DATA LOCAL INFILE in order to load my data fast, so first I had to modify the dates on the .csv files with a short Python (datapreparation.py) code and pandas.

Once the files were ready, I uploaded them (project1query1.sql) and started: type casting and validation techniques were applied at 'project1query2', then normalization of the data at 'project1query3', data aggregation and summary statistics were applied at 'project1query4' and finally categorization and segmentation of the data was applied at 'project1query5'.

## Data Analysis

To continue with this series of projets and went now with the data analysis side of it. This time I used an Amazon products dataset from 2023 that has information from over 1.4 million products, you can find it on Kaggle and thank the user Asaniczka for it.

The amazon_products.csv and amazon_categories.csv are linked through a foreign key relationship where the 'category_id' column in the 'amazon_products' references the 'id' column in the 'amazon_categories', allowing us to connect each product to its corresponding category.

As you can check on 'project2query1' I went from asking and resolving simple questions like what where the top 5 categories with the highest number of products, to more complicated ones where I aimed, for example, to calculate the weighted average rating of products in each category, based on the number of reviews. I tried to go through different optics in order to analyze the information that this dataset provides to us. I am sure there are a lot more questions that can be asked and resolved with this dataset, so if you find any interesting I am open to try :D!

## Data visualization
