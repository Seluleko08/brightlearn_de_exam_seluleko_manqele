---REF BQ-01
--Raised By Thabo Nkosi, Head of Merchandising

--Business Question

--What were the top 5 best-selling products by total revenue between January and June 2024?

--Answer

SELECT TOP (5)

    Product_name,
    Category,
    SUM(Line_amount) AS Total_Revenue,
    SUM(Qty) AS Total_Units_Sold,
    COUNT(Sales_ID) AS Number_of_Transactions

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Transaction_Date >= '2024-01-01'
  AND Transaction_Date < '2024-07-01'

GROUP BY
    Product_name,
    Category

ORDER BY
    Total_Revenue DESC;

-- output

--*Instant Coffee 100g
--*Peanut Butter 400g
--*Men's Running Shorts
--*Bamboo Dress Socks 3-Pack
--*Portable Power Bank 20000mAh