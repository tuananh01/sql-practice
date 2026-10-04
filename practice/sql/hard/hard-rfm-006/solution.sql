-- Xom Data · Bản đồ tám nhóm khách hàng
-- Problem: https://xomdata.com/practice/hard-rfm-006
-- Solved: 2026-10-04

WITH r_f AS (
    SELECT 
        customer_id,
        julianday('2024-06-30') - julianday(MAX(order_date)) days_gap,
        COUNT(order_id) total_orders
    FROM orders 
    GROUP BY 1
), r_f_score AS (
    SELECT 
        customer_id,
        CASE WHEN days_gap <= 30 THEN 4 
             WHEN days_gap > 30 AND days_gap <= 60 THEN 3
             WHEN days_gap > 60 AND days_gap <= 120 THEN 2
             ELSE 1
        END r_score,
        CASE WHEN total_orders >= 10 THEN 4 
             WHEN total_orders BETWEEN 5 AND 9 THEN 3
             WHEN total_orders BETWEEN 2 AND 4 THEN 2
             ELSE 1
        END f_score
    FROM r_f
)
SELECT 
    customer_id,
    r_score,
    f_score,
    CASE WHEN r_score >= 3 AND f_score >= 3 THEN 'Champions'
         WHEN r_score >= 3 AND f_score = 2 THEN 'Potential Loyalist'
         WHEN r_score >= 3 AND f_score = 1 THEN 'New Customers'     
         WHEN r_score = 2 AND f_score >= 3 THEN 'At Risk' 
         WHEN r_score = 2 AND f_score <= 2 THEN  'About To Sleep'     
         WHEN r_score = 1 AND f_score >= 3  THEN  'Cannot Lose Them'    
         WHEN r_score = 1 AND f_score = 2 THEN 'Hibernating'
         ELSE 'Lost'
    END segment 
FROM r_f_score
