-- Creates and populates fact_brightmart_sales  fact table
 IF OBJECT_ID('dev_brightmart_stg.dbo.fact_brightmart_sales', 'U') IS NULL
    BEGIN
CREATE TABLE  [dev_brightmart_stg].[dbo].[fact_brightmart_sales](
        Sales_ID INT IDENTITY(1, 1) PRIMARY KEY,
        Date_ID INT NULL,
        Payment_ID INT  NULL,
        Customer_ID INT NULL,
        Store_ID INT NULL,
        Product_ID INT  NULL,
        Transaction_amount DECIMAL(10, 2) NOT NULL,
        Transaction_discount DECIMAL(10, 2) NOT NULL,
        Unit_price DECIMAL(10, 2) NOT NULL,
        Cost_price DECIMAL(10, 2) NOT NULL,
        Qty DECIMAL(10, 2) NOT NULL,
        Line_amount DECIMAL(10, 2) NOT NULL,
        Stock_on_hand DECIMAL(10, 2) NOT NULL,
        Reorder_threshold INT NOT NULL,
        LoadDate DATETIME DEFAULT GETDATE()
    )
    END

   --Insert sales  records from raw data
    INSERT INTO dev_brightmart_stg.dbo.fact_brightmart_sales (
        Transaction_amount,
        Transaction_discount ,
        Unit_price ,
        Cost_price ,
        Qty,
        Line_amount ,
        Stock_on_hand ,
        Reorder_threshold
    )
    SELECT
        Transaction_amount,
        Transaction_discount ,
        Unit_price ,
        Cost_price ,
        Qty,
        Line_amount ,
        Stock_on_hand ,
        Reorder_threshold
      
    FROM [dev_brightmart_stg].[dbo].[BrightLearn_Raw_Data ]  
  
    -- Verification Query: Display loaded  fact_brightmart_sales records

    SELECT *
    FROM  dev_brightmart_stg.dbo.fact_brightmart_sales