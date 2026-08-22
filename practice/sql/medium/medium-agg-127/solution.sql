-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-08-22

WITH leave_info AS (
    SELECT 
        employee_id,
        COALESCE(SUM(CASE WHEN status = 'duyet' THEN 1 ELSE 0 END),0) leave_count 
    FROM leaves
    GROUP BY 1
),
    payroll_info AS (
        SELECT 
            employee_id,
            SUM(net_salary) total_received_salary 
        FROM payroll
        GROUP BY 1
    )

SELECT
    full_name,
    employee_code,
    department_name,
    total_received_salary,
    leave_count,
    ROUND(
        (total_received_salary-dept_avg)*100.0/dept_avg
    , 2) pct_above_dept_avg 
FROM (
    SELECT
    e.full_name,
    e.employee_code,
    d.department_name,
    p.total_received_salary,
    COALESCE(l.leave_count,0) leave_count,
    AVG(p.total_received_salary) OVER(PARTITION BY department_name) dept_avg
FROM employees e 
JOIN departments d 
ON e.department_id = d.id
LEFT JOIN payroll_info p 
ON e.id = p.employee_id
LEFT JOIN leave_info l
ON e.id = l.employee_id
)t
ORDER BY total_received_salary DESC, employee_code
LIMIT 10
