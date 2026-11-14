CREATE PROCEDURE dbo.sp_create_dim_product
AS
BEGIN
    -- Create table if it does not exist
    IF OBJECT_ID('dev_brightmart_stg.dbo.dim_product', 'U') IS NULL
    BEGIN
        CREATE TABLE [dev_brightmart_stg].[dbo].[dim_product](
            [Product_ID] INT IDENTITY (1, 1) PRIMARY KEY,
            [Product_name] NVARCHAR(50) NOT NULL,
            [Category] NVARCHAR(50) NULL,
            [Sub_category] NVARCHAR(50) NOT NULL,
            [Sku] NVARCHAR(50) NOT NULL,
            [Supplier] NVARCHAR(50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct product records only if they don't already exist
    INSERT INTO [dev_brightmart_stg].[dbo].[dim_product](
        [Product_name],
        [Category],
        [Sub_category],
        [Sku],
        [Supplier]
    )
    SELECT DISTINCT
        src.Product_name,
        src.Category,
        src.Sub_category,
        src.Sku,
        src.Supplier
    FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data] src
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dev_brightmart_stg].[dbo].[dim_product] tgt
        WHERE tgt.Product_name = src.Product_name
          AND tgt.Category     = src.Category
          AND tgt.Sub_category = src.Sub_category
          AND tgt.Sku          = src.Sku
          AND tgt.Supplier     = src.Supplier
    );
END;
GO