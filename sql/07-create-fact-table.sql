
/*
    Project: Superstore Analytics
    Script: 06-create-fact-table.sql
    Purpose: Create the sales fact table and its dimension relationships.

    Important:
    This script creates a new table. Run it only if fact.FactSales
    does not already exist.
*/

USE SuperstoreDW;
GO

CREATE TABLE fact.FactSales (
    SalesKey INT IDENTITY(1,1) NOT NULL,
    Row_ID INT NOT NULL,
    Order_ID NVARCHAR(50) NOT NULL,
    OrderDateKey INT NOT NULL,
    ShipDateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    GeographyKey INT NOT NULL,
    Ship_Mode NVARCHAR(50) NULL,
    Sales DECIMAL(18,3) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(9,4) NOT NULL,
    Profit DECIMAL(18,3) NOT NULL,

    CONSTRAINT PK_FactSales
        PRIMARY KEY (SalesKey),

    CONSTRAINT UQ_FactSales_RowID
        UNIQUE (Row_ID),

    CONSTRAINT FK_FactSales_OrderDate
        FOREIGN KEY (OrderDateKey)
        REFERENCES dim.DimDate(DateKey),

    CONSTRAINT FK_FactSales_ShipDate
        FOREIGN KEY (ShipDateKey)
        REFERENCES dim.DimDate(DateKey),

    CONSTRAINT FK_FactSales_Customer
        FOREIGN KEY (CustomerKey)
        REFERENCES dim.DimCustomer(CustomerKey),

    CONSTRAINT FK_FactSales_Product
        FOREIGN KEY (ProductKey)
        REFERENCES dim.DimProduct(ProductKey),

    CONSTRAINT FK_FactSales_Geography
        FOREIGN KEY (GeographyKey)
        REFERENCES dim.DimGeography(GeographyKey)
);
GO
