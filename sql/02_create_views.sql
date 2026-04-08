/*
Query 1: Monthly sales revenue by category
Objective: Analyze how category-level revenue changes over time.
*/
CREATE OR REPLACE VIEW public.vw_monthly_sales_by_category AS
SELECT category
    , SUM(quantity * price) AS total_sales
    , date_trunc('month', order_date) AS order_month
FROM public.combined_sales_data_2025
GROUP BY 1, 3;

/*
Query 2: Top 10 customers by total spending
Objective: Identify the highest-value customers.
*/
CREATE OR REPLACE VIEW public.vw_top_customers AS
SELECT customer_id
    , customer_name
    , SUM(quantity * price) AS total_sales
FROM public.combined_sales_data_2025
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;

/*
Query 3: Total units sold by product
Objective: Measure product popularity based on sales volume.
*/
CREATE OR REPLACE VIEW public.vw_units_sold_by_product AS
SELECT product_id
    , product_name
    , SUM(quantity) AS total_units
FROM public.combined_sales_data_2025
GROUP BY 1, 2;

/*
Query 4: Average selling price by category
Objective: Compare average price levels across product categories.
*/
CREATE OR REPLACE VIEW public.vw_avg_price_by_category AS
SELECT category
    , ROUND(AVG(price), 2) AS avg_price
FROM public.combined_sales_data_2025
GROUP BY 1;

/*
Query 5: Sales volume by weekday
Objective: Identify the most active days of the week for sales.
*/
CREATE OR REPLACE VIEW public.vw_sales_by_weekday AS
SELECT SUM(quantity) AS total_units
    , to_char(order_date, 'Day') AS order_day
FROM public.combined_sales_data_2025
GROUP BY 2;
