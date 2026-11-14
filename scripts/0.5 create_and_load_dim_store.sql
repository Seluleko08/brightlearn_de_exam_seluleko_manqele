-- Creates and populates dim_store dimension table
 IF OBJECT_ID('dev_brightmart_stg.dbo.dim_store', 'U') IS NULL
    BEGIN
CREATE TABLE  [dev_brightmart_stg].[dbo].[dim_store](
    [Store_ID] int identity (1, 1) primary key,
     [Store_Name] [nvarchar](50) NOT NULL,
     [Store_city] [nvarchar](50) NOT NULL,
     [Store_province] [nvarchar](50) NOT NULL,
     [Store_region] [nvarchar](50) NOT NULL,
     [Store_manager] [nvarchar](50) NOT NULL,
     [Load_date] DATETIME DEFAULT GETDATE()
)
END
-- Insert  store records from raw data
INSERT INTO
    [dev_brightmart_stg].[dbo].[dim_store](
     [Store_Name], 
     [Store_city],
     [Store_province] ,
     [Store_region] ,
     [Store_manager]
     )
SELECT
     [Store_Name], 
     [Store_city],
     [Store_province] ,
     [Store_region] ,
     [Store_manager]
FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ]
     
-- Verification Query: Display loaded store dimension records
SELECT
     *
FROM
     [dev_brightmart_stg].[dbo].[dim_store]