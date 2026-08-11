-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-08-11



WITH store_summary AS (
      SELECT
    s.store_name,
    s.reputation_score,
    COUNT(o.id) order_count
FROM sellers s
LEFT JOIN orders o 
ON s.id = o.seller_id
WHERE s.reputation_score >= 4.5 
GROUP BY 1, 2
HAVING COUNT(o.id) >= 3
)

SELECT 
    store_name,
    reputation_score,
    order_count,
    rank_by_orders,
    SUM(order_count) OVER(ORDER BY order_count DESC, store_name
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_orders 
FROM (
    SELECT 
        store_name,
        reputation_score,
        order_count,
        DENSE_RANK() OVER(ORDER BY order_count DESC) rank_by_orders
FROM store_summary
)T
