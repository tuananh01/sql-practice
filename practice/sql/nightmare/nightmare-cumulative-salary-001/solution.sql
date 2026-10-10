-- Xom Data · 3-month rolling payroll (excluding each employee's latest month)
-- Problem: https://xomdata.com/practice/nightmare-cumulative-salary-001
-- Solved: 2026-10-10

WITH exclude_most_recent_month AS (
    SELECT 
        id,
        month,
        salary 
    FROM (
        SELECT
            id,
            month,
            MAX(month) OVER(PARTITION BY id) most_recent_month,
            salary
        FROM Employee 
    )T
    WHERE month != most_recent_month
    
)
SELECT 
    Id,
    Month,
    SUM(Salary) OVER(PARTITION BY Id ORDER BY Month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) Salary

FROM exclude_most_recent_month
ORDER BY Id, Month DESC
