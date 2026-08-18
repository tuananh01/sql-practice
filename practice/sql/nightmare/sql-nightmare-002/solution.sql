-- Xom Data · Median salary per department
-- Problem: https://xomdata.com/practice/sql-nightmare-002
-- Solved: 2026-08-18

SELECT
    dept,
    percentile_cont(.5) WITHIN GROUP (ORDER BY salary) 
        AS median_salary 
FROM employees
GROUP BY dept
