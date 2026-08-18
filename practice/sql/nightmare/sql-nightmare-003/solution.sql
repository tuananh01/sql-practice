-- Xom Data · 3-month consecutive disbursement rate by department
-- Problem: https://xomdata.com/practice/sql-nightmare-003
-- Solved: 2026-08-18

-- WITH roll3 AS (
--     SELECT
--     dept,
--     month,
--     substring(month, 6,2)::int 
--     - ROW_NUMBER() OVER(PARTITION BY dept ORDER BY substring(month, 6,2)::int)
--     AS group_id
-- FROM budgets 
-- )
SELECT
    *,
    ROUND(
        roll3_actual*100.0/roll3_budget
    ,2) utilization_pct 
FROM (
    SELECT
    dept,
    month,
    SUM(budget) OVER(PARTITION BY dept ORDER BY substring(month, 6,2)::int 
                     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) roll3_budget,
    SUM(actual) OVER(PARTITION BY dept ORDER BY substring(month, 6,2)::int 
                     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) roll3_actual
FROM budgets
)T
ORDER BY dept, substring(month, 6,2)::int
