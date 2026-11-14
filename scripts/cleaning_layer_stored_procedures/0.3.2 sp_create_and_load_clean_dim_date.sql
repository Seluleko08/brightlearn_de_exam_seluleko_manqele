CREATE PROCEDURE dbo.sp_create_clean_dim_date
AS
BEGIN
    /*=========================================================
  Clean Date Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean date table if it does not already exist */
IF OBJECT_ID('dev_brightmart_stg.dbo.clean_dim_date', 'U') IS NULL
BEGIN
    CREATE TABLE dev_brightmart_stg.dbo.clean_dim_date
    (
        Date_ID             INT IDENTITY(1,1) PRIMARY KEY,
        Transaction_Date    DATE NOT NULL,
        Load_date           DATETIME NOT NULL DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE dev_brightmart_stg.dbo.clean_dim_date;


/* Load cleaned date records */
INSERT INTO dev_brightmart_stg.dbo.clean_dim_date
(
    Transaction_Date
)

SELECT DISTINCT

    ISNULL
    (
        TRY_CONVERT(DATE, LTRIM(RTRIM(Transaction_Date)), 103),
        '1900-01-01'
    ) AS Transaction_Date

FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;


/* View cleaned date data */
SELECT *
FROM dev_brightmart_stg.dbo.clean_dim_date;
END