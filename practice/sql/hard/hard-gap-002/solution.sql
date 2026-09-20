-- Xom Data · Quãng im lặng dài nhất của mỗi khách
-- Problem: https://xomdata.com/practice/hard-gap-002
-- Solved: 2026-09-20

WITH gap AS (
    SELECT
        customer_id,
        order_date AS gap_start,
        LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date, order_id) gap_end,
        julianday(LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date, order_id))
            - julianday(order_date) gap_days
        
    FROM orders 
), max_gap AS (
    SELECT
        customer_id,
        MAX(gap_days) gap_days
    FROM gap
    WHERE gap_end IS NOT NULL
    GROUP BY customer_id 
    
)

SELECT 
    g.customer_id,
    MIN(g.gap_start) gap_start,
    MIN(g.gap_end) gap_end,
    m.gap_days
FROM gap g 
JOIN max_gap m
ON g.customer_id = m.customer_id
AND g.gap_days = m.gap_days 
GROUP BY g.customer_id
ORDER BY m.gap_days DESC, g.customer_id




--HAVING COUNT(order_id) >= 2
