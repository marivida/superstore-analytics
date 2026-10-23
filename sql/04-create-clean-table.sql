
/*
    Project: Superstore Analytics
    Script: 04-create-clean-table.sql
    Purpose: Convert the imported text data into properly typed columns.

    Important:
    This script drops and recreates stg.Superstore_Clean.
    Do not run it without considering downstream dependencies.
*/

USE SuperstoreDW;
GO

DROP TABLE IF EXISTS stg.Superstore_Clean;
GO

SELECT
    TRY_CONVERT(INT, Row_ID) AS Row_ID,
    Order_ID,
    TRY_CONVERT(DATE, Order_Date, 101) AS Order_Date,
    TRY_CONVERT(DATE, Ship_Date, 101) AS Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    TRY_CONVERT(DECIMAL(18,3), Sales) AS Sales,
    TRY_CONVERT(INT, Quantity) AS Quantity,
    TRY_CONVERT(DECIMAL(9,4), Discount) AS Discount,
    TRY_CONVERT(DECIMAL(18,3), Profit) AS Profit
INTO stg.Superstore_Clean
FROM stg.SuperstoreRaw_Text;
GO
