-- Xom Data · Largest rectangle in histogram
-- Problem: https://xomdata.com/practice/nightmare-histogram-001
-- Solved: 2026-10-09

WITH RECURSIVE rectangle_builder(start_pos, current_pos, min_height) AS (
    -- 1. Base Case
    SELECT 
        pos AS start_pos,
        pos AS current_pos,
        height AS min_height
    FROM bars
    
    UNION ALL
    
    -- 2. Recursive Step
    SELECT 
        r.start_pos,
        b.pos AS current_pos,
        -- PostgreSQL uses LEAST() to compare two scalar values
        LEAST(r.min_height, b.height) AS min_height
    FROM rectangle_builder r
    JOIN bars b 
        ON b.pos = r.current_pos + 1
)
-- 3. Area Calculation
SELECT 
    MAX((current_pos - start_pos + 1) * min_height) AS max_area
FROM rectangle_builder;
