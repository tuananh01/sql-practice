-- Xom Data · Tháng này mất bao nhiêu khách của tháng trước
-- Problem: https://xomdata.com/practice/hard-churn-002
-- Solved: 2026-09-11

WITH monthly_active AS (
    -- 1. Flatten the data: 1 row per customer per active month
    -- 'start of month' safely handles SQLite date math for 31st days
    SELECT DISTINCT
        customer_id,
        strftime('%Y-%m', order_date) AS current_month,
        strftime('%Y-%m', date(order_date, 'start of month', '+1 month')) AS expected_next_month
    FROM orders
)
SELECT 
    m1.current_month AS month,
    SUM(CASE WHEN m2.current_month IS NULL THEN 1 ELSE 0 END) AS churned_customers
    
FROM monthly_active m1
LEFT JOIN monthly_active m2
    ON m1.customer_id = m2.customer_id
    AND m1.expected_next_month = m2.current_month
-- 2. Explicitly drop the latest month in the entire table
WHERE m1.current_month < (SELECT strftime('%Y-%m', MAX(order_date)) FROM orders)
GROUP BY m1.current_month
ORDER BY m1.current_month;
