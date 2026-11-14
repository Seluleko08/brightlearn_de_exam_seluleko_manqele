CREATE PROCEDURE dbo.sp_create_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table if it does not exist
    IF OBJECT_ID('dev_brightmart_stg.dbo.dim_customer', 'U') IS NULL
    BEGIN
        CREATE TABLE [dev_brightmart_stg].[dbo].[dim_customer](
            [Customer_ID] INT IDENTITY (1, 1) PRIMARY KEY,
            [Customer_first_name] NVARCHAR(50) NULL,
            [Customer_last_name] NVARCHAR(50) NULL,
            [Customer_email] NVARCHAR(50) NULL,
            [Customer_phone] NVARCHAR(50) NULL,
            [Customer_city] NVARCHAR(50) NULL,
            [Customer_province] NVARCHAR(50) NULL,
            [Customer_loyalty_tier] NVARCHAR(50) NULL,
            [Customer_since] NVARCHAR(50) NULL,
            [Cashier_name] NVARCHAR(50) NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct customer records only if they don't already exist
    INSERT INTO [dev_brightmart_stg].[dbo].[dim_customer](
        [Customer_first_name],
        [Customer_last_name],
        [Customer_email],
        [Customer_phone],
        [Customer_city],
        [Customer_province],
        [Customer_loyalty_tier],
        [Customer_since],
        [Cashier_name]
    )
    SELECT DISTINCT
        src.Customer_first_name,
        src.Customer_last_name,
        src.Customer_email,
        src.Customer_phone,
        src.Customer_city,
        src.Customer_province,
        src.Customer_loyalty_tier,
        src.Customer_since,
        src.Cashier_name
    FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data] src
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dev_brightmart_stg].[dbo].[dim_customer] tgt
        WHERE tgt.Customer_email = src.Customer_email
          AND tgt.Customer_phone = src.Customer_phone
    );
END;
GO