CREATE PROCEDURE dbo.sp_create_clean_dim_product
AS
BEGIN
 /*=========================================================
  Clean Product Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean product table if it does not already exist */
IF OBJECT_ID('dev_brightmart_stg.dbo.clean_dim_product', 'U') IS NULL
BEGIN
    CREATE TABLE dev_brightmart_stg.dbo.clean_dim_product
    (
        Product_ID      INT IDENTITY(1,1) PRIMARY KEY,
        Product_name    NVARCHAR(50) NOT NULL,
        Category        NVARCHAR(50) NOT NULL,
        Sub_category    NVARCHAR(50) NOT NULL,
        Sku             NVARCHAR(50) NOT NULL,
        Supplier        NVARCHAR(50) NOT NULL,
        Load_date       DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE dev_brightmart_stg.dbo.clean_dim_product;


/* Load cleaned product records */
INSERT INTO dev_brightmart_stg.dbo.clean_dim_product
(
    Product_name,
    Category,
    Sub_category,
    Sku,
    Supplier
)

SELECT DISTINCT

    -- Product Name
    ISNULL(
        NULLIF(TRIM(CAST(Product_name AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Category
    ISNULL(
        NULLIF(TRIM(CAST(Category AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Sub Category
    ISNULL(
        NULLIF(TRIM(CAST(Sub_category AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- SKU
    ISNULL(
        NULLIF(TRIM(CAST(Sku AS NVARCHAR(50))), ''),
        'Unknown'
    ),

    -- Supplier
    ISNULL(
        NULLIF(TRIM(CAST(Supplier AS NVARCHAR(50))), ''),
        'Unknown'
    )

FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;


/* View cleaned product data */
SELECT *
FROM dev_brightmart_stg.dbo.clean_dim_product;
END