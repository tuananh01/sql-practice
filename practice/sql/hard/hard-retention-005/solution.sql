-- Xom Data · Còn sống sót tính từ tháng thứ hai trở đi
-- Problem: https://xomdata.com/practice/hard-retention-005
-- Solved: 2026-09-14

WITH cohort AS (
    SELECT
        customer_id,
        DATE(MIN(order_date), 'start of month') cohort_month,
        DATE(MIN(order_date), '+2 months', 'start of month') next_2_mth
    FROM orders 
    GROUP BY 1

)

SELECT 
    strftime('%Y-%m', c.cohort_month) cohort_month,
    COUNT(c.customer_id) cohort_size, 
    COUNT(o.customer_id) survivors,
    ROUND(COUNT(o.customer_id)*100.0/COUNT(c.customer_id), 2) survival_pct 
FROM cohort c 
LEFT JOIN orders o  
ON c.customer_id = o.customer_id
AND strftime('%Y-%m', c.next_2_mth) <= strftime('%Y-%m', o.order_date)

GROUP BY 1
ORDER BY 1
