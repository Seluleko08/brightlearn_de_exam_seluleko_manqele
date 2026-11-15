CREATE PROCEDURE dbo.sp_create_load_clean_dim_customer
AS
BEGIN
    -- Create table if it does not exist
/*=========================================================
Clean Customer Dimension
=========================================================*/

/* Create the clean customer table if it does not already exist */
IF OBJECT_ID('prod_brightmart_dwh.dbo.load_clean_dim_customer', 'U') IS NULL
BEGIN
    CREATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_customer
    (
        Customer_ID             INT IDENTITY(1,1) PRIMARY KEY,
        Customer_first_name     NVARCHAR(255),
        Customer_last_name      NVARCHAR(255),
        Customer_email          NVARCHAR(255),
        Customer_phone          NVARCHAR(255),
        Customer_city           NVARCHAR(255),
        Customer_province       NVARCHAR(255),
        Customer_loyalty_tier   NVARCHAR(255),
        Customer_since          DATE,
        Cashier_name            NVARCHAR(255),
        LoadDate                DATETIME DEFAULT GETDATE()
    );
END;

/* Full refresh before loading the latest clean data */
TRUNCATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_customer;

/*=========================================================
  Remove duplicate customers
  One customer per Customer_email
=========================================================*/

WITH Customer_CTE AS
(
    SELECT

        ISNULL(NULLIF(TRIM(customer_first_name),''),'Unknown') AS Customer_first_name,

        ISNULL(NULLIF(TRIM(customer_last_name),''),'Unknown') AS Customer_last_name,

        ISNULL(
            LOWER(NULLIF(TRIM(customer_email),'')),
            'unknown'
        ) AS Customer_email,

        CASE
            WHEN customer_phone IS NULL THEN 'Unknown'

            WHEN LEN(CAST(customer_phone AS VARCHAR(20))) = 9
                THEN '+27' + CAST(customer_phone AS VARCHAR(20))

            WHEN LEN(CAST(customer_phone AS VARCHAR(20))) = 10
                 AND LEFT(CAST(customer_phone AS VARCHAR(20)),1)='0'
                THEN '+27' + RIGHT(CAST(customer_phone AS VARCHAR(20)),9)

            ELSE CAST(customer_phone AS VARCHAR(20))
        END AS Customer_phone,

        ISNULL(NULLIF(TRIM(customer_city),''),'Unknown') AS Customer_city,

        ISNULL(NULLIF(TRIM(customer_province),''),'Unknown') AS Customer_province,

        ISNULL(
            LOWER(NULLIF(TRIM(customer_loyalty_tier),'')),
            'unknown'
        ) AS Customer_loyalty_tier,

        TRY_CONVERT(DATE,customer_since,103) AS Customer_since,

        ISNULL(NULLIF(TRIM(cashier_name),''),'Unknown') AS Cashier_name,

        ROW_NUMBER() OVER
        (
            PARTITION BY
                ISNULL(
                    LOWER(NULLIF(TRIM(customer_email),'')),
                    'unknown@brightmart.co.za'
                )
            ORDER BY
                TRY_CONVERT(DATE,customer_since,103) DESC
        ) AS RowNum

    FROM dev_brightmart_stg.dbo.clean_dim_customer
)

/*=========================================================
  Insert one record per customer
=========================================================*/

INSERT INTO prod_brightmart_dwh.dbo.load_clean_dim_customer
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

SELECT

    Customer_first_name,
    Customer_last_name,
    Customer_email,
    Customer_phone,
    Customer_city,
    Customer_province,
    Customer_loyalty_tier,
    Customer_since,
    Cashier_name

FROM Customer_CTE
WHERE RowNum = 1;

/* View cleaned customer data */
SELECT *
FROM prod_brightmart_dwh.dbo.load_clean_dim_customer;
END