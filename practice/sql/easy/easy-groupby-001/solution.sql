-- Xom Data · Headcount per membership plan
-- Problem: https://xomdata.com/practice/easy-groupby-001
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    plan,
    COUNT(id) num_members 
FROM members  
GROUP BY 1
