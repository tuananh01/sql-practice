-- Xom Data · Customers silent for 90 days
-- Problem: https://xomdata.com/practice/hard-anti-001
-- Solved: 2026-09-01

SELECT
    *
FROM (
    SELECT 
        user_id,
        order_date last_order_date,
        (SELECT julianday(MAX(order_date)) FROM orders) - julianday(order_date) days_since_last
    FROM orders
    WHERE (user_id, order_date) IN (
        SELECT 
            user_id,
            MAX(order_date)
        FROM orders 
        GROUP BY 1
    )
)T
WHERE days_since_last >= 90
ORDER BY days_since_last DESC, user_id
