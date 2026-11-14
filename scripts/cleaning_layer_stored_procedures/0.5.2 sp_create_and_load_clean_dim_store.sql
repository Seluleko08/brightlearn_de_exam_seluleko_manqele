CREATE PROCEDURE dbo.sp_create_clean_dim_store
AS
BEGIN
    /*=========================================================
  Clean Store Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean store table if it does not already exist */
IF OBJECT_ID('dev_brightmart_stg.dbo.clean_dim_store', 'U') IS NULL
BEGIN
    CREATE TABLE dev_brightmart_stg.dbo.clean_dim_store
    (
        Store_ID         INT IDENTITY(1,1) PRIMARY KEY,
        Store_Name       NVARCHAR(50) NOT NULL,
        Store_city       NVARCHAR(50) NOT NULL,
        Store_province   NVARCHAR(50) NOT NULL,
        Store_region     NVARCHAR(50) NOT NULL,
        Store_manager    NVARCHAR(50) NOT NULL,
        Load_date        DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE dev_brightmart_stg.dbo.clean_dim_store;


/* Load cleaned store records */
INSERT INTO dev_brightmart_stg.dbo.clean_dim_store
(
    Store_Name,
    Store_city,
    Store_province,
    Store_region,
    Store_manager
)

SELECT DISTINCT

    -- Store Name
    ISNULL(
        NULLIF(TRIM(CAST(Store_Name AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Store City
    ISNULL(
        NULLIF(TRIM(CAST(Store_city AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Store Province
    ISNULL(
        NULLIF(TRIM(CAST(Store_province AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Store Region
    ISNULL(
        NULLIF(TRIM(CAST(Store_region AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Store Manager
    ISNULL(
        NULLIF(TRIM(CAST(Store_manager AS NVARCHAR(50))), ''),
        'Unknown'
    )

FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;


/* View cleaned store data */
SELECT *
FROM dev_brightmart_stg.dbo.clean_dim_store;
END