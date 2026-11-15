CREATE PROCEDURE dbo.sp_create_load_clean_dim_date
AS
BEGIN
    /*=========================================================
  Clean Date Dimension
=========================================================*/

SET NOCOUNT ON;

/* Create the clean date table if it does not already exist */
IF OBJECT_ID('prod_brightmart_dwh.dbo.load_clean_dim_date', 'U') IS NULL
BEGIN
    CREATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_date
    (
        date_id          INT IDENTITY(1,1) PRIMARY KEY,
        transaction_date DATE,
        LoadDate         DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_date


/* Load cleaned date records */
INSERT INTO prod_brightmart_dwh.dbo.load_clean_dim_date
(
    transaction_date
)
SELECT DISTINCT
    COALESCE
    (
        TRY_CONVERT(DATE, Transaction_Date, 23),  -- YYYY-MM-DD
        TRY_CONVERT(DATE, Transaction_Date, 103), -- DD/MM/YYYY
        TRY_CONVERT(DATE, Transaction_Date, 105)  -- DD-MM-YYYY
    )
FROM dev_brightmart_stg.dbo.clean_dim_date 
WHERE COALESCE
(
    TRY_CONVERT(DATE, Transaction_Date, 23),
    TRY_CONVERT(DATE, Transaction_Date, 103),
    TRY_CONVERT(DATE, Transaction_Date, 105)
) IS NOT NULL;


/* View cleaned date data */
SELECT *
FROM prod_brightmart_dwh.dbo.load_clean_dim_date;
END