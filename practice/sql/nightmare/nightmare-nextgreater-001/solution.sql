-- Xom Data · Next session with a higher price
-- Problem: https://xomdata.com/practice/nightmare-nextgreater-001
-- Solved: 2026-10-06


WITH higher_day AS (
    SELECT 
        p1.day,
        p1.price,
        COALESCE(p2.day, 0) next_higher_day,
        COALESCE(p2.day - p1.day,0) AS days_until 
    FROM prices p1
    LEFT JOIN prices p2
    ON p1.day < p2.day 
    AND p1.price < p2.price
)

SELECT 
    day,
    price,
    NULLIF(next_higher_day, 0) next_higher_day,
    NULLIF(days_until,0) days_until
FROM higher_day
WHERE (day, price, days_until) IN (
    SELECT 
        day,
        price,
        COALESCE(MIN(days_until), 0)
    FROM higher_day
    GROUP BY 1, 2 
)
