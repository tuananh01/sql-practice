-- Xom Data · Assigning customers to the right care segment
-- Problem: https://xomdata.com/practice/hard-rfm-002
-- Solved: 2026-09-15

WITH most_recent_order AS (
    SELECT
        customer_id,
        DATE(MAX(order_date)) mro,
        COUNT(order_id) order_count 
    FROM orders 
    WHERE order_date <= '2024-06-30'
    GROUP BY customer_id
)

SELECT
    *,
    CASE WHEN days_since <= 60 AND order_count >= 3 THEN 'Champions'
         WHEN days_since > 60 AND order_count >= 3 THEN 'At Risk'
         WHEN days_since <= 60 AND order_count < 3 THEN 'Promising'
         ELSE 'Hibernating'
    END segment     
FROM (
    SELECT 
        customer_id,
        (julianday('2024-06-30') - julianday(mro)) days_since,
        order_count
    FROM most_recent_order
)T
