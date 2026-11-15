----REF BQ-02
--Raised By Johan van der Merwe, Regional Manager

--Business Question

--What was the total revenue per store, broken down by month, for the January–June 2024 period?

--Answer

SELECT

    Store_Name,
    YEAR(Transaction_Date) AS Sales_Year,
    MONTH(Transaction_Date) AS Sales_Month,

    SUM(Line_amount) AS Total_Revenue,
    SUM(Qty) AS Total_Units_Sold,
    COUNT(Sales_ID) AS Number_of_Transactions

FROM prod_brightmart_dwh.dbo.vw_brightmart_sales

WHERE Transaction_Date >= '2024-01-01'
  AND Transaction_Date < '2024-07-01'

GROUP BY

    Store_Name,
    YEAR(Transaction_Date),
    MONTH(Transaction_Date)

ORDER BY

    Store_Name,
    Sales_Year,
    Sales_Month;

--output
--BrightMart Gateway Mall	    1447.95	
--BrightMart Gateway Mall		3795.90	
--BrightMart Gateway Mall		3130.93	
--BrightMart Gateway Mall		3830.83	
--BrightMart Gateway Mall		5836.86	
--BrightMart Gateway Mall		521067.71	
--BrightMart Greenacres		    179.98	
--BrightMart Greenacres		    1731.81	
--BrightMart Greenacres		    753.93	
--BrightMart Greenacres		    2315.94	
--BrightMart Greenacres		    630.91	
--BrightMart Greenacres		    212047.75	
--BrightMart Menlyn Park        4459.99	
--BrightMart Menlyn Park	    787.99	
--BrightMart Menlyn Park		7676.85	
--BrightMart Menlyn Park		1871.98	
--BrightMart Menlyn Park		301869.18	
--BrightMart Sandton City		2160.91	
--BrightMart Sandton City		2264.96	
--BrightMart Sandton City		7821.78	
--BrightMart Sandton City	    14837.66	
--BrightMart Sandton City	    8460.76	
--BrightMart Sandton City     663314.82	
--BrightMart V&A Waterfront	  1577.93	
--BrightMart V&A Waterfront	  4134.96	
--BrightMart V&A Waterfront	  2441.94	
---BrightMart V&A Waterfront	6311.88	
--BrightMart V&A Waterfront	  9269.88
--BrightMart V&A Waterfront	 404271.01