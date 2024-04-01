# Data Analysis

A series of unconnected projects where I explore different aspects of data analysis: divided into four parts; data cleaning and transformation, data analysis, data visualization through MySQL and a Python pipeline; and data engineering projects through AWS

<p align="center">
  <img src="https://images.prismic.io/mparticle/3cba8133-835b-4897-a05d-295295ef1acf_sql-pyth.png?auto=compress%2Cformat&rect=0%2C0%2C2520%2C1414&w=1230&h=690&fit=max" alt="Title" width="540px" height="320px">
</p>

## Solar Power Generation Data

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/labs/8/8e/Mysql_logo.png" alt="Title" width="100px" height="80px">
</p>

### Dataset
The journey begins with the "Solar Power Generation Data" dataset by Ani Kannal. This dataset chronicles the performance of two solar power plants in India over 34 days, segmented into four CSV files. These files detail power production at the inverter level and environmental sensor readings across the plant.

### Data Preparation and Cleaning
- Data Preparation: Employing datapreparation.py (Python with pandas), dates were formatted for SQL compatibility, followed by efficient data importation into MySQL using LOAD DATA LOCAL INFILE.

- Analysis Steps: Involved type casting, validation (project1query2), normalization (project1query3), aggregation and summarization (project1query4), and finally categorization and segmentation (project1query5).

## Amazon Products Data

### Dataset
The second project examines an extensive Amazon products dataset from 2023, featuring over 1.4 million products. Thanks to Asaniczka on Kaggle, this dataset connects products to categories through a relational database schema, opening avenues for deep category analysis.

### Analysis
- Initial Queries: Began with identifying top categories by product volume (project2query1).
  
- Advanced Analysis: Advanced to calculating weighted average product ratings, exploring various analytical angles. Open for collaboration on new and intriguing queries!

## Supply Chain Data
<p align="center">
  <img src="https://i.imgur.com/9eZCsm7.png" alt="Title" width="200px" height="120px">
</p>

### Dataset
For visualization, I selected the 'Supply Chain Analysis' dataset from Harsh Singh on Kaggle, focusing on creating graphical representations of the data.

### Visualization Techniques
- Pipeline Creation: A MySQL to Python pipeline facilitated visualizations, overcoming SQL's visualization limitations.
  
- Graphical Insights: Utilized matplotlib to craft four pivotal visual representations, offering valuable insights into the dataset.

## Spotify Dataset (AWS)
<p align="center">
  <img src="https://k21academy.com/wp-content/uploads/2021/09/AWS-2.png" alt="Title" width="200px" height="105px">
</p>

### Introduction
Embarking on data engineering, this segment introduces the use of Amazon Web Services (AWS), a premier cloud platform known for its extensive tools and capabilities. The project is centered around the Spotify Dataset 2023, curated by Tony Gordon Jr., streamlined from five to three CSV files for this exploration. This marks my initial journey into data engineering, where I crafted a simple yet effective pipeline to navigate through AWS's ecosystem, ensuring a balance between learning and practical application.

### Pipeline Architecture
The pipeline designed for this project demonstrates a straightforward and logical flow, utilizing a suite of AWS services to manage and analyze the dataset efficiently:

- S3 Staging: The journey begins with uploading the refined Spotify dataset to an Amazon S3 bucket, establishing a secure and scalable starting point for data storage.
  
- Glue ETL: Leveraging AWS Glue, the project advances with extract, transform, and load (ETL) operations. This critical phase involves data joining, modification, transformation, and deduplication, facilitated by scripts available in the dataengproject folder.
  
- S3 Data Warehouse: Post-ETL, the processed data migrates to a separate S3 bucket, envisioned as a data warehouse. This step optimizes data storage for analysis and querying.
  
- Glue Crawler: The Glue Crawler is then employed to categorize and catalog the data within the warehouse, streamlining the preparation for analytical exploration.

- Athena for Analysis: AWS Athena comes into play for executing SQL queries directly on the data stored in S3, offering a powerful and flexible analysis tool.
  
- Quicksight for Visualization: Finally, AWS Quicksight transforms analytical outcomes into interactive charts and graphs, enabling intuitive data visualization and insight discovery.

<p align="center">
  <img src="https://i.imgur.com/J3001R3.png" alt="Title" width="300px" height="68px">
</p>

This project serves as a foundational exploration into data engineering with AWS, demonstrating the potential of cloud services in managing, analyzing, and visualizing large datasets. By constructing a coherent pipeline from data staging to visualization, I've taken initial steps into the vast domain of AWS, setting the stage for more complex and nuanced data engineering projects in the future.

## Weather API (AWS + Snowflake)

<p align="center">
  <img src="https://i.imgur.com/9fe9f4z.png" alt="Title" width="350px" height="475px">
</p>

Going deep into more Data Engineering processes. In the 'lambda_function' and 'dynamotowarehouse' are stored the Lambda codes used, 'snowflake.sql' contains the SQL-type code that was implemented in order to connect and store the data in Snowflake.

### Pipeline Architecture

- Data Collection: The process begins with AWS Lambda, which is scheduled to run hourly. This Lambda function is responsible for fetching weather data from an external weather API.

- Data Storage and Initial Processing: The fetched data is then stored in Amazon DynamoDB. DynamoDB serves as the initial repository for the collected data, chosen for its scalability and capability to handle large volumes of data efficiently. DynamoDB Streams is utilized to capture changes to data in the database, effectively providing a real-time data streaming capability.

- Data Streaming to AWS Lambda: Another AWS Lambda function is triggered by the changes recorded in DynamoDB Streams. This function processes the data—potentially aggregating, filtering, or transforming it—before preparing it for storage in AWS S3.

- Data Storage in AWS S3: The processed data is stored in an AWS S3 bucket. S3 acts as an intermediate storage solution, providing a durable and scalable storage environment for the data before it is loaded into Snowflake.

- Data Loading into Snowflake: Finally, Snowflake is configured to load data from the AWS S3 bucket into its database. This is facilitated through Snowflake's ability to directly ingest data from S3, using either Snowflake's internal stages or external stages for managing the data transfer process.

### Connection with Snowflake:

- Snowflake's integration with AWS allows for seamless data transfer from S3 to Snowflake. This process can be automated through Snowflake's COPY command, which loads data into Snowflake tables from the S3 bucket. The data loaded into Snowflake can then be used for various analytical purposes, leveraging Snowflake's powerful data warehousing and SQL querying capabilities.

- Snowflake's architecture supports structured and semi-structured data (e.g., JSON, Avro, XML), making it versatile for different types of data analysis. This is particularly beneficial for analyzing weather data, which may include structured data (like temperature readings) and semi-structured data (like weather conditions).

This pipeline architecture effectively demonstrates how to leverage AWS services for data collection and processing, while utilizing Snowflake for data storage and analysis. The seamless integration between AWS and Snowflake enables efficient data flow from collection to analysis, providing a robust solution for real-time data engineering projects.

## Traffic Volume Data

<p align="center">
  <img src="https://i.imgur.com/Qqo9RlC.png" alt="Title" width="395px" height="475px">
</p>

This project analyzes the Metro Interstate Traffic Volume dataset from the UC Irvine Machine Learning Repository. The project is split into two main parts: data preprocessing and visualization, and predictive modeling using regression techniques.

### Key Highlights:

- Data preparation: Applied data cleaning and feature engineering to enhance the dataset for analysis.

- Visualization: Created visual representations to understand traffic trends and patterns.

- Predictive modeling: Compared various regression models to predict traffic volume, identifying the most accurate model through performance metrics.



