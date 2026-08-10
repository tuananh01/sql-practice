-- Xom Data · Total spend for one budget category
-- Problem: https://xomdata.com/practice/easy-sum-005
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    SUM(amount) total_spent 
FROM expenses 
WHERE category = 'Marketing'
