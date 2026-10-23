
/*
    Project: Superstore Analytics
    Script: 06-create-date-dimension.sql
    Purpose: Create and populate the date dimension.

    Important:
    This script creates a new table.
    Run it only if dim.DimDate does not already exist.
*/

USE SuperstoreDW;
GO

CREATE TABLE dim.DimDate (
    DateKey INT NOT NULL,
    FullDate DATE NOT NULL,
    [Year] INT NOT NULL,
    QuarterNumber INT NOT NULL,
    MonthNumber INT NOT NULL,
    MonthName NVARCHAR(20) NOT NULL,
    YearMonth CHAR(7) NOT NULL,
    DayOfMonth INT NOT NULL,
    DayOfWeekNumber INT NOT NULL,
    DayName NVARCHAR(20) NOT NULL,

    CONSTRAINT PK_DimDate
        PRIMARY KEY (DateKey),

    CONSTRAINT UQ_DimDate_FullDate
        UNIQUE (FullDate)
);
GO

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;

SELECT
    @StartDate = MIN(SourceDate),
    @EndDate = MAX(SourceDate)
FROM (
    SELECT Order_Date AS SourceDate
    FROM stg.Superstore_Clean

    UNION ALL

    SELECT Ship_Date AS SourceDate
    FROM stg.Superstore_Clean
) AS SourceDates;

WITH DateSeries AS (
    SELECT @StartDate AS CalendarDate

    UNION ALL

    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM DateSeries
    WHERE CalendarDate < @EndDate
)
INSERT INTO dim.DimDate (
    DateKey,
    FullDate,
    [Year],
    QuarterNumber,
    MonthNumber,
    MonthName,
    YearMonth,
    DayOfMonth,
    DayOfWeekNumber,
    DayName
)
SELECT
    CONVERT(INT, CONVERT(CHAR(8), CalendarDate, 112)),
    CalendarDate,
    YEAR(CalendarDate),
    DATEPART(QUARTER, CalendarDate),
    MONTH(CalendarDate),
    DATENAME(MONTH, CalendarDate),
    CONVERT(CHAR(7), CalendarDate, 126),
    DAY(CalendarDate),
    (DATEDIFF(DAY, '19000101', CalendarDate) % 7) + 1,
    DATENAME(WEEKDAY, CalendarDate)
FROM DateSeries
OPTION (MAXRECURSION 0);
GO
