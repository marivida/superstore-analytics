
/*
    Project: Superstore Analytics
    Script: 03-import-and-validate-staging.sql
    Purpose: Document and validate the source data import.

    Manual prerequisite:
    Import the source CSV using the SSMS Import Flat File wizard.

    Import the CSV twice:
    1. As the initial import into stg.SuperstoreRaw.
    2. With all columns stored as text into stg.SuperstoreRaw_Text.

    The second import helps preserve the original numeric values
    before explicit data type conversion.
*/

USE SuperstoreDW;
GO

-- 1. Verify that both staging tables exist.
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'stg'
  AND TABLE_NAME IN (
      'SuperstoreRaw',
      'SuperstoreRaw_Text'
  )
ORDER BY TABLE_NAME;
GO

-- 2. Validate the text staging table.
SELECT
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT Row_ID) AS DistinctRowIDs
FROM stg.SuperstoreRaw_Text;
GO

-- 3. Preview the imported source data.
SELECT TOP 10 *
FROM stg.SuperstoreRaw_Text
ORDER BY Row_ID;
GO
