----REF BQ-03
--Raised By Rofhiwa, CEO

--Business Question

--What is the month-over-month revenue growth rate across all stores combined?

--Answer



WITH MonthlyRevenue AS
(
    SELECT

        YEAR(Transaction_Date) AS Sales_Year,
        MONTH(Transaction_Date) AS Sales_Month,

        SUM(Line_amount) AS Total_Revenue

    FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

    WHERE Transaction_Date >= '2024-01-01'
      AND Transaction_Date < '2024-07-01'

    GROUP BY

        YEAR(Transaction_Date),
        MONTH(Transaction_Date)
)

SELECT

    Sales_Year,
    Sales_Month,
    Total_Revenue,

    LAG(Total_Revenue) OVER
    (
        ORDER BY Sales_Year, Sales_Month
    ) AS Previous_Month_Revenue,

    ROUND
    (
        (
            (Total_Revenue -
             LAG(Total_Revenue) OVER
             (
                ORDER BY Sales_Year, Sales_Month
             ))
             * 100.0
        )
        /
        NULLIF
        (
            LAG(Total_Revenue) OVER
            (
                ORDER BY Sales_Year, Sales_Month
            ),
            0
        ),
        2
    ) AS Revenue_Growth_Percentage

FROM MonthlyRevenue

ORDER BY
    Sales_Year,
    Sales_Month;