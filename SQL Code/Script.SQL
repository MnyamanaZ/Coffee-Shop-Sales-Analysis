SELECT MAX(transaction_time)
FROM CASESTUDY1.COFFEE_SHOP.SALES;

SELECT
--Aggregates--
COUNT(transaction_id)AS number_of_sale,
SUM(transaction_qty*unit_price)AS total_revenue,
SUM(transaction_qty)AS number_of_units_sold,

-- Dates
    transaction_date AS purchase_date,
    TO_CHAR(TO_DATE(transaction_date), 'YYYYMM') AS month_id,
    DAYNAME(TO_DATE(transaction_date))AS day_of_week,
    MONTHNAME(transaction_date) AS month_name,
    
    --- CASE statements
     CASE 
        WHEN transaction_time BETWEEN TIME '06:00:00' AND TIME '11:59:59' THEN 'Morning'
        WHEN transaction_time BETWEEN TIME '12:00:00' AND TIME '16:59:59' THEN 'Afternoon'
        WHEN transaction_time BETWEEN TIME '17:00:00' AND TIME '19:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,

    CASE 
    WHEN total_revenue BETWEEN 0 AND 10 THEN 'Low'
    WHEN total_revenue BETWEEN 11 AND 49 THEN 'Medium'
ELSE 'High'
END AS spender_bucket,

CASE
    WHEN MONTH(transaction_date) IN (12, 1, 2) THEN 'Summer'
    WHEN MONTH(transaction_date) IN (3, 4, 5) THEN 'Autumn'
     WHEN MONTH(transaction_date) IN (6, 7, 8) THEN 'Winter'
    ELSE 'Spring'
END AS Season,

     -- GROUPS
    transaction_date,
    product_category,
    product_type,
    product_detail,
    store_location

FROM CASESTUDY1.COFFEE_SHOP.SALES

GROUP BY
    store_location,
    product_category,
    product_detail,
    product_type,
    purchase_date,
    month_id,
    day_of_week,
    month_name,
    transaction_time;
