-- Xom Data · Detect anomalous days vs the average
-- Problem: https://xomdata.com/practice/hard-anomaly-001
-- Solved: 2026-08-29

WITH Stats AS (
    -- 1. Calculate overall mean and stddev using window functions
    SELECT 
        date,
        value,
        -- Casting to numeric prevents integer division truncation in some dialects
        ROUND(AVG(value::numeric) OVER(), 2) AS mean,
        ROUND(STDDEV_POP(value::numeric) OVER(), 2) AS stddev
    FROM daily_metrics
),
ZScores AS (
    -- 2. Safely calculate the z_score, preventing division by zero
    SELECT 
        *,
        CASE 
            WHEN stddev = 0 THEN 0
            ELSE ROUND((value - mean) / stddev, 2)
        END AS z_score
    FROM Stats
)
-- 3. Assign the final flag based on the calculated z_score
SELECT 
    date,
    value,
    mean,
    stddev,
    z_score,
    CASE 
        WHEN z_score > 2 THEN 'high'
        WHEN z_score < -2 THEN 'low'
        ELSE 'normal'
    END AS flag
FROM ZScores
ORDER BY date;
