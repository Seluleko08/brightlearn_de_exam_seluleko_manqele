CREATE PROCEDURE dbo.sp_create_load_clean_dim_store
AS
BEGIN
    /*=========================================================
  Clean Store Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean store table if it does not already exist */
IF OBJECT_ID('prod_brightmart_dwh.dbo.load_clean_dim_store', 'U') IS NULL
BEGIN
    CREATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_store
    (
        store_id        INT IDENTITY(1,1) PRIMARY KEY,
        store_name      NVARCHAR(255) NULL,
        store_city      NVARCHAR(255) NULL,
        store_province  NVARCHAR(255) NULL,
        store_region    NVARCHAR(255) NULL,
        store_manager   NVARCHAR(255) NULL,
        LoadDate        DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_store;


/* Load cleaned store records */
INSERT INTO prod_brightmart_dwh.dbo.load_clean_dim_store
(
    store_name,
    store_city,
    store_province,
    store_region,
    store_manager
)
SELECT DISTINCT
    ISNULL(NULLIF(TRIM(store_name), ''), 'Unknown'),
    ISNULL(NULLIF(TRIM(store_city), ''), 'Unknown'),
    ISNULL(NULLIF(TRIM(store_province), ''), 'Unknown'),
    ISNULL(NULLIF(TRIM(store_region), ''), 'Unknown'),
    ISNULL(NULLIF(TRIM(store_manager), ''), 'Unknown')
FROM dev_brightmart_stg.dbo.clean_dim_store;
/* View cleaned store data */
SELECT *
FROM prod_brightmart_dwh.dbo.load_clean_dim_store;
END