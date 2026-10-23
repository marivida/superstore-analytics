# Superstore Analytics — End-to-End BI Project

**Project Status:** In Progress

## 1. Overview

Superstore Analytics is an end-to-end Business Intelligence project designed to demonstrate data preparation, data quality validation, dimensional modeling, SQL development, and data visualization.

The project uses the Superstore dataset to build a structured analytical database in SQL Server, which will serve as the data source for a Power BI report.

## 2. Objectives

The main objectives of this project are to:

- Build a structured analytical database using SQL Server.
- Implement a staging and data preparation process.
- Identify and handle data quality issues.
- Design a dimensional data model using a star schema.
- Develop SQL scripts for data transformation and loading.
- Validate data accuracy and consistency.
- Build an interactive Power BI dashboard.
- Communicate business insights through data visualization.

## 3. Dataset

**Source:** [Superstore Dataset — Kaggle](https://www.kaggle.com/code/khanzaibmarri/superstore-dataset-full-eda/input)

The dataset contains sales transaction records, including order dates, shipping information, customer details, product categories, geographical information, sales, quantities, discounts, and profits.

### Dataset Summary

| Metric | Value |
|---|---:|
| Transaction records | 9,994 |
| Distinct orders | 5,009 |
| Distinct customers | 793 |
| Distinct product ID and name combinations | 1,894 |
| Geographic records | 632 |
| Date dimension records | 1,464 |

## 4. Technologies

- **SQL Server Express** — Database engine
- **SQL Server Management Studio (SSMS)** — Database development and management
- **T-SQL** — Data transformation, validation, and loading
- **Power BI Desktop** — Planned data modeling and visualization

## 5. Database Architecture

The database follows a dimensional modeling approach, separating source data, dimensions, and transactional facts.

### Staging Layer

The staging layer stores the imported source data and its cleaned version.

- `stg.SuperstoreRaw` — Initial import table.
- `stg.SuperstoreRaw_Text` — Source data reimported as text to preserve the original values during type conversion.
- `stg.Superstore_Clean` — Cleaned and typed dataset used for subsequent transformations.

### Dimension Tables

| Table | Description | Records |
|---|---|---:|
| `dim.DimCustomer` | Customer attributes | 793 |
| `dim.DimProduct` | Product attributes | 1,894 |
| `dim.DimGeography` | Geographic attributes | 632 |
| `dim.DimDate` | Calendar attributes | 1,464 |

### Fact Table

`fact.FactSales` stores sales transactions and their associated dimension keys.

The table includes order and shipping dates, customer and product keys, geography, shipping mode, sales, quantity, discount, and profit.

The fact table contains **9,994 records**, matching the cleaned staging dataset.

## 6. Data Quality and Modeling Decisions

During data preparation, several checks and modeling decisions were made:

- Numeric values were validated after identifying incorrect type conversions during the initial CSV import.
- Source values were reimported as text before explicit type conversion.
- Customer identifiers were checked for consistency across customer names and segments.
- Product identifiers were found to be associated with multiple product names in some cases. The product dimension therefore uses the combination of `Product_ID` and `Product_Name` to preserve distinct product records.
- Geographic combinations were validated before loading the dimension table.
- Foreign key matching was validated before loading the fact table.

These decisions were made to preserve the source data and maintain referential integrity in the analytical model.

## 7. Validation Results

The fact table was compared against the cleaned staging dataset to verify that the loading process preserved the source aggregates.

| Validation Metric | Result |
|---|---:|
| Fact records | 9,994 |
| Distinct orders | 5,009 |
| Total sales | 2,297,200.867 |
| Total quantity | 37,873 |
| Total profit | 286,397.162 |
| Unmatched dimension records before loading | 0 |

All listed aggregate values matched between the cleaned staging data and the fact table.

## 8. SQL Scripts

The SQL scripts are organized by implementation stage.

| Script | Purpose |
|---|---|
| `01-create-database.sql` | Creates the project database if it does not exist. |
| `02-create-schemas.sql` | Creates the `stg`, `dim`, and `fact` schemas. |
| `03-import-and-validate-staging.sql` | Documents the manual CSV import and validates the staging tables. |
| `04-create-clean-table.sql` | Converts source values into appropriate data types. |
| `05-create-dimensions.sql` | Creates the customer, product, and geography dimensions. |
| `06-create-date-dimension.sql` | Creates and populates the date dimension. |
| `07-create-fact-table.sql` | Creates the sales fact table and its foreign key relationships. |
| `08-load-dimensions-and-fact.sql` | Loads the dimension tables and sales fact table. |
| `09-data-validation.sql` | Validates record counts, dimension matches, and business totals. |

### Execution Notes

- The CSV import is performed manually using SQL Server Management Studio (SSMS).
- The scripts document the initial database build and load process.
- The initial load scripts are not designed to be rerun against an already populated database.
- The date dimension must be populated before the sales fact table is loaded.
- The SQL scripts should be reviewed in sequence when reproducing the project in a new database.
- The scripts have not yet been fully tested as a complete, automated deployment process.

## 9. Planned Next Steps

- [x] Document the database architecture and relationships.
- [x] Create a data dictionary for the staging, dimension, and fact tables.
- [x] Document data quality checks and modeling decisions.
- [ ] Refine and test the SQL scripts for reproducibility.
- [ ] Develop reusable SQL ETL procedures.
- [ ] Improve the loading process to support safe reruns.
- [ ] Connect Power BI Desktop to SQL Server.
- [ ] Develop DAX measures and business KPIs.
- [ ] Build an interactive dashboard.
- [ ] Document the final business insights.

## 10. Expected Outcome

The final deliverable will be a documented Business Intelligence project demonstrating the workflow from raw data ingestion to data modeling, validation, and interactive reporting.

The project is intended as a practical portfolio example of SQL development, data modeling, data quality validation, and Power BI skills.