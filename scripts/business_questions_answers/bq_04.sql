----REF BQ-04
--Raised By Priya Govender, Loyalty Programme Manager

--Business Question

--Who are the top 10 loyalty customers ranked by total spend over the reporting period?

--Answer



SELECT TOP (10)

    Customer_ID,
    Customer_first_name,
    Customer_last_name,
    Customer_email,
    Customer_loyalty_tier,

    SUM(Line_amount) AS Total_Spend,
    SUM(Qty) AS Total_Items_Purchased,
    COUNT(Sales_ID) AS Number_of_Transactions

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Transaction_Date >= '2024-01-01'
  AND Transaction_Date < '2024-07-01'
  AND Customer_loyalty_tier <> 'unknown'

GROUP BY

    customer_ID,
    Customer_first_name,
    Customer_last_name,
    Customer_email,
    Customer_loyalty_tier

ORDER BY

    Total_Spend DESC;