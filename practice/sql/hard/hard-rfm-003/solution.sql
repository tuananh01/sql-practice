-- Xom Data · Điểm tươi mới cộng điểm chuyên cần
-- Problem: https://xomdata.com/practice/hard-rfm-003
-- Solved: 2026-09-19

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
    (r_score + f_score) AS total_score,
    CASE WHEN (r_score + f_score) >= 7 THEN 'Gold'
         WHEN (r_score + f_score) IN (5, 6) THEN 'Silver'
         ELSE 'Bronze'
    END label
FROM (
    SELECT 
        customer_id,
        -- Sort Best to Worst (ascending recency), fallback to customer_id ASC, then invert bucket to score
        6 - NTILE(5) OVER(ORDER BY recency ASC, customer_id ASC) AS r_score,
        -- Sort Best to Worst (descending freq/money), fallback to customer_id ASC, then invert bucket to score
        CASE WHEN freq >= 8 THEN 3 
             WHEN freq BETWEEN 4 AND 7 THEN 2
             ELSE 1
        END f_score
    FROM rfm
) T
