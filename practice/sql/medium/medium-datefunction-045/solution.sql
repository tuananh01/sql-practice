-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-08-16

SELECT
    *,
    total_amount - LAG(total_amount) OVER (ORDER BY month) mom_delta 
FROM (
    SELECT
    strftime('%Y-%m', transaction_date) month,
    COUNT(id) transaction_count,
    SUM(amount) total_amount
FROM transactions 
GROUP BY 1
)T
