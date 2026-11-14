IF OBJECT_ID('dev_brightmart_stg.dbo.dim_date', 'U') IS NULL
    BEGIN
CREATE TABLE  [dev_brightmart_stg].[dbo].[dim_date](
  [Date_ID] int identity (1, 1) primary key,
  [Transaction_Date] [datetime2](7)  NOT NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
  )
END;

-- Insert distinct date records from raw data
INSERT INTO
  [dev_brightmart_stg].[dbo].[dim_date](
     [Transaction_Date]
  )
SELECT  
TRY_CONVERT (datetime2(7),
  [Transaction_Date],103)--103 = DD/MM/YYY
  FROM
  [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ]
  WHERE
  TRY_CONVERT (datetime2(7),
  [Transaction_Date],103)IS NOT NULL;

-- Verification Query: Display loaded date dimension records
SELECT
  *
FROM
  [dev_brightmart_stg].[dbo].[dim_date]