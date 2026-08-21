-- Xom Data · Monthly income and expense report
-- Problem: https://xomdata.com/practice/medium-groupby-080
-- Solved: 2026-08-21

SELECT
    *,
    (total_income - total_expense) balance,
    SUM((total_income - total_expense)) OVER(ORDER BY month) cumulative_balance,
    CASE WHEN total_income > total_expense THEN 'Surplus'
         WHEN total_income < total_expense THEN 'Deficit'
         ELSE 'Balanced'
    END status 
FROM (
    SELECT
    strftime('%Y-%m', transaction_date) month,
    SUM(CASE WHEN type = 'Thu' THEN amount ELSE 0 END) total_income,
    SUM(CASE WHEN type = 'Chi' THEN amount ELSE 0 END) total_expense
FROM transactions
GROUP BY 1
)T
ORDER BY month
