-- Xom Data · Dòng tiền tích luỹ theo tuổi thế hệ
-- Problem: https://xomdata.com/practice/hard-ltv-002
-- Solved: 2026-10-02

WITH cohort AS (
    SELECT
        customer_id,
        strftime('%Y', MIN(order_date))*12 + strftime('%m', MIN(order_date)) abs_1st_month
    FROM orders
    GROUP BY 1
), active_month AS (
    SELECT
        c.customer_id,
        c.abs_1st_month,
        strftime('%Y', order_date)*12 + strftime('%m',order_date) abs_month,
        amount
    FROM cohort c 
    LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
)

SELECT 
    *,
    SUM(revenue) OVER(PARTITION BY cohort_month ORDER BY cohort_month, month_age) 
        AS cumulative_revenue 
FROM (
    SELECT 
        printf('%04d-%02d', (abs_1st_month - 1) / 12, ((abs_1st_month - 1) % 12) + 1) cohort_month,
        (abs_month - abs_1st_month) month_age, 
        SUM(amount) revenue 
    FROM active_month
    GROUP BY 1, 2
    ORDER BY 1 
)T
