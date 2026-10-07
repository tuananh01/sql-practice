-- Xom Data · Sales champion of each region
-- Problem: https://xomdata.com/practice/medium-topn-001
-- Solved: 2026-10-07

-- Write your SQL here
SELECT 
    region,
    rep_name,
    sales_amount
FROM (
    SELECT 
    region,
    rep_name,
    sales_amount,
    ROW_NUMBER() OVER(PARTITION BY region ORDER BY sales_amount DESC, rep_name) rnk
FROM reps 
)T
WHERE rnk = 1
ORDER BY region
