# Azure_Databricks_Synapse_project
## Overview
This project demonstrates how to build a comprehensive data engineering pipeline on Microsoft Azure using the AdventureWorks dataset. Adventure Works is a fictional company that sells bicycles and related products. The dataset includes information such as customer details, product inventories, sales orders, and returns.
The goal is to ingest raw data, transform it into usable formats, store it efficiently, and make it ready for analysis and visualisation. We use a "medallion architecture" – think of it as a layered approach to data processing:

Bronze layer: Raw data as it arrives (like unrefined ore).
Silver layer: Cleaned and organised data (polished but not final).
Gold layer: Fully refined, query-ready data for business insights (shiny and valuable).

Why this architecture? It keeps things organised, makes data reusable, and ensures quality at each step, preventing errors from propagating. This setup is scalable for big data and common in real-world data engineering to support analytics without overwhelming systems.


The project uses Azure services like Data Factory for orchestration, Data Lake Storage Gen2 for storage, Databricks for transformations, Synapse Analytics for warehousing, and Power BI for visualisation. It's designed for learning, interviews, or real applications.
Dataset Source: Data is fetched from a GitHub repository via HTTP (similar to pulling from an API), making it easy to simulate real-time data ingestion.

## Table of Contents

Data Understanding and Source

Creating Azure Resources

Azure Data Lake Storage Gen2

Data Ingestion - Bronze Layer

Azure Data Factory and ETL Pipelines

Data Transformation - Silver Layer

Data Warehousing - Gold Layer

Visualization and Consumption

Authentication and Security

Key Concepts and Why We Do This
Resources

### Data Understanding and Source
First, understand the data: The Adventure Works dataset comes from Kaggle/GitHub and includes CSV files for calendars, customers, products, sales, and returns. It's like business records – sales show what was sold when, returns track issues, etc.
Why start here? Knowing your data (structure, quality, sources) prevents surprises later. For example, sales data might have dates in string format, needing conversion.
We fetch it via HTTP from GitHub, treating it like an API call. This mimics real scenarios where data comes from web services, not local files.
Creating Azure Resources
Set up the foundation in Azure Portal:

### Create a Resource Group: A container for all project resources, like a folder for organization.
Deploy Azure Data Lake Storage Gen2 (ADLS Gen2): For storing data.
Create Azure Data Factory (ADF): For building pipelines.
Set up Azure Databricks: For processing.
Provision Azure Synapse Analytics: For querying.
Optionally, prepare Power BI for visuals.

Why? Azure resources are pay-as-you-go and scalable. Grouping them simplifies management and billing. Enable features like hierarchical namespaces in ADLS for folder-like organization.

### Azure Data Lake Storage Gen2
ADLS Gen2 is a big, cheap storage for all data types. We create containers (like buckets): bronze for raw, silver for processed, gold for final.
Why Gen2? It combines blob storage (cheap) with file system features (folders, security). Hierarchical structure helps organize data lakes, avoiding a "data swamp" where files are messy.


#### Data Ingestion - Bronze Layer
Ingestion means pulling data in. Using ADF, we copy raw files from GitHub into the bronze container via HTTP linked service and Copy activity.
Why bronze first? Store data "as-is" to preserve originals for auditing or reprocessing. No changes yet – just load CSVs/Parquets quickly.

Steps:
Use a JSON config file listing files.
Lookup activity reads it.
ForEach loop processes each file dynamically.
This makes ingestion flexible for varying data sources.


### Azure Data Factory and ETL Pipelines
ADF is the "conductor" – it orchestrates Extract-Transform-Load (ETL) pipelines. ETL: Extract data, Transform it, Load to destination.
We build dynamic pipelines: Lookup JSON → ForEach → Copy to bronze.
Why ADF? Automates workflows, schedules runs, handles failures. Dynamic design scales – add files without rewriting code.


### Data Transformation - Silver Layer
In Azure Databricks (using PySpark on Apache Spark), clean and enrich data from bronze to silver.
Examples:
Combine names into full_name.
Calculate totals like line_total = quantity * price.
Convert dates, filter junk.
Write as Parquet (efficient format) to silver container.
The reason for the Transformation is that raw data is messy; cleaning ensures accuracy. Spark handles big data fast. Silver is reusable for multiple analyses.


### Data Warehousing - Gold Layer
Using Azure Synapse Analytics (serverless SQL pool), create external tables/views on silver data, stored in gold.
Use CTAS (Create Table As Select) to curate: Join tables, aggregate (e.g., sales by month).
Why gold? Final layer is optimised for queries – fast, structured like a database but on cheap lake storage. Lakehouse pattern: Best of lakes (cost) and warehouses (SQL ease).

### Visualization and Consumption
Connect Power BI to Synapse: Query gold data, build dashboards (e.g., sales trends, customer counts).
Data's value is in insights – visuals make it accessible to non-tech users, like business teams spotting trends.


### Authentication and Security
Use Service Principals (app registrations) for secure access between services. Assign roles like Storage Blob Data Contributor.
Why? Avoid hardcoding keys; secure, auditable. Managed Identities for internal Azure comms.

### Key Concepts and Why We Do This
Medallion Architecture: Layers build quality incrementally.
Dynamic Pipelines: Flexible for changing data.
Lakehouse: Cost-effective querying.
Overall: Turns raw data into actionable insights efficiently, scalably.

### Resources
Video: YouTube Tutorial
Dataset: Kaggle Adventure Works
GitHub: AzureProject Repo
