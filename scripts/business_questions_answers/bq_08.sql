----REF BQ-08
--Raised By Thabo Nkosi, Head of Merchandising

--Business Question

--Based on the June 2024 inventory snapshot embedded in the source data, which store-product combinations currently have stock levels below their reorder threshold?

--Answer


SELECT

    Store_Name,
    Store_city,
    Product_name,
    Category,
    Sku,

    Stock_on_hand,
    Reorder_threshold,

    (Reorder_threshold - Stock_on_hand) AS Units_Below_Reorder_Level

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Transaction_Date >= '2024-06-01'
  AND Transaction_Date < '2024-07-01'
  AND Stock_on_hand < Reorder_threshold

ORDER BY

    Store_Name,
    Product_name;