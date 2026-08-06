-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-08-06

SELECT
    full_name,
    order_count,
    total_spending,
    avg_order_value,
    ROW_NUMBER() OVER(ORDER BY total_spending DESC, full_name) spending_rank 
FROM (
    SELECT
    c.full_name,
    COUNT(o.id) order_count,
    COALESCE(SUM(o.total_amount), 0) total_spending,
    AVG(o.total_amount) avg_order_value
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
GROUP BY  c.full_name
)T
ORDER BY spending_rank
