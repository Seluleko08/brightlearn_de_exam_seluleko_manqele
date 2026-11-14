CREATE PROCEDURE dbo.sp_create_clean_dim_payment
AS
BEGIN
   /*=========================================================
  Clean Payment Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean payment table if it does not already exist */
IF OBJECT_ID('dev_brightmart_stg.dbo.clean_dim_payment', 'U') IS NULL
BEGIN
    CREATE TABLE dev_brightmart_stg.dbo.clean_dim_payment
    (
        Payment_ID         INT IDENTITY(1,1) PRIMARY KEY,
        Payment_Method     NVARCHAR(50) NOT NULL,
        Load_date          DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE dev_brightmart_stg.dbo.clean_dim_payment;


/* Load cleaned payment records */
INSERT INTO dev_brightmart_stg.dbo.clean_dim_payment
(
    Payment_Method
)

SELECT DISTINCT

    ISNULL(
        NULLIF(
            UPPER(TRIM(CAST(Payment_Method AS NVARCHAR(50)))),
            ''
        ),
        'UNKNOWN'
    ) AS Payment_Method

FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;


/* View cleaned payment data */
SELECT *
FROM dev_brightmart_stg.dbo.clean_dim_payment;
END