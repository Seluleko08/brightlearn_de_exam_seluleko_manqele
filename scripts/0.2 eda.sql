--1 Total row count  
SELECT * 
FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;
--answer 5000 rows

--2 Distinct customers 
SELECT	DISTINCT 
customer_first_name,
customer_last_name
FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;
--answer 51 rows

--3 Distinct products
SELECT	DISTINCT 
product_name
FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;
--answer 44 rows

--4 Distinct stores 
SELECT	DISTINCT 
store_name
FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data;
--answer 5 rows

--5 Checkinbg for null values/Missing values
SELECT customer_first_name
FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data
WHERE customer_first_name IS NULL; 
--answer 253 rows

--6 Duplicated records
SELECT *
FROM dev_brightmart_stg.dbo.BrightLearn_Raw_Data
GROUP BY  [transaction_date]
      ,[payment_method]
      ,[cashier_name]
      ,[transaction_amount]
      ,[transaction_discount]
      ,[customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since]
      ,[store_name]
      ,[store_city]
      ,[store_province]
      ,[store_region]
      ,[store_manager]
      ,[product_name]
      ,[category]
      ,[sub_category]
      ,[sku]
      ,[unit_price]
      ,[cost_price]
      ,[supplier]
      ,[qty]
      ,[line_amount]
      ,[stock_on_hand]
      ,[reorder_threshold] HAVING COUNT(*) > 1;
      --answer 44 rows