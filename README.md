# brightlearn_de_exam_seluleko_manqele

:::writing{variant="document" id="73519"}
# BrightLearn Data Warehouse Project

<div align="center">

<h1>🔷 BRIGHTLEARN</h1>

<h2>DATA WAREHOUSE PROJECT</h2>

### Turning Raw Sales Data into Meaningful Business Insights

**DATA ENGINEERING | DATA WAREHOUSING | ETL DEVELOPMENT**

![SQL Server](https://img.shields.io/badge/Microsoft_SQL_Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![SSIS](https://img.shields.io/badge/SSIS-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-00599C?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

**Developed by Seluleko Manqele**

*Junior Data Engineer*

</div>

---

## 1. Project Overview

The BrightLearn Data Warehouse Project focuses on designing and developing a data warehouse using sales and inventory data provided by BrightLearn.

The primary objective is to transform raw operational data into a structured and organised data warehouse that supports business reporting, data analysis, and informed decision-making.

As a Junior Data Engineer, I am applying practical data engineering skills using Microsoft SQL Server, SQL Server Management Studio (SSMS), Visual Studio, and SQL Server Integration Services (SSIS).

The project covers key stages of the data engineering lifecycle, including:

- Data extraction and preparation.
- Data quality assessment.
- Relational database design.
- Dimensional modelling.
- ETL pipeline development.
- Data transformation and validation.
- Analytical SQL querying.

The resulting data warehouse is designed to help BrightLearn gain insights into sales performance, customer purchasing behaviour, product performance, store revenue, and inventory management.

## 2. Project Objectives

The main objectives are to:

1. Import and examine the raw BrightLearn sales dataset.
2. Identify data quality issues, including missing values, duplicates, inconsistent date formats, and invalid records.
3. Design a structured relational database with appropriate relationships.
4. Develop a data warehouse using dimensional modelling.
5. Build ETL workflows using SQL Server Integration Services (SSIS).
6. Extract, transform, and load data into the warehouse.
7. Implement data validation and quality checks.
8. Develop SQL queries to answer business questions.
9. Document the development process and project findings.

## 3. Tools and Technologies

| Tool | Purpose |
|---|---|
| Microsoft SQL Server | Database management and data storage |
| SQL Server Management Studio (SSMS) | Writing and executing SQL queries |
| Visual Studio | SSIS project development |
| SQL Server Integration Services (SSIS) | ETL pipeline development |
| T-SQL | Data transformation, validation, and analysis |
| GitHub | Version control and project documentation |

## 4. Dataset Description

The project uses the provided `BrightLearn_Raw_Data.csv` dataset as its source.

The dataset contains sales and inventory-related information covering January to June 2024.

### Dataset Components

| Category | Description |
|---|---|
| Transactions | Transaction dates, payment methods, transaction amounts, and discounts |
| Customers | Customer names, contact details, locations, and loyalty tiers |
| Stores | Store names, locations, regions, and store managers |
| Products | Product names, SKUs, categories, prices, costs, and suppliers |
| Sales | Quantities sold and line amounts |
| Inventory | Stock on hand and reorder thresholds |

**Dataset Grain:** Each row represents an individual product line item within a sales transaction.

## 5. Data Warehouse Design

The data warehouse follows a dimensional modelling approach, separating descriptive information into dimension tables and measurable business activities into fact tables.

### 5.1 Dimension Tables

| Table | Description |
|---|---|
| DimCustomer | Stores customer information and loyalty details |
| DimProduct | Stores product details, categories, prices, and supplier information |
| DimStore | Stores store information, including locations and management details |
| DimDate | Stores calendar information, including dates, months, quarters, and years |
| DimPayment | Stores payment methods and cashier information |

### 5.2 Fact Tables

| Table | Description |
|---|---|
| FactSales | Stores sales measures, including quantities, line amounts, transaction amounts, and discounts |
| FactInventory | Stores inventory information, including stock on hand and reorder thresholds |

### 5.3 Database Relationships

The fact tables connect to their relevant dimension tables through foreign key relationships.

The planned relationships are:

**FactSales**
- DimCustomer
- DimProduct
- DimStore
- DimDate
- DimPayment

**FactInventory**
- DimProduct
- DimStore
- DimDate

These relationships support efficient querying and business analysis across different dimensions.

## 6. ETL Development Process

The project follows the Extract, Transform, Load (ETL) methodology.

### 6.1 Extract

- Import the raw CSV dataset.
- Examine the source data and column structures.
- Identify relevant business attributes.
- Prepare source data for transformation.

### 6.2 Transform

- Identify missing and NULL values.
- Check for duplicate records.
- Standardise inconsistent data formats.
- Validate date and numerical fields.
- Apply appropriate data transformations.
- Prepare data for dimensional loading.

### 6.3 Load

- Load customer, product, store, date, and payment dimensions.
- Load sales records into FactSales.
- Load inventory records into FactInventory.
- Validate loaded records and relationships.

SSIS is used to develop and manage the ETL workflows.

## 7. Data Quality and Validation

Data quality is essential to building a reliable data warehouse.

The project considers the following validation checks:

- Missing and NULL values.
- Duplicate records.
- Invalid dates.
- Inconsistent text formats.
- Incorrect numerical values.
- Referential integrity.
- Data type compatibility.
- Source-to-target record validation.

## 8. Business Questions

The data warehouse is designed to answer important business questions.

**Sales Analysis**
- What is the total sales revenue?
- Which months generate the highest revenue?
- Which stores generate the most sales?
- What are the overall sales trends?

**Customer Analysis**
- Which customers contribute the most revenue?
- Which loyalty tiers generate the highest sales?
- What are the customer purchasing patterns?

**Product Analysis**
- Which products sell the most?
- Which product categories generate the highest revenue?
- Which products contribute the most to profitability?

**Inventory Analysis**
- Which products are below their reorder thresholds?
- Which stores have low stock levels?
- Which products require restocking?

## 9. Expected Project Deliverables

- SQL Server database.
- Dimension and fact tables.
- Database relationships.
- Data quality and validation scripts.
- SSIS ETL packages.
- Data transformation scripts.
- Analytical SQL queries.
- Project documentation and screenshots.

## 10. Repository Structure

```text
brightlearn_de_exam_seluleko_manqale/
│
├── README.md
│
├── dataset/
│   └── BrightLearn_Raw_Data.csv
│
├── SQL/
│   ├── Database_Creation.sql
│   ├── Table_Creation.sql
│   ├── Data_Quality_Checks.sql
│   ├── Data_Transformation.sql
│   ├── Dimension_Loading.sql
│   ├── Fact_Loading.sql
│   └── Business_Queries.sql
│
├── SSIS/
│   └── SSIS_Project/
│
├── Documentation/
│   ├── Data_Dictionary.md
│   ├── Data_Warehouse_Design.md
│   └── ETL_Documentation.md
│
└── Screenshots/
    ├── Database_Design/
    ├── SSIS_Packages/
    └── Query_Results/
```

## 11. Skills Demonstrated

- SQL Server database development.
- T-SQL programming.
- Relational database design.
- Dimensional modelling.
- Data cleaning and validation.
- ETL pipeline development.
- SSIS package development.
- Data warehousing concepts.
- Analytical SQL querying.
- GitHub documentation and version control.

## 12. Project Status

**Status: In Development**

This repository documents my practical experience in developing a data warehouse using SQL Server and SSIS.

Project documentation and deliverables will be updated as development progresses.

---

<div align="center">

### DEVELOPED BY SELULEKO MANQELE

**Junior Data Engineer**

*Building reliable data pipelines. Transforming data into insights.*

</div>
