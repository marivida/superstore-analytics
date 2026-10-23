
/*
    Project: Superstore Analytics
    Script: 05-create-dimensions.sql
    Purpose: Create the customer, product, geography, and date dimensions.

    Important:
    This script creates new tables. Run it only in a database where
    these dimension tables do not already exist.
*/

USE SuperstoreDW;
GO

-- 1. Customer dimension
CREATE TABLE dim.DimCustomer (
    CustomerKey INT IDENTITY(1,1) NOT NULL,
    Customer_ID NVARCHAR(50) NOT NULL,
    Customer_Name NVARCHAR(100) NOT NULL,
    Segment NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_DimCustomer
        PRIMARY KEY (CustomerKey),

    CONSTRAINT UQ_DimCustomer_CustomerID
        UNIQUE (Customer_ID)
);
GO

-- 2. Product dimension
CREATE TABLE dim.DimProduct (
    ProductKey INT IDENTITY(1,1) NOT NULL,
    Product_ID NVARCHAR(50) NOT NULL,
    Product_Name NVARCHAR(255) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Sub_Category NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_DimProduct
        PRIMARY KEY (ProductKey),

    CONSTRAINT UQ_DimProduct_SourceProduct
        UNIQUE (Product_ID, Product_Name)
);
GO

-- 3. Geography dimension
CREATE TABLE dim.DimGeography (
    GeographyKey INT IDENTITY(1,1) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    State NVARCHAR(100) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Postal_Code NVARCHAR(20) NULL,

    CONSTRAINT PK_DimGeography
        PRIMARY KEY (GeographyKey),

    CONSTRAINT UQ_DimGeography_Location
        UNIQUE (
            Country,
            Region,
            State,
            City,
            Postal_Code
        )
);
GO
