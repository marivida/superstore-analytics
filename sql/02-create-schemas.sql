
/*
    Project: Superstore Analytics
    Script: 02-create-schemas.sql
    Purpose: Create the schemas used to organize the database objects.
*/

USE SuperstoreDW;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'stg'
)
BEGIN
    EXEC('CREATE SCHEMA stg');
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'dim'
)
BEGIN
    EXEC('CREATE SCHEMA dim');
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'fact'
)
BEGIN
    EXEC('CREATE SCHEMA fact');
END;
GO
