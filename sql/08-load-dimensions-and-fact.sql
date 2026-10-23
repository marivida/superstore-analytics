
/*
    Project: Superstore Analytics
    Script: 07-load-dimensions-and-fact.sql
    Purpose: Load the dimension tables and the sales fact table.

    Important:
    This script documents the initial load.
    It is not safe to rerun without clearing the target tables
    or implementing an incremental loading strategy.
*/

USE SuperstoreDW;
GO

-- 1. Load the customer dimension.
INSERT INTO dim.DimCustomer (
    Customer_ID,
    Customer_Name,
    Segment
)
SELECT DISTINCT
    Customer_ID,
    Customer_Name,
    Segment
FROM stg.Superstore_Clean;
GO

-- 2. Load the product dimension.
-- Product ID and product name are used together to preserve
-- distinct combinations found in the source data.
INSERT INTO dim.DimProduct (
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
)
SELECT DISTINCT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
FROM stg.Superstore_Clean;
GO

-- 3. Load the geography dimension.
INSERT INTO dim.DimGeography (
    Country,
    Region,
    State,
    City,
    Postal_Code
)
SELECT DISTINCT
    Country,
    Region,
    State,
    City,
    Postal_Code
FROM stg.Superstore_Clean;
GO

-- 4. Populate the date dimension.
-- The date dimension creation and population are documented
-- in the calendar section of the technical documentation.
-- See the original date dimension creation script for details.

-- 5. Load the sales fact table.
INSERT INTO fact.FactSales (
    Row_ID,
    Order_ID,
    OrderDateKey,
    ShipDateKey,
    CustomerKey,
    ProductKey,
    GeographyKey,
    Ship_Mode,
    Sales,
    Quantity,
    Discount,
    Profit
)
SELECT
    s.Row_ID,
    s.Order_ID,
    dOrder.DateKey,
    dShip.DateKey,
    c.CustomerKey,
    p.ProductKey,
    g.GeographyKey,
    s.Ship_Mode,
    s.Sales,
    s.Quantity,
    s.Discount,
    s.Profit
FROM stg.Superstore_Clean AS s
INNER JOIN dim.DimDate AS dOrder
    ON s.Order_Date = dOrder.FullDate
INNER JOIN dim.DimDate AS dShip
    ON s.Ship_Date = dShip.FullDate
INNER JOIN dim.DimCustomer AS c
    ON s.Customer_ID = c.Customer_ID
INNER JOIN dim.DimProduct AS p
    ON s.Product_ID = p.Product_ID
    AND s.Product_Name = p.Product_Name
INNER JOIN dim.DimGeography AS g
    ON s.Country = g.Country
    AND s.Region = g.Region
    AND s.State = g.State
    AND s.City = g.City
    AND (
        s.Postal_Code = g.Postal_Code
        OR (
            s.Postal_Code IS NULL
            AND g.Postal_Code IS NULL
        )
    );
GO
