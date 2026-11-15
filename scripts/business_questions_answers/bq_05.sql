----REF BQ-05
--Raised By Priya Govender, Loyalty Programme Manager

--Business Question

--Which registered loyalty customers have not made a purchase since 28 April 2024?
--These customers must be flagged for a targeted win-back campaign.

--Answer



SELECT

    Customer_ID,
    Customer_first_name,
    Customer_last_name,
    Customer_email,
    Customer_phone,
    Customer_city,
    Customer_province,
    Customer_loyalty_tier,

    MAX(Transaction_Date) AS Last_Purchase_Date,

    DATEDIFF
    (
        DAY,
        MAX(Transaction_Date),
        '2024-04-28'
    ) AS Days_Since_Last_Purchase

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Customer_loyalty_tier <> 'unknown'

GROUP BY

    Customer_ID,
    Customer_first_name,
    Customer_last_name,
    Customer_email,
    Customer_phone,
    Customer_city,
    Customer_province,
    Customer_loyalty_tier

HAVING MAX(Transaction_Date) < '2024-04-28'

ORDER BY Last_Purchase_Date;