# The-Data-Projects

<p align="center">
  <img src="https://i.imgur.com/EZLeQSJ.png" alt="Title" width="380px" height="285px">
</p>
A series of unconnected projects where I explore different aspects of data analysis: divided into four parts; data cleaning and transformation, data analysis and data visualization through MySQL and a Python pipeline for the last one; and a simple data engineering project through AWS.

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

## Spotify Dataset
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
