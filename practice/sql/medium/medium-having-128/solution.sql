-- Xom Data · Employees averaging over 5 overtime hours
-- Problem: https://xomdata.com/practice/medium-having-128
-- Solved: 2026-08-11

WITH employee_stats AS (
    SELECT
        e.full_name,
        e.employee_code,
        AVG(a.work_days) AS avg_work_days,
        AVG(a.overtime_hours) AS avg_overtime_hours,
        AVG(p.net_salary) AS avg_salary,
        ROUND(AVG(a.overtime_hours) / AVG(a.work_days), 4) AS overtime_intensity
    FROM employees e 
    LEFT JOIN attendance a ON e.id = a.employee_id
    LEFT JOIN payroll p ON e.id = p.employee_id 
    GROUP BY 1, 2
    HAVING AVG(a.overtime_hours) > 5 AND AVG(a.work_days) >= 18
)
SELECT 
    *,
    RANK() OVER(ORDER BY overtime_intensity DESC) AS intensity_rank,
    NTILE(4) OVER(ORDER BY overtime_intensity DESC) AS workload_quartile 
FROM employee_stats
ORDER BY intensity_rank, employee_code;
