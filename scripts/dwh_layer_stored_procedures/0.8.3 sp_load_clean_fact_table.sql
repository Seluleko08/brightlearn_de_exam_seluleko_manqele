CREATE PROCEDURE dbo.sp_create_load_clean_fact_brightmart_sales
AS
BEGIN

    SET NOCOUNT ON;

    /*=========================================================
      Create Fact Table in the Data Warehouse
    =========================================================*/

    IF OBJECT_ID('prod_brightmart_dwh.dbo.load_clean_fact_brightmart_sales','U') IS NULL
    BEGIN
        CREATE TABLE prod_brightmart_dwh.dbo.load_clean_fact_brightmart_sales
        (
            Sales_ID INT IDENTITY(1,1) PRIMARY KEY,

            Date_ID INT NOT NULL,
            Payment_ID INT NOT NULL,
            Customer_ID INT NOT NULL,
            Store_ID INT NOT NULL,
            Product_ID INT NOT NULL,

            Transaction_amount DECIMAL(10,2) NOT NULL,
            Transaction_discount DECIMAL(10,2) NOT NULL,
            Unit_price DECIMAL(10,2) NOT NULL,
            Cost_price DECIMAL(10,2) NOT NULL,
            Qty DECIMAL(10,2) NOT NULL,
            Line_amount DECIMAL(10,2) NOT NULL,
            Stock_on_hand DECIMAL(10,2) NOT NULL,
            Reorder_threshold INT NOT NULL,

            LoadDate DATETIME DEFAULT GETDATE()
        );
    END;

    /*=========================================================
      Full Refresh
    =========================================================*/

    TRUNCATE TABLE prod_brightmart_dwh.dbo.load_clean_fact_brightmart_sales;

    /*=========================================================
      Load Fact Table
    =========================================================*/

    INSERT INTO prod_brightmart_dwh.dbo.load_clean_fact_brightmart_sales
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
        Reorder_threshold,
        LoadDate
    )

    SELECT DISTINCT

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
        Reorder_threshold,

        GETDATE()

    FROM dev_brightmart_stg.dbo.clean_fact_brightmart_sales;

    /*=========================================================
      View Loaded Fact Table
    =========================================================*/

    SELECT *
    FROM prod_brightmart_dwh.dbo.load_clean_fact_brightmart_sales;

END;
GO