-- Xom Data · Employee levels in the org chart
-- Problem: https://xomdata.com/practice/sql-nightmare-005
-- Solved: 2026-08-21

WITH hierachy AS (
    SELECT
        id,
        name,
        1 AS depth
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT 
        e.id,
        e.name,
        depth + 1
    FROM employees e
    JOIN hierachy h
    ON e.manager_id = h.id 
)
SELECT * FROM hierachy
ORDER BY id
