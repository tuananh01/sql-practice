-- Xom Data · Top salary in each department
-- Problem: https://xomdata.com/practice/easy-groupby-005
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    department,
    MAX(salary) top_salary
FROM employees
GROUP BY 1
ORDER BY 1
