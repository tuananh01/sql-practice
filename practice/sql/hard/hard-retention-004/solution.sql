-- Xom Data · Ma trận tỷ lệ quay lại ba tháng đầu
-- Problem: https://xomdata.com/practice/hard-retention-004
-- Solved: 2026-10-05

WITH cohort_data AS (
    -- 1. Lock in the starting month and absolute month integer for each customer
    SELECT 
        customer_id,
        MIN(strftime('%Y-%m', order_date)) AS cohort_month,
        MIN(strftime('%Y', order_date) * 12 + strftime('%m', order_date)) AS start_month
    FROM orders 
    GROUP BY customer_id
),
monthly_activity AS (
    -- 2. Flatten the timeline to a single row per customer per active month
    SELECT DISTINCT 
        customer_id,
        strftime('%Y', order_date) * 12 + strftime('%m', order_date) AS active_month
    FROM orders
)
-- 3. Pivot and calculate percentages in a single pass
SELECT 
    c.cohort_month,
    COUNT(DISTINCT c.customer_id) AS cohort_size,
    100 AS m0_pct,
    ROUND(COUNT(DISTINCT CASE WHEN a.active_month = c.start_month + 1 THEN a.customer_id END) * 100.0 / COUNT(DISTINCT c.customer_id), 2) AS m1_pct,
    ROUND(COUNT(DISTINCT CASE WHEN a.active_month = c.start_month + 2 THEN a.customer_id END) * 100.0 / COUNT(DISTINCT c.customer_id), 2) AS m2_pct
FROM cohort_data c
LEFT JOIN monthly_activity a 
    ON c.customer_id = a.customer_id
GROUP BY c.cohort_month
ORDER BY c.cohort_month ASC;
