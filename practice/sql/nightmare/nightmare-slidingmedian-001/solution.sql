-- Xom Data · Centered 5-session rolling median price per session
-- Problem: https://xomdata.com/practice/nightmare-slidingmedian-001
-- Solved: 2026-09-25

WITH windowed_prices AS (
    -- 1. Create a strict logical window to handle gaps (like weekends/holidays)
    SELECT 
        p1.day AS target_day,
        p2.price AS window_price
    FROM prices p1
    JOIN prices p2 
        ON p2.day BETWEEN p1.day - 2 AND p1.day + 2
    WHERE p2.price IS NOT NULL
),
ranked_sessions AS (
    -- 2. Rank the valid prices within each specific day's logical window
    SELECT
        target_day,
        window_price,
        ROW_NUMBER() OVER(PARTITION BY target_day ORDER BY window_price ASC) AS rn,
        COUNT(window_price) OVER(PARTITION BY target_day) AS total_valid
    FROM windowed_prices
)
-- 3. Average the middle value(s), round, and sort
SELECT
    target_day AS day,
    ROUND(AVG(window_price), 2) AS median_price
FROM ranked_sessions
WHERE rn IN ((total_valid + 1) / 2, (total_valid + 2) / 2)
GROUP BY target_day
ORDER BY target_day ASC;
