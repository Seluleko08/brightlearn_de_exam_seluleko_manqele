-- Creates and populates dim_product dimension table
 IF OBJECT_ID('dev_brightmart_stg.dbo.dim_product', 'U') IS NULL
    BEGIN
CREATE TABLE  [dev_brightmart_stg].[dbo].[dim_product](
   [Product_ID] int identity (1, 1) primary key,
   [Product_name] [nvarchar](50) NOT NULL,
   [Category] [nvarchar](50) NULL,
  [Sub_category] [nvarchar](50) NOT NULL,
  [Sku] [nvarchar](50) NOT NULL,
  [Supplier] [nvarchar](50) NOT NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
)
END
-- Insert Product records from raw data
INSERT INTO
  [dev_brightmart_stg].[dbo].[dim_product](
   [Product_name],
   [Category],
  [Sub_category],
  [Sku] ,
  [Supplier] 
  )
SELECT
  [Product_name],
  [Category],
  [Sub_category] ,
  [Sku] ,
  [Supplier] 
FROM
 [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ]

-- Verification Query: Display loaded PC specification dimension records
SELECT
  *
FROM
   [dev_brightmart_stg].[dbo].[dim_product]