-- Xom Data · Second-highest-paid employee per department
-- Problem: https://xomdata.com/practice/expert-final-subq-003
-- Solved: 2026-09-17

SELECT 
    department,
    full_name,
    salary
FROM (
    SELECT 
        department,
        full_name,
        salary,
        DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) salary_rank
    FROM employees 
)
WHERE salary_rank = 2
