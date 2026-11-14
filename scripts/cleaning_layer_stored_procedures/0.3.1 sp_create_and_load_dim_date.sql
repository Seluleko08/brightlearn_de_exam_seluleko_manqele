CREATE PROCEDURE dbo.sp_create_dim_date
AS
BEGIN
    -- Create table if it does not exist
    IF OBJECT_ID('dev_brightmart_stg.dbo.dim_date', 'U') IS NULL
    BEGIN
        CREATE TABLE [dev_brightmart_stg].[dbo].[dim_date](
            [Date_ID] INT IDENTITY (1, 1) PRIMARY KEY,
            [Transaction_Date] DATETIME2(7) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct date records from raw data only if they don't already exist
    INSERT INTO [dev_brightmart_stg].[dbo].[dim_date](
        [Transaction_Date]
    )
    SELECT DISTINCT
        TRY_CONVERT(datetime2(7), [Transaction_Date], 103) AS Transaction_Date
    FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data] src
    WHERE TRY_CONVERT(datetime2(7), [Transaction_Date], 103) IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM [dev_brightmart_stg].[dbo].[dim_date] tgt
          WHERE tgt.Transaction_Date = TRY_CONVERT(datetime2(7), src.[Transaction_Date], 103)
      );
END;
GO