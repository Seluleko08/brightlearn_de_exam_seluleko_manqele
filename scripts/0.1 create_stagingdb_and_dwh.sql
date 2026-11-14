-- Create staging dev environment (stanging database) if not present 
IF DB_ID('dev_brightmart_stg') IS NULL
BEGIN
    CREATE DATABASE dev_brightmart_stg;
END
GO

-- Create production data warehouse if not present
IF DB_ID('prod_brightmart_dwh') IS NULL
BEGIN
    CREATE DATABASE prod_brightmart_dwh;
END
GO