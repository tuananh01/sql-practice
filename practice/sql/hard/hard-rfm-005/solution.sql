-- Xom Data · Chấm điểm công bằng khi nhiều khách ngang tài
-- Problem: https://xomdata.com/practice/hard-rfm-005
-- Solved: 2026-09-17

WITH total AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent,
        PERCENT_RANK() OVER(ORDER BY SUM(amount) DESC) cust_rank
    FROM orders 
    GROUP BY customer_id
)

SELECT 
    customer_id,
    total_spent,
    CASE WHEN cust_rank < 0.2 THEN 5
         WHEN cust_rank >= 0.2 AND cust_rank < 0.4 THEN 4 
         WHEN cust_rank >= 0.4 AND cust_rank < 0.6 THEN 3
         WHEN cust_rank >= 0.6 AND cust_rank < 0.8 THEN 2
         ELSE 1
    END m_score
FROM total
