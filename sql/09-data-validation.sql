
/*
    Project: Superstore Analytics
    Script: 08-data-validation.sql
    Purpose: Validate record counts, business metrics, and data consistency.
*/

USE SuperstoreDW;
GO

-- 1. Validate the cleaned staging data.
SELECT
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT Row_ID) AS DistinctRowIDs,
    COUNT(DISTINCT Order_ID) AS DistinctOrders,
    SUM(Sales) AS TotalSales,
    SUM(Quantity) AS TotalQuantity,
    SUM(Profit) AS TotalProfit
FROM stg.Superstore_Clean;
GO

-- 2. Validate the fact table.
SELECT
    COUNT(*) AS TotalSalesRecords,
    COUNT(DISTINCT Row_ID) AS DistinctRowIDs,
    COUNT(DISTINCT Order_ID) AS DistinctOrders,
    SUM(Sales) AS TotalSales,
    SUM(Quantity) AS TotalQuantity,
    SUM(Profit) AS TotalProfit
FROM fact.FactSales;
GO

-- 3. Compare the cleaned staging data with the fact table.
SELECT
    'Superstore_Clean' AS SourceTable,
    COUNT(*) AS RecordCount,
    SUM(Sales) AS TotalSales,
    SUM(Quantity) AS TotalQuantity,
    SUM(Profit) AS TotalProfit
FROM stg.Superstore_Clean

UNION ALL

SELECT
    'FactSales' AS SourceTable,
    COUNT(*) AS RecordCount,
    SUM(Sales) AS TotalSales,
    SUM(Quantity) AS TotalQuantity,
    SUM(Profit) AS TotalProfit
FROM fact.FactSales;
GO

-- 4. Validate dimension record counts.
SELECT 'DimCustomer' AS DimensionName, COUNT(*) AS RecordCount
FROM dim.DimCustomer

UNION ALL

SELECT 'DimProduct', COUNT(*)
FROM dim.DimProduct

UNION ALL

SELECT 'DimGeography', COUNT(*)
FROM dim.DimGeography

UNION ALL

SELECT 'DimDate', COUNT(*)
FROM dim.DimDate;
GO

-- 5. Check for missing dimension matches.
SELECT
    COUNT(*) AS TotalSourceRecords,
    SUM(CASE WHEN dOrder.DateKey IS NULL THEN 1 ELSE 0 END)
        AS MissingOrderDates,
    SUM(CASE WHEN dShip.DateKey IS NULL THEN 1 ELSE 0 END)
        AS MissingShipDates,
    SUM(CASE WHEN c.CustomerKey IS NULL THEN 1 ELSE 0 END)
        AS MissingCustomers,
    SUM(CASE WHEN p.ProductKey IS NULL THEN 1 ELSE 0 END)
        AS MissingProducts,
    SUM(CASE WHEN g.GeographyKey IS NULL THEN 1 ELSE 0 END)
        AS MissingGeographies
FROM stg.Superstore_Clean AS s
LEFT JOIN dim.DimDate AS dOrder
    ON s.Order_Date = dOrder.FullDate
LEFT JOIN dim.DimDate AS dShip
    ON s.Ship_Date = dShip.FullDate
LEFT JOIN dim.DimCustomer AS c
    ON s.Customer_ID = c.Customer_ID
LEFT JOIN dim.DimProduct AS p
    ON s.Product_ID = p.Product_ID
    AND s.Product_Name = p.Product_Name
LEFT JOIN dim.DimGeography AS g
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
