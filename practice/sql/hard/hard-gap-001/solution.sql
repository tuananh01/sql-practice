-- Xom Data · Nhịp mua hàng và tín hiệu rời bỏ
-- Problem: https://xomdata.com/practice/hard-gap-001
-- Solved: 2026-09-21

WITH avg_gap AS (
    SELECT
    customer_id,
    ROUND(AVG(gap_days),1) avg_gap_days 
FROM (
    SELECT
    customer_id,
    (julianday(LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date, order_id)) 
        - julianday(order_date)) gap_days
FROM orders 
)T
GROUP BY customer_id
)
SELECT
    customer_id,
    avg_gap_days,
    CASE WHEN avg_gap_days IS NULL THEN 'single'
         WHEN avg_gap_days <= 30 THEN 'fast'
         ELSE 'slow'
    END pace 
FROM avg_gap
