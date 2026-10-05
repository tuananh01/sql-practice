-- Xom Data · Thế hệ khách nhìn theo kênh dẫn về
-- Problem: https://xomdata.com/practice/hard-cohort-004
-- Solved: 2026-10-05

WITH cohort AS (
    SELECT
        customer_id,
        order_date,
        MIN(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) cohort_month,
        strftime('%Y', order_date) * 12 + strftime('%m', order_date) abs_month
    FROM orders 
)


SELECT 
    channel,
    strftime('%Y-%m', cohort_month) cohort_month,
    COUNT(DISTINCT customer_id) cohort_size,
    SUM(DISTINCT CASE WHEN c2 IS NOT NULL THEN 1 ELSE 0 END) retained_m1 

FROM (
    SELECT 
        co1.customer_id,
        co1.cohort_month,
        co2.customer_id c2,
        cu.channel
    FROM cohort co1 
    LEFT JOIN customers cu  
    ON co1.customer_id = cu.customer_id 
    LEFT JOIN cohort co2
    ON co1.abs_month + 1 = co2.abs_month
    -- ON strftime('%Y',  co1.order_date) * 12 + strftime('%m', co1.cohort_month) + 1 =
    -- co2.abs_month
    AND co1.customer_id = co2.customer_id
)T
GROUP BY 1,2
