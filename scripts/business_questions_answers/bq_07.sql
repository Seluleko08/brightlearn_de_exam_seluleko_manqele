----REF BQ-07
--Raised By Thabo Nkosi, Head of Merchandising

--Business Question

--What is the total quantity sold per product category, per store, for the reporting period?

--Answer



SELECT

    Store_Name,
    Store_city,
    Category,

    SUM(Qty) AS Total_Quantity_Sold,

    SUM(Line_amount) AS Total_Revenue,

    COUNT(Sales_ID) AS Number_of_Transactions

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Transaction_Date >= '2024-01-01'
  AND Transaction_Date < '2024-07-01'

GROUP BY

    Store_Name,
    Store_city,
    Category

ORDER BY

    Store_Name,
    Category;