/*
Data Quality Checks
Purpose: validate raw retail sales data before analysis and dashboard creation.
Dataset: combined_sales_data_2025
*/
-- Check 1: full row duplicates
-- Result: no full row duplicates found
SELECT *
    , COUNT(*) AS duplicates_count
FROM public.combined_sales_data_2025
GROUP BY order_id
    , product_id
    , product_name
    , category
    , quantity
    , price
    , order_date
    , customer_id
    , customer_name
HAVING COUNT(*) > 1

-- Check 2: duplicate order_id + product_id combinations
-- Result: no duplicates found
SELECT order_id
    , product_id
    , COUNT(*) AS duplicate_count
FROM public.combined_sales_data_2025
GROUP BY 1,2
HAVING count(*) > 1

-- Check 3: one customer_id linked to multiple customer_name values
-- Result: each customer_id is linked to a single customer_name
SELECT customer_id
    , COUNT(DISTINCT customer_name) AS customer_name_count
FROM public.combined_sales_data_2025
GROUP BY 1
HAVING COUNT(DISTINCT customer_name) > 1

-- Check 4: one customer_name linked to multiple customer_id values
-- Result: some customer_name values are linked to multiple customer_id values, 
-- so customer-level analysis should be based on customer_id
SELECT customer_name
    , COUNT(DISTINCT customer_id ) AS customer_id_count
FROM public.combined_sales_data_2025
GROUP BY 1
HAVING COUNT(DISTINCT customer_id) > 1
