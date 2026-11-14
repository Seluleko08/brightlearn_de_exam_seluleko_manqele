CREATE PROCEDURE dbo.sp_create_clean_fact_brightmart_sales
AS
BEGIN
   /*=========================================================
  Clean Fact Brightmart Sales
=========================================================*/

SET NOCOUNT ON;


/* Create the clean fact table if it does not already exist */
IF OBJECT_ID('dev_brightmart_stg.dbo.clean_fact_brightmart_sales', 'U') IS NULL
BEGIN
    CREATE TABLE dev_brightmart_stg.dbo.clean_fact_brightmart_sales
    (
        Sales_ID                INT IDENTITY(1,1) PRIMARY KEY,
        Date_ID                 INT NOT NULL,
        Payment_ID              INT NOT NULL,
        Customer_ID             INT NOT NULL,
        Store_ID                INT NOT NULL,
        Product_ID              INT NOT NULL,
        Transaction_amount      DECIMAL(10,2) NOT NULL,
        Transaction_discount    DECIMAL(10,2) NOT NULL,
        Unit_price              DECIMAL(10,2) NOT NULL,
        Cost_price              DECIMAL(10,2) NOT NULL,
        Qty                     DECIMAL(10,2) NOT NULL,
        Line_amount             DECIMAL(10,2) NOT NULL,
        Stock_on_hand           DECIMAL(10,2) NOT NULL,
        Reorder_threshold       INT NOT NULL,
        LoadDate                DATETIME DEFAULT GETDATE()
    );
END;


/* Full refresh before loading the latest clean data */
TRUNCATE TABLE dev_brightmart_stg.dbo.clean_fact_brightmart_sales;


/* Load cleaned fact records */
INSERT INTO dev_brightmart_stg.dbo.clean_fact_brightmart_sales
(
    Date_ID,
    Payment_ID,
    Customer_ID,
    Store_ID,
    Product_ID,
    Transaction_amount,
    Transaction_discount,
    Unit_price,
    Cost_price,
    Qty,
    Line_amount,
    Stock_on_hand,
    Reorder_threshold
)

SELECT DISTINCT

    d.Date_ID,
    p.Payment_ID,
    c.Customer_ID,
    s.Store_ID,
    pr.Product_ID,

    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Transaction_amount),0.00),
    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Transaction_discount),0.00),
    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Unit_price),0.00),
    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Cost_price),0.00),
    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Qty),0.00),
    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Line_amount),0.00),
    ISNULL(TRY_CONVERT(DECIMAL(10,2), src.Stock_on_hand),0.00),
    ISNULL(TRY_CONVERT(INT, src.Reorder_threshold),0)

FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data src

INNER JOIN dev_brightmart_stg.dbo.clean_dim_date d
    ON d.Transaction_Date =
       ISNULL(TRY_CONVERT(DATE, src.Transaction_Date, 103), '1900-01-01')

INNER JOIN dev_brightmart_stg.dbo.clean_dim_payment p
    ON p.Payment_Method =
       ISNULL(NULLIF(TRIM(src.Payment_Method),''),'Unknown')

INNER JOIN dev_brightmart_stg.dbo.clean_dim_customer c
    ON c.Customer_email =
       ISNULL(LOWER(NULLIF(TRIM(src.Customer_email),'')),
              'unknown@brightmart.co.za')

INNER JOIN dev_brightmart_stg.dbo.clean_dim_store s
    ON s.Store_Name =
       ISNULL(NULLIF(TRIM(src.Store_Name),''),'Unknown')
   AND s.Store_city =
       ISNULL(NULLIF(TRIM(src.Store_city),''),'Unknown')
   AND s.Store_province =
       ISNULL(NULLIF(TRIM(src.Store_province),''),'Unknown')
   AND s.Store_region =
       ISNULL(NULLIF(TRIM(src.Store_region),''),'Unknown')
   AND s.Store_manager =
       ISNULL(NULLIF(TRIM(src.Store_manager),''),'Unknown')

INNER JOIN dev_brightmart_stg.dbo.clean_dim_product pr
    ON pr.Product_name =
       ISNULL(NULLIF(TRIM(src.Product_name),''),'Unknown')
   AND pr.Category =
       ISNULL(NULLIF(TRIM(src.Category),''),'Unknown')
   AND pr.Sub_category =
       ISNULL(NULLIF(TRIM(src.Sub_category),''),'Unknown')
   AND pr.Sku =
       ISNULL(NULLIF(TRIM(src.Sku),''),'Unknown')
   AND pr.Supplier =
       ISNULL(NULLIF(TRIM(src.Supplier),''),'Unknown');


/* View cleaned fact data */
SELECT *
FROM dev_brightmart_stg.dbo.clean_fact_brightmart_sales;
END