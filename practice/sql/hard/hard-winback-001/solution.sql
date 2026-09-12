-- Xom Data · Những người quay về sau hai tháng im ắng
-- Problem: https://xomdata.com/practice/hard-winback-001
-- Solved: 2026-09-12

SELECT
    customer_id,
    next_purchase AS order_date,
    (julianday(next_purchase) - julianday(order_date)) AS gap_days 
FROM (
    SELECT 
    customer_id,
    order_date,
    LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date, order_id) next_purchase
    FROM orders 
    ORDER BY customer_id
)T
WHERE (julianday(next_purchase) - julianday(order_date)) >= 60
