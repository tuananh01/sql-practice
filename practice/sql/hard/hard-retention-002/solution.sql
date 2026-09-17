-- Xom Data · Sau một tháng, còn lại bao nhiêu phần
-- Problem: https://xomdata.com/practice/hard-retention-002
-- Solved: 2026-09-17

WITH cohort AS (
    SELECT 
        customer_id,
        DATE(MIN(order_date), 'start of month') cohort_month,
        DATE(MIN(order_date) ,'+1 month', 'start of month') next_month
    FROM orders 
    GROUP BY customer_id
)

SELECT 
    *,
    ROUND(retained_m1*100.0/cohort_size,2) retention_pct 
FROM (
    SELECT 
    strftime('%Y-%m', c.cohort_month) cohort_month,
    COUNT(DISTINCT o.customer_id) cohort_size,
    SUM(CASE WHEN strftime('%Y-%m', o.order_date) = strftime('%Y-%m', c.next_month) THEN 1 ELSE 0 END)
        AS retained_m1
    -- strftime('%Y-%m', o.order_date) order_date,
    -- strftime('%Y-%m', c.next_month) next_month
FROM orders o 
LEFT JOIN cohort c 
-- ON strftime('%Y-%m', c.cohort_month) = strftime('%Y-%m', o.order_date)
ON o.customer_id = c.customer_id
GROUP BY 1
)T
ORDER BY cohort_month
