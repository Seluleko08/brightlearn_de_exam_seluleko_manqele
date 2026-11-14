CREATE PROCEDURE dbo.sp_create_clean_dim_customer
AS
BEGIN
    -- Create table if it does not exist
/*=========================================================
Clean Customer Dimension
=========================================================*/

/* Drop the table if it already exists */
IF OBJECT_ID('dev_brightmart_stg.dbo.clean_dim_customer', 'U') IS NOT NULL
BEGIN
    DROP TABLE dev_brightmart_stg.dbo.clean_dim_customer;
END;
/* Create the clean customer table */
CREATE TABLE dev_brightmart_stg.dbo.clean_dim_customer
(
    Customer_ID             INT IDENTITY(1,1) PRIMARY KEY,
    Customer_first_name     NVARCHAR(50) NOT NULL,
    Customer_last_name      NVARCHAR(50) NOT NULL,
    Customer_email          NVARCHAR(100) NOT NULL,
    Customer_phone          NVARCHAR(20) NULL,
    Customer_city           NVARCHAR(50) NOT NULL,
    Customer_province       NVARCHAR(50) NOT NULL,
    Customer_loyalty_tier   NVARCHAR(50) NOT NULL,
    Customer_since          DATE NULL,
    Cashier_name            NVARCHAR(50) NOT NULL,
    Load_date               DATETIME DEFAULT GETDATE()
);

/* Load cleaned customer data */
INSERT INTO dev_brightmart_stg.dbo.clean_dim_customer
(
    Customer_first_name,
    Customer_last_name,
    Customer_email,
    Customer_phone,
    Customer_city,
    Customer_province,
    Customer_loyalty_tier,
    Customer_since,
    Cashier_name
)
SELECT DISTINCT

    -- Customer First Name
    ISNULL(NULLIF(TRIM(CAST(Customer_first_name AS NVARCHAR(50))), ''), 'Unknown'),

    -- Customer Last Name
    ISNULL(NULLIF(TRIM(CAST(Customer_last_name AS NVARCHAR(50))), ''), 'Unknown'),

    -- Customer Email
    ISNULL(
        LOWER(NULLIF(TRIM(CAST(Customer_email AS NVARCHAR(100))), '')),
        'unknown'
    ),

    -- Customer Phone
    CASE
        WHEN Customer_phone IS NULL THEN NULL

        WHEN LEN(CAST(Customer_phone AS VARCHAR(20))) = 9
            THEN '+27' + CAST(Customer_phone AS VARCHAR(20))

        WHEN LEN(CAST(Customer_phone AS VARCHAR(20))) = 10
             AND LEFT(CAST(Customer_phone AS VARCHAR(20)),1) = '0'
            THEN '+27' + RIGHT(CAST(Customer_phone AS VARCHAR(20)),9)

        ELSE CAST(Customer_phone AS VARCHAR(20))
    END,

    -- Customer City
    ISNULL(NULLIF(TRIM(CAST(Customer_city AS NVARCHAR(50))), ''), 'Unknown'),

    -- Customer Province
    ISNULL(NULLIF(TRIM(CAST(Customer_province AS NVARCHAR(50))), ''), 'Unknown'),

    -- Customer Loyalty Tier
    ISNULL(
        LOWER(NULLIF(TRIM(CAST(Customer_loyalty_tier AS NVARCHAR(50))), '')),
        'unknown'
    ),

    -- Customer Since
    TRY_CONVERT(DATE, Customer_since, 103),

    -- Cashier Name
    ISNULL(NULLIF(TRIM(CAST(Cashier_name AS NVARCHAR(50))), ''), 'Unknown')

FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ];


/* View cleaned customer data */
SELECT *
FROM dev_brightmart_stg.dbo.clean_dim_customer;
END