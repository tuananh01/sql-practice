-- Xom Data · Salary by department and title
-- Problem: https://xomdata.com/practice/medium-join-126
-- Solved: 2026-10-10

SELECT 
    d.department_name,
    po.position_name,
    COUNT(e.id) employee_count, 
    AVG(pa.net_salary) avg_salary,
    MIN(pa.net_salary) min_salary,
    MAX(pa.net_salary) max_salary,
    MAX(pa.net_salary) - MIN(pa.net_salary) salary_spread,
    RANK() OVER(PARTITION BY d.department_name ORDER BY AVG(pa.net_salary) DESC) rank_in_dept 
FROM employees e 
JOIN departments d 
ON e.department_id = d.id
JOIN positions po 
ON e.position_id = po.id 
JOIN payroll pa 
ON e.id = pa.employee_id
GROUP BY 1, 2
ORDER BY 1, rank_in_dept, 2
