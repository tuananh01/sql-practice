-- Xom Data · Employees paid above their department average
-- Problem: https://xomdata.com/practice/medium-subquery-110
-- Solved: 2026-08-20

SELECT
    *,
    ROUND(
        ((salary-dept_avg_salary)*100.0/dept_avg_salary)
    , 2) premium_pct 
FROM (
    SELECT
        e.full_name,
        d.dept_name,
        e.salary,
        ROUND(AVG(e.salary) OVER(PARTITION BY e.department_id),0) dept_avg_salary 
    FROM employees e 
    JOIN departments d 
    ON e.department_id = d.id 
)T
WHERE salary > dept_avg_salary
ORDER BY premium_pct DESC, dept_name, full_name
