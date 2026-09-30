-- Xom Data · Nhịp rời mạng của thuê bao theo tháng
-- Problem: https://xomdata.com/practice/hard-churn-004
-- Solved: 2026-09-30

WITH target_months AS (
    -- 1. Identify the anchor timeline: only months where at least one sub ended
    SELECT DISTINCT 
        strftime('%Y-%m', end_date) AS month_str,
        DATE(end_date, 'start of month') AS first_day
    FROM subscriptions
    WHERE end_date IS NOT NULL
)
SELECT 
    t.month_str AS month,
    -- 2. Count subs active strictly before the 1st, and ending on/after the 1st (or never)
    SUM(CASE 
        WHEN s.start_date < t.first_day AND (s.end_date IS NULL OR s.end_date >= t.first_day) 
        THEN 1 ELSE 0 
    END) AS active_at_start,
    -- 3. Count subs that ended in this specific month
    SUM(CASE 
        WHEN strftime('%Y-%m', s.end_date) = t.month_str 
        THEN 1 ELSE 0 
    END) AS ended_subs,
    -- 4. Calculate churn, using NULLIF to prevent division-by-zero errors
    ROUND(
        SUM(CASE WHEN strftime('%Y-%m', s.end_date) = t.month_str THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(SUM(CASE WHEN s.start_date < t.first_day AND (s.end_date IS NULL OR s.end_date >= t.first_day) THEN 1 ELSE 0 END), 0)
    , 2) AS churn_rate_pct
FROM target_months t
-- 5. Join only the subscriptions that mathematically contribute to this month's metrics
JOIN subscriptions s
    ON (s.start_date < t.first_day AND (s.end_date IS NULL OR s.end_date >= t.first_day))
    OR strftime('%Y-%m', s.end_date) = t.month_str
GROUP BY t.month_str
ORDER BY t.month_str ASC;
