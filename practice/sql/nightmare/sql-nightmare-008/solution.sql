-- Xom Data · Score customers by RFM
-- Problem: https://xomdata.com/practice/sql-nightmare-008
-- Solved: 2026-08-23

WITH RFM AS (
    SELECT
        customer_id,
        (SELECT MAX(julianday(txn_date)) FROM transactions) - MAX(julianday(txn_date))+1 recency,
        COUNT(customer_id) frequency,
        ROUND(SUM(amount),2) monetary
    FROM transactions
    GROUP BY 1
)

SELECT
    *,
    ROUND(
        (r_score * 0.4 + f_score * 0.3 + m_score * 0.3)
     ,2) rfm_score 
FROM (
    SELECT
    *,
        NTILE(5) OVER(ORDER BY recency DESC) r_score,
        NTILE(5) OVER(ORDER BY frequency) f_score,
        NTILE(5) OVER(ORDER BY monetary) m_score
    FROM RFM 
)
ORDER BY rfm_score DESC, customer_id
