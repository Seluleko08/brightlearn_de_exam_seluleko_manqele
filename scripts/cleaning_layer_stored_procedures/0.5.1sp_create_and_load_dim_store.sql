CREATE PROCEDURE dbo.sp_create_dim_store
AS
BEGIN
    -- Create table if it does not exist
    IF OBJECT_ID('dev_brightmart_stg.dbo.dim_store', 'U') IS NULL
    BEGIN
        CREATE TABLE [dev_brightmart_stg].[dbo].[dim_store](
            [Store_ID] INT IDENTITY (1, 1) PRIMARY KEY,
            [Store_Name] NVARCHAR(50) NOT NULL,
            [Store_city] NVARCHAR(50) NOT NULL,
            [Store_province] NVARCHAR(50) NOT NULL,
            [Store_region] NVARCHAR(50) NOT NULL,
            [Store_manager] NVARCHAR(50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct store records only if they don't already exist
    INSERT INTO [dev_brightmart_stg].[dbo].[dim_store](
        [Store_Name],
        [Store_city],
        [Store_province],
        [Store_region],
        [Store_manager]
    )
    SELECT DISTINCT
        src.Store_Name,
        src.Store_city,
        src.Store_province,
        src.Store_region,
        src.Store_manager
    FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data] src
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dev_brightmart_stg].[dbo].[dim_store] tgt
        WHERE tgt.Store_Name    = src.Store_Name
          AND tgt.Store_city    = src.Store_city
          AND tgt.Store_province= src.Store_province
          AND tgt.Store_region  = src.Store_region
          AND tgt.Store_manager = src.Store_manager
    );
END;
GO