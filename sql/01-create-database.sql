/*
    Project: Superstore Analytics
    Script: 01-create-database.sql
    Purpose: Create the project database if it does not exist.
*/

USE master;
GO

IF DB_ID(N'SuperstoreDW') IS NULL
BEGIN
    CREATE DATABASE SuperstoreDW;
END;
GO