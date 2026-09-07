-- Xom Data · Monthly recurring revenue (MRR) by subscription plan
-- Problem: https://xomdata.com/practice/hard-mrr-001
-- Solved: 2026-09-07

WITH RECURSIVE date_spine AS (
    -- 1. Anchor: Find the very first day of the earliest month
    SELECT date(MIN(started_at), 'start of month') AS month_start,
           date(MAX(started_at), 'start of month') AS max_month
    FROM subscriptions
    
    UNION ALL
    
    -- 2. Recursion: Add 1 month sequentially until hitting the max month
    SELECT date(month_start, '+1 month'),
           max_month
    FROM date_spine
    WHERE month_start < max_month
),
eom_dates AS (
    -- 3. Format the output string and calculate the exact Last Day of the month
    SELECT 
        strftime('%Y-%m', month_start) AS month,
        date(month_start, '+1 month', '-1 day') AS eom_date
    FROM date_spine
)
-- 4. Evaluate ALL subscriptions against EVERY generated end-of-month date
SELECT 
    e.month,
    COUNT(s.user_id) AS active_subs,
    COALESCE(SUM(s.mrr), 0) AS total_mrr
FROM eom_dates e
LEFT JOIN subscriptions s
    ON s.started_at <= e.eom_date
    AND (s.ended_at IS NULL OR s.ended_at > e.eom_date)
GROUP BY e.month
ORDER BY e.month;
