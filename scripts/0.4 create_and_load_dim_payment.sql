--dim_payment dimension table
 IF OBJECT_ID('dev_brightmart_stg.dbo.dim_payment', 'U') IS NULL
    BEGIN
CREATE TABLE  [dev_brightmart_stg].[dbo].[dim_payment](
    [Payment_ID] int identity (1, 1) primary key,
    [Payment_Method] [nvarchar](50) NOT NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
)
END;

-- Insert  payment method records from raw data
INSERT INTO
    [dev_brightmart_stg].[dbo].[dim_payment](
    [Payment_Method])

SELECT
    [Payment_Method]
FROM
     [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ]

-- Verification Query: Display loaded payment dimension records
SELECT
    *
FROM
     [dev_brightmart_stg].[dbo].[dim_payment]