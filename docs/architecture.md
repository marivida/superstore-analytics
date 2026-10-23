# Database Architecture

## 1. Overview

The Superstore Analytics database was designed to transform raw sales data into a structured analytical model suitable for Business Intelligence reporting.

The database is organized into three schemas:

- `stg` — Staging and data preparation.
- `dim` — Dimension tables containing descriptive attributes.
- `fact` — Fact table containing sales transactions and measurable business values.

## 2. Data Flow

The data preparation and loading process follows this sequence:

1. Import the original CSV data into SQL Server.
2. Preserve the source values in the staging layer.
3. Convert source values into appropriate data types.
4. Validate data quality and consistency.
5. Populate the dimension tables.
6. Load the sales transactions into the fact table.
7. Reconcile the fact table against the cleaned staging data.
8. Use the analytical database as the planned data source for Power BI.

## 3. Staging Layer

The staging schema contains the imported and cleaned source data.

| Table | Purpose |
|---|---|
| `stg.SuperstoreRaw` | Initial CSV import |
| `stg.SuperstoreRaw_Text` | Source values preserved as text |
| `stg.Superstore_Clean` | Cleaned and typed source data |

The staging layer provides a separation between the original imported data and the data prepared for analytical modeling.

## 4. Dimension Tables

The dimension schema contains descriptive information used to analyze sales from different perspectives.

| Table | Primary Key | Purpose |
|---|---|---|
| `dim.DimCustomer` | `CustomerKey` | Customer information |
| `dim.DimProduct` | `ProductKey` | Product, category, and sub-category information |
| `dim.DimGeography` | `GeographyKey` | Country, region, state, city, and postal code |
| `dim.DimDate` | `DateKey` | Calendar attributes for time-based analysis |

The dimension tables use surrogate keys to identify records within the analytical model.

## 5. Fact Table

The `fact.FactSales` table stores the sales transactions and connects them to the dimension tables.

Its main columns include:

- `SalesKey` — Surrogate primary key.
- `Row_ID` — Source transaction row identifier.
- `Order_ID` — Order identifier.
- `OrderDateKey` — Reference to the order date.
- `ShipDateKey` — Reference to the shipping date.
- `CustomerKey` — Reference to the customer dimension.
- `ProductKey` — Reference to the product dimension.
- `GeographyKey` — Reference to the geography dimension.
- `Ship_Mode` — Shipping method.
- `Sales` — Sales amount.
- `Quantity` — Quantity sold.
- `Discount` — Applied discount.
- `Profit` — Transaction profit.

The fact table has 9,994 records and includes foreign key relationships to the relevant dimension tables.

## 6. Date Dimension

The date dimension covers the period from January 3, 2014, to January 5, 2018, with 1,464 calendar records.

It includes attributes such as year, quarter, month, year-month, day of month, day of week, and day name.

Two date relationships are represented in the fact table:

- Order date.
- Shipping date.

This structure supports time-based analysis of orders and shipments.

## 7. Model Design

The database follows a dimensional modeling approach, with the sales fact table connected to customer, product, geography, and date dimensions.

The date dimension is referenced twice to support analysis using both order date and shipping date.

The product dimension preserves distinct combinations of product identifiers and product names found in the source data.

## 8. Power BI Integration

Power BI Desktop will be connected to the SQL Server database in a subsequent project phase.

The planned report will use the dimensional model to create measures, KPIs, and interactive visualizations for sales, profit, product performance, customer segments, geography, and time-based trends.

## 9. Future Improvements

Potential improvements include:

- Automating the ETL process using stored procedures.
- Making data loads safe to rerun.
- Updating the date dimension automatically when new dates are introduced.
- Adding further data quality checks.
- Documenting the final Power BI relationships and measures.