-- Xom Data · Users active 5+ consecutive days
-- Problem: https://xomdata.com/practice/nightmare-active-users-001
-- Solved: 2026-09-22

WITH island AS (
    SELECT DISTINCT
        id,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY login_date) island_id,
        julianday(login_date) - ROW_NUMBER() OVER(PARTITION BY id ORDER BY login_date) conse
    FROM Logins
)


SELECT 
    id
FROM island
GROUP BY id, conse 
HAVING COUNT(island_id) >= 5
