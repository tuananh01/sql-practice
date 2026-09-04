-- Xom Data · Churned and returning customers
-- Problem: https://xomdata.com/practice/hard-churn-001
-- Solved: 2026-09-04

SELECT
    *,
    (julianday(next_order) - julianday(prev_order)) gap_days
FROM (
    SELECT 
        user_id,
        order_date prev_order,
        LEAD(order_date) OVER(PARTITION BY user_id ORDER BY order_date) next_order  
    FROM orders 
)T
WHERE next_order IS NOT NULL 
AND (julianday(next_order) - julianday(prev_order)) >= 90
ORDER BY gap_days DESC, user_id
