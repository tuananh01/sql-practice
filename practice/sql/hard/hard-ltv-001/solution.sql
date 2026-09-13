-- Xom Data · Giá trị trọn đời trung bình của mỗi thế hệ
-- Problem: https://xomdata.com/practice/hard-ltv-001
-- Solved: 2026-09-13

WITH cohort AS (
    SELECT 
        customer_id,
        DATE(MIN(order_date), 'start of month') cohort_month

    FROM orders 
    GROUP BY customer_id
)

SELECT
    strftime('%Y-%m', c.cohort_month) cohort_month,
    COUNT(DISTINCT o.customer_id) cohort_size,
    ROUND(
        SUM(o.amount)*1.0/COUNT(DISTINCT o.customer_id)
     ,2) avg_ltv 
FROM orders o 
LEFT JOIN cohort c 
ON c.customer_id = o.customer_id
GROUP BY strftime('%Y-%m', c.cohort_month) 
ORDER BY cohort_month
