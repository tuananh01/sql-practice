-- Xom Data · Advertiser status by month (4 states)
-- Problem: https://xomdata.com/practice/nightmare-statemachine-001
-- Solved: 2026-09-09

WITH RECURSIVE monthly_activity AS (
    -- 1. Anchor: Start at the advertiser's first month, end at the GLOBAL max month
    SELECT 
        advertiser_id,
        date(MIN(month || '-01')) AS month_start,
        (SELECT date(MAX(month || '-01')) FROM advertiser_activity) AS max_month
    FROM advertiser_activity
    GROUP BY advertiser_id
    
    UNION ALL 
    
    -- 2. Recursion: Build the spine
    SELECT 
        advertiser_id,
        date(month_start, '+1 month'),
        max_month
    FROM monthly_activity
    WHERE month_start < max_month
),
activity_flags AS (
    -- 3. Convert the JOIN into simple binary flags (1 = Active, 0 = Inactive)
    SELECT
        m.advertiser_id,
        strftime('%Y-%m', m.month_start) AS month,
        CASE WHEN a.month IS NOT NULL THEN 1 ELSE 0 END AS is_active
    FROM monthly_activity m 
    LEFT JOIN advertiser_activity a 
        ON a.advertiser_id = m.advertiser_id
        AND a.month = strftime('%Y-%m', m.month_start)
),
state_classification AS (
    -- 4. Check the previous month's binary flag
    SELECT 
        advertiser_id,
        month,
        is_active,
        LAG(is_active) OVER(PARTITION BY advertiser_id ORDER BY month) AS prev_active
    FROM activity_flags
)
-- 5. Map combinations to states and filter out the nulls
SELECT 
    advertiser_id,
    month,
    CASE 
        WHEN is_active = 1 AND prev_active IS NULL THEN 'NEW'
        WHEN is_active = 1 AND prev_active = 1 THEN 'EXISTING'
        WHEN is_active = 0 AND prev_active = 1 THEN 'CHURN'
        WHEN is_active = 1 AND prev_active = 0 THEN 'RESURRECT'
    END AS state
FROM state_classification
WHERE state IS NOT NULL 
ORDER BY advertiser_id, month;
