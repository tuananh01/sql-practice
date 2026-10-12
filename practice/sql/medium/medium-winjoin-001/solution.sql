-- Xom Data · Sales rankings with department names
-- Problem: https://xomdata.com/practice/medium-winjoin-001
-- Solved: 2026-10-12

-- Write your SQL here
SELECT
    d.dept_name,
    RANK() OVER(PARTITION BY d.dept_name ORDER BY sales_amount DESC) dept_rank,
    s.staff_name,
    s.sales_amount
FROM staff s 
JOIN departments d 
ON s.dept_id = d.id 
ORDER BY 1, 2, 3
