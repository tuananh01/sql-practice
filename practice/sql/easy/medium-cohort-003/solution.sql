-- Xom Data · Tháng chào sân của từng khách
-- Problem: https://xomdata.com/practice/medium-cohort-003
-- Solved: 2026-09-12

SELECT DISTINCT
    customer_id,
    strftime('%Y-%m',FIRST_VALUE(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)) AS cohort_month
FROM orders
ORDER BY cohort_month, customer_id
