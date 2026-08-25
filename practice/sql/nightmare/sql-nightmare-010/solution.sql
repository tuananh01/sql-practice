-- Xom Data · TWAP per stock symbol
-- Problem: https://xomdata.com/practice/sql-nightmare-010
-- Solved: 2026-08-25

WITH TickIntervals AS (
    SELECT 
        symbol,
        price,
        -- Calculate the exact duration in seconds between the current and next quote
        unixepoch(LEAD(tick_time) OVER(PARTITION BY symbol ORDER BY tick_time)) - 
        unixepoch(tick_time) AS duration
    FROM price_ticks
)
SELECT 
    symbol,
    -- (Sum of weighted prices) / (Total time duration)
    ROUND((SUM(price * duration)*1.0 / SUM(duration)), 4) AS twap
FROM TickIntervals
WHERE duration IS NOT NULL -- This safely drops the final quote
GROUP BY symbol
ORDER BY symbol;
