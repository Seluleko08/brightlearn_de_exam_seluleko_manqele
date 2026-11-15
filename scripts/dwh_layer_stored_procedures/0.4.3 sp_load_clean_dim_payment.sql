CREATE PROCEDURE dbo.sp_create_load_clean_dim_payment
AS
BEGIN
/*=========================================================
  Clean Payment Dimension
=========================================================*/

SET NOCOUNT ON;


/* Create the clean payment table if it does not already exist */
IF OBJECT_ID('prod_brightmart_dwh.dbo.load_clean_dim_payment', 'U') IS NULL
BEGIN
    CREATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_payment
    (
        payment_id      INT IDENTITY(1,1) PRIMARY KEY,
        payment_method  NVARCHAR(255),
        LoadDate        DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE prod_brightmart_dwh.dbo.load_clean_dim_payment;


/* Load cleaned payment records */
INSERT INTO prod_brightmart_dwh.dbo.load_clean_dim_payment
(
    payment_method
)
SELECT DISTINCT
    ISNULL(NULLIF(TRIM(payment_method), ''), 'Unknown')
FROM dev_brightmart_stg.dbo.clean_dim_payment ;




/* View cleaned payment data */
SELECT *
FROM prod_brightmart_dwh.dbo.load_clean_dim_payment;
END