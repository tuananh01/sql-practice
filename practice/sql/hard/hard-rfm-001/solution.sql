-- Xom Data · Chấm điểm khách hàng trên ba thước đo
-- Problem: https://xomdata.com/practice/hard-rfm-001
-- Solved: 2026-09-18

WITH rfm AS (
    SELECT 
        customer_id,
        DATE('2024-06-30') - DATE(MAX(order_date)) recency,
        COUNT(order_id) freq,
        SUM(amount) money 
    FROM orders 
    GROUP BY customer_id
    )

SELECT
    *,
    (r_score + f_score + m_score) AS rfm_total 
FROM (
    SELECT 
        customer_id,
        -- Sort Best to Worst (ascending recency), fallback to customer_id ASC, then invert bucket to score
        6 - NTILE(5) OVER(ORDER BY recency ASC, customer_id ASC) AS r_score,
        -- Sort Best to Worst (descending freq/money), fallback to customer_id ASC, then invert bucket to score
        6 - NTILE(5) OVER(ORDER BY freq DESC, customer_id ASC) AS f_score,
        6 - NTILE(5) OVER(ORDER BY money DESC, customer_id ASC) AS m_score
    FROM rfm
) T
ORDER BY rfm_total DESC, customer_id ASC;
