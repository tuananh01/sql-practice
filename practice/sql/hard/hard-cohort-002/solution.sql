-- Xom Data · Bảng theo dõi khách quay lại theo thế hệ
-- Problem: https://xomdata.com/practice/hard-cohort-002
-- Solved: 2026-09-23

WITH cohort AS (
    SELECT
        customer_id,
        strftime('%Y-%m', DATE(MIN(order_date), 'start of month')) m0,
        strftime('%Y-%m', DATE(MIN(order_date), 'start of month', '+1 month')) m1,
        strftime('%Y-%m', DATE(MIN(order_date), 'start of month', '+2 month')) m2,
        strftime('%Y-%m', DATE(MIN(order_date), 'start of month', '+3 month')) m3
    FROM orders
    GROUP BY 1
), purchased_customers AS (
        SELECT DISTINCT
            customer_id,
            strftime('%Y-%m', order_date) order_date
        FROM orders
)

SELECT 
    c.m0 cohort_month,
    SUM(CASE WHEN p.order_date = c.m0 THEN 1 ELSE 0 END) AS m0,
    SUM(CASE WHEN p.order_date = c.m1 THEN 1 ELSE 0 END) AS m1,
    SUM(CASE WHEN p.order_date = c.m2 THEN 1 ELSE 0 END) AS m2,
    SUM(CASE WHEN p.order_date = c.m3 THEN 1 ELSE 0 END) AS m3
FROM purchased_customers p
LEFT JOIN cohort c 
ON p.customer_id= c.customer_id
GROUP BY 1
ORDER BY 1
