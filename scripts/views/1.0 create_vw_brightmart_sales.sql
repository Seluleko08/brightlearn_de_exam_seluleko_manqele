CREATE VIEW .dbo.vw_brightmart_sales
AS

SELECT

    /*=====================================================
      Fact Table
    =====================================================*/
    f.Sales_ID,

    /*=====================================================
      Date Dimension
    =====================================================*/
    d.Transaction_Date,

    /*=====================================================
      Customer Dimension
    =====================================================*/
    c.Customer_first_name,
    c.Customer_last_name,
    c.Customer_email,
    c.Customer_phone,
    c.Customer_city,
    c.Customer_province,
    c.Customer_loyalty_tier,
    c.Customer_since,

    /*=====================================================
      Payment Dimension
    =====================================================*/
    p.Payment_Method,

    /*=====================================================
      Store Dimension
    =====================================================*/
    s.Store_Name,
    s.Store_city,
    s.Store_province,
    s.Store_region,
    s.Store_manager,

    /*=====================================================
      Product Dimension
    =====================================================*/
    pr.Product_name,
    pr.Category,
    pr.Sub_category,
    pr.Sku,
    pr.Supplier,

    /*=====================================================
      Fact Measures
    =====================================================*/
    f.Transaction_amount,
    f.Transaction_discount,
    f.Unit_price,
    f.Cost_price,
    f.Qty,
    f.Line_amount,
    f.Stock_on_hand,
    f.Reorder_threshold,

    f.LoadDate

FROM prod_brightmart_dwh.dbo.load_clean_fact_brightmart_sales AS f

INNER JOIN prod_brightmart_dwh.dbo.load_clean_dim_date AS d
    ON f.Date_ID = d.Date_ID

INNER JOIN prod_brightmart_dwh.dbo.load_clean_dim_customer AS c
    ON f.Customer_ID = c.Customer_ID

INNER JOIN prod_brightmart_dwh.dbo.load_clean_dim_payment AS p
    ON f.Payment_ID = p.Payment_ID

INNER JOIN prod_brightmart_dwh.dbo.load_clean_dim_store AS s
    ON f.Store_ID = s.Store_ID

INNER JOIN prod_brightmart_dwh.dbo.load_clean_dim_product AS pr
    ON f.Product_ID = pr.Product_ID;
GO