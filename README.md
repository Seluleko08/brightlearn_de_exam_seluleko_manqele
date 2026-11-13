# brightlearn_de_exam_seluleko_manqele

# BrightLearn Data Warehouse Project

**Role:** Junior Data Engineer  
**Project Type:** Data Engineering / Data Warehousing  
**Database:** Microsoft SQL Server  
**ETL Tool:** SQL Server Integration Services (SSIS)

---

## 1. Project Overview

The BrightLearn Data Warehouse Project focuses on designing and developing a data warehouse using sales data provided by BrightLearn.

The purpose of this project is to transform raw sales data into a structured and organised data warehouse that supports business reporting and analysis.

As a Junior Data Engineer, I am using SQL Server, SQL Server Management Studio (SSMS), and SQL Server Integration Services (SSIS) to work through the data engineering process, including data preparation, database design, data quality checks, ETL development, and analytical querying.

The completed data warehouse will help BrightLearn understand its sales performance, customer purchasing behaviour, product performance, store revenue, and inventory levels.

## 2. Project Objectives

The main objectives of this project are to:

- Import and examine the raw BrightLearn sales dataset.
- Identify data quality issues such as missing values, duplicates, inconsistent date formats, and invalid records.
- Design a structured relational database using appropriate tables and relationships.
- Develop a data warehouse using a dimensional modelling approach.
- Build an ETL process using SQL Server Integration Services (SSIS).
- Extract, transform, and load data into the data warehouse.
- Use SQL queries to answer important business questions.
- Document the development process and findings.

## 3. Tools and Technologies

The following tools and technologies are used in this project:

| Tool | Purpose |
|---|---|
| Microsoft SQL Server | Database management and data storage |
| SQL Server Management Studio (SSMS) | Writing and executing SQL queries |
| Visual Studio | Developing the SSIS project |
| SQL Server Integration Services (SSIS) | Building ETL workflows |
| GitHub | Version control and project documentation |
| T-SQL | Data transformation, validation, and analysis |

## 4. Dataset Description

The project uses the provided `BrightLearn_Raw_Data.csv` dataset as its source.

The dataset contains sales and inventory-related information covering the period January to June 2024.

The dataset includes information relating to:

- **Transactions:** Transaction dates, payment methods, transaction amounts, and discounts.
- **Customers:** Customer names, contact details, locations, and loyalty tiers.
- **Stores:** Store names, locations, regions, and store managers.
- **Products:** Product names, SKUs, categories, prices, costs, and suppliers.
- **Sales:** Quantities sold and line amounts.
- **Inventory:** Stock on hand and reorder thresholds.

Each row represents a product line item within a transaction.

## 5. Data Warehouse Design

The data warehouse is designed using a dimensional modelling approach, separating descriptive information into dimension tables and measurable business information into fact tables.

### Dimension Tables

The following dimension tables are included:

| Table | Description |
|---|---|
| DimCustomer | Stores customer information and loyalty details. |
| DimProduct | Stores product details, categories, prices, and supplier information. |
| DimStore | Stores store information, including location and management details. |
| DimDate | Stores calendar information such as dates, months, quarters, and years. |
| DimPayment | Stores payment methods and cashier information. |

### Fact Tables

| Table | Description |
|---|---|
| FactSales | Stores sales-related measures, including quantity, line amount, transaction amount, and discounts. |
| FactInventory | Stores inventory information, including stock on hand and reorder thresholds. |

### Database Relationships

The fact tables connect to the relevant dimension tables through their
