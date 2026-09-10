-- Xom Data · Người mới và người quen mỗi tháng
-- Problem: https://xomdata.com/practice/hard-cohort-003
-- Solved: 2026-09-10

WITH customer_first_month AS (
    -- 1. Find the absolute first month each customer made a purchase
    SELECT 
        customer_id,
        strftime('%Y-%m', MIN(order_date)) AS first_month
    FROM orders
    GROUP BY customer_id
),
monthly_active_customers AS (
    -- 2. Flatten the timeline: Get distinct active months per customer (removes duplicates)
    SELECT DISTINCT
        customer_id,
        strftime('%Y-%m', order_date) AS active_month
    FROM orders
)
-- 3. Compare the active month to their first month
SELECT 
    m.active_month AS month,
    SUM(CASE WHEN m.active_month = f.first_month THEN 1 ELSE 0 END) AS new_customers,
    SUM(CASE WHEN m.active_month > f.first_month THEN 1 ELSE 0 END) AS returning_customers
FROM monthly_active_customers m
JOIN customer_first_month f 
    ON m.customer_id = f.customer_id
GROUP BY m.active_month
ORDER BY m.active_month;
