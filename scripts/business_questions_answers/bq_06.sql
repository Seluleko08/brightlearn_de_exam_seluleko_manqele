----REF BQ-06
--Raised By Priya Govender, Loyalty Programme Manager

--Business Question

--What is the average transaction value broken down by customer loyalty tier (Bronze, Silver, Gold)?

--Answer



SELECT

    Customer_loyalty_tier,

    COUNT(Sales_ID) AS Number_of_Transactions,

    SUM(Line_amount) AS Total_Revenue,

    AVG(Line_amount) AS Average_Transaction_Value

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Customer_loyalty_tier IN ('Bronze', 'Silver', 'Gold')

GROUP BY

    Customer_loyalty_tier

ORDER BY

    Average_Transaction_Value DESC;