-- Xom Data · Chia khách thành năm hạng chi tiêu
-- Problem: https://xomdata.com/practice/hard-monetary-001
-- Solved: 2026-09-16

WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent 
    FROM orders 
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_spent,
    NTILE(5) OVER(ORDER BY total_spent DESC, customer_id) spend_rank 
FROM customer_spending
ORDER BY spend_rank, customer_id
