-- Xom Data · Top 2 salespeople by sales each month
-- Problem: https://xomdata.com/practice/expert-final-multi-007
-- Solved: 2026-09-06


WITH revenue_info AS (
    SELECT
        month,
        employee_id,
        SUM(revenue) total_sales
    FROM sales
    GROUP BY 1, 2
)

SELECT 
    *
FROM (
    SELECT
        r.month,
        DENSE_RANK() OVER(PARTITION BY month ORDER BY r.total_sales DESC) hang,
        r.employee_id,
        e.full_name,
        r.total_sales
    FROM revenue_info r
    LEFT JOIN employees e 
    ON r.employee_id = e.id
)T 
WHERE hang IN (1, 2)
ORDER BY month, hang, employee_id
