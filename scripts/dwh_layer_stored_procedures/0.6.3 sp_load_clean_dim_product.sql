CREATE PROCEDURE dbo.sp_create_load_clean_dim_product
AS
BEGIN
 /*=========================================================
  Clean Product Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean product table if it does not already exist */
IF OBJECT_ID('prod_brightmart_dwh.dbo.load_clean_dim_product', 'U') IS NULL
BEGIN
    CREATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_product
    (
        product_id      INT IDENTITY(1,1) PRIMARY KEY,
        product_name    NVARCHAR(255) NULL,
        category        NVARCHAR(255) NULL,
        sub_category    NVARCHAR(255) NULL,
        sku             NVARCHAR(255) NULL,
        supplier        NVARCHAR(255) NULL,
        LoadDate        DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_product;


/* Load cleaned product records */
INSERT INTO prod_brightmart_dwh.dbo.load_clean_dim_product
(
    product_name,
    category,
    sub_category,
    sku,
    supplier
)
SELECT DISTINCT
    ISNULL(NULLIF(TRIM(r.Product_name), ''), 'Unknown'),

    CASE
        WHEN r.Category IS NULL OR TRIM(r.Category) = ''
            THEN ISNULL
            (
                (
                    SELECT TOP 1 TRIM(b.Category)
                    FROM dev_brightmart_stg.dbo.clean_dim_product b
                    WHERE b.Sku = r.Sku
                      AND b.Category IS NOT NULL
                      AND TRIM(b.Category) <> ''
                ),
                'Unknown'
            )
        ELSE TRIM(r.Category)
    END,

    ISNULL(NULLIF(TRIM(r.Sub_category), ''), 'Unknown'),

    ISNULL(UPPER(NULLIF(TRIM(r.Sku), '')), 'UNKNOWN'),

    ISNULL(NULLIF(TRIM(r.Supplier), ''), 'Unknown')
FROM dev_brightmart_stg.dbo.clean_dim_product r;



/* View cleaned product data */
SELECT *
FROM prod_brightmart_dwh.dbo.load_clean_dim_product;
END