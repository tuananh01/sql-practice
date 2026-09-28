-- Xom Data · Median from a frequency distribution
-- Problem: https://xomdata.com/practice/nightmare-median-freq-001
-- Solved: 2026-09-28

WITH number_position AS (
    SELECT 
        number,
        frequency,
        -- Subtract current frequency from the running total, add 1 for standard 1-indexing
        SUM(frequency) OVER(ORDER BY number ASC) - frequency + 1 AS start_position,
        -- The running total is exactly the end position
        SUM(frequency) OVER(ORDER BY number ASC) AS end_position,
        (SELECT SUM(frequency) FROM Numbers) num_elements,
        (SELECT CEIL((SUM(frequency)*1.0 / 2)) FROM Numbers) AS n1_position
    FROM Numbers
    ORDER BY number ASC
)


SELECT 
    CASE WHEN num_elements % 2 != 0 THEN number 
         ELSE AVG(number)
    END median
    
FROM (
    SELECT
    *,
    CASE WHEN  num_elements % 2 != 0 THEN n1_position
         ELSE n1_position + 1
    END n2_position
    FROM number_position
)t
WHERE n1_position BETWEEN start_position AND end_position
OR n2_position BETWEEN start_position AND end_position
