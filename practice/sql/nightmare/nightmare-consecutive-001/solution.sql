-- Xom Data · Numbers appearing 3 times in a row in the log
-- Problem: https://xomdata.com/practice/nightmare-consecutive-001
-- Solved: 2026-09-24

WITH island AS (
    SELECT
        num,
        id - ROW_NUMBER() OVER(PARTITION BY num ORDER BY id) island_id
    FROM Logs 
)

SELECT DISTINCT
    num AS consecutive_num 
FROM island
GROUP BY island_id
HAVING COUNT(num) >= 3
ORDER BY 1
