-- Xom Data · Frequently co-purchased product pairs
-- Problem: https://xomdata.com/practice/sql-nightmare-004
-- Solved: 2026-08-20

SELECT 
    product_a,
    product_b,
    COUNT(*) co_buyers 
FROM (
    SELECT
    a.user_id, 
    a.product_id product_a,
    b.product_id product_b
FROM orders a 
JOIN orders b 
ON a.user_id = b.user_id 
AND a.product_id < b.product_id
)T
GROUP BY 1, 2
ORDER BY co_buyers DESC, product_a, product_b
