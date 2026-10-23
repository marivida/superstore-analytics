# Data Dictionary

## 1. Purpose

This document describes the main tables and columns used in the Superstore Analytics database.

The database is organized into staging tables, dimension tables, and a fact table.

## 2. Staging Tables

### `stg.SuperstoreRaw`

Stores the initial CSV import.

This table is retained as part of the import history and initial data preparation process.

### `stg.SuperstoreRaw_Text`

Stores the source data with values imported as text.

This approach helps prevent incorrect numeric conversions during the initial import.

### `stg.Superstore_Clean`

Contains the cleaned source data with explicitly converted data types.

| Column | Description |
|---|---|
| `Row_ID` | Source transaction row identifier |
| `Order_ID` | Order identifier |
| `Order_Date` | Date the order was placed |
| `Ship_Date` | Date the order was shipped |
| `Ship_Mode` | Shipping method |
| `Customer_ID` | Source customer identifier |
| `Customer_Name` | Customer name |
| `Segment` | Customer segment |
| `Country` | Country associated with the transaction |
| `City` | City associated with the transaction |
| `State` | State associated with the transaction |
| `Postal_Code` | Postal code associated with the transaction |
| `Region` | Geographic region |
| `Product_ID` | Source product identifier |
| `Category` | Product category |
| `Sub_Category` | Product sub-category |
| `Product_Name` | Product name |
| `Sales` | Sales amount |
| `Quantity` | Quantity sold |
| `Discount` | Applied discount |
| `Profit` | Profit amount |

## 3. Dimension Tables

### `dim.DimCustomer`

Contains customer attributes.

| Column | Description |
|---|---|
| `CustomerKey` | Surrogate primary key |
| `Customer_ID` | Source customer identifier |
| `Customer_Name` | Customer name |
| `Segment` | Customer segment |

### `dim.DimProduct`

Contains product attributes.

| Column | Description |
|---|---|
| `ProductKey` | Surrogate primary key |
| `Product_ID` | Source product identifier |
| `Product_Name` | Product name |
| `Category` | Product category |
| `Sub_Category` | Product sub-category |

The dimension identifies records using the combination of `Product_ID` and `Product_Name`, preserving distinct combinations found in the source data.

### `dim.DimGeography`

Contains geographic attributes.

| Column | Description |
|---|---|
| `GeographyKey` | Surrogate primary key |
| `Country` | Country |
| `Region` | Geographic region |
| `State` | State |
| `City` | City |
| `Postal_Code` | Postal code, stored as text and allowed to be null |

### `dim.DimDate`

Contains calendar attributes used for time-based analysis.

| Column | Description |
|---|---|
| `DateKey` | Integer date key in YYYYMMDD format |
| `FullDate` | Full calendar date |
| `Year` | Calendar year |
| `QuarterNumber` | Calendar quarter number |
| `MonthNumber` | Calendar month number |
| `MonthName` | Calendar month name |
| `YearMonth` | Year and month label |
| `DayOfMonth` | Day of the month |
| `DayOfWeekNumber` | Day of the week number |
| `DayName` | Day of the week name |

## 4. Fact Table

### `fact.FactSales`

Contains sales transactions and references to the dimension tables.

| Column | Description |
|---|---|
| `SalesKey` | Surrogate primary key |
| `Row_ID` | Source transaction row identifier |
| `Order_ID` | Order identifier |
| `OrderDateKey` | Foreign key to `dim.DimDate` for the order date |
| `ShipDateKey` | Foreign key to `dim.DimDate` for the shipping date |
| `CustomerKey` | Foreign key to `dim.DimCustomer` |
| `ProductKey` | Foreign key to `dim.DimProduct` |
| `GeographyKey` | Foreign key to `dim.DimGeography` |
| `Ship_Mode` | Shipping method |
| `Sales` | Sales amount |
| `Quantity` | Quantity sold |
| `Discount` | Applied discount |
| `Profit` | Profit amount |

## 5. Key Concepts

- **Primary key:** Uniquely identifies a record in a table.
- **Foreign key:** Links a record to another table.
- **Surrogate key:** A database-generated identifier used in the dimensional model.
- **Dimension table:** Stores descriptive attributes used to analyze business activity.
- **Fact table:** Stores measurable business events, such as sales transactions.
- **Staging table:** Stores imported or prepared data before analytical loading.

## 6. Notes

This dictionary documents the current database design. It can be expanded as additional columns, ETL procedures, validation rules, and Power BI measures are introduced.