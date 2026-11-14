-- Creates and populates dim_customer dimension table
 IF OBJECT_ID('dev_brightmart_stg.dbo.dim_customer', 'U') IS NULL
    BEGIN
CREATE TABLE  [dev_brightmart_stg].[dbo].[dim_customer](
    [Customer_ID] int identity (1, 1) primary key,
    [Customer_first_name] [nvarchar](50)  NULL,
    [Customer_last_name] [nvarchar](50)  NULL,
    [Customer_email] [nvarchar](50) NULL,
    [Customer_phone] [nvarchar](50)  NULL,
    [Customer_city] [nvarchar](50)  NULL,
    [Customer_province] [nvarchar](50)  NULL,
    [Customer_loyalty_tier] [nvarchar](50) NULL,
    [Customer_since] [nvarchar](50)  NULL,
    [Cashier_name] [nvarchar](50) NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
)
END
-- Insert  customer records from raw data
INSERT INTO
     [dev_brightmart_stg].[dbo].[dim_customer](
    [Customer_first_name],
    [Customer_last_name],
    [Customer_email],
    [Customer_phone] ,
    [Customer_city] ,
    [Customer_province] ,
    [Customer_loyalty_tier] ,
    [Customer_since] ,
    [Cashier_name]
    )
SELECT
    [Customer_first_name],
    [Customer_last_name],
    [Customer_email],
    [Customer_phone] ,
    [Customer_city] ,
    [Customer_province] ,
    [Customer_loyalty_tier] ,
    [Customer_since] ,
    [Cashier_name]
FROM
    [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ]


-- Verification Query: Display loaded customer dimension records
SELECT
    *
FROM
    [dev_brightmart_stg].[dbo].[dim_customer]