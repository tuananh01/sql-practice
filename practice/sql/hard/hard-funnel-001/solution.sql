-- Xom Data · 4-step onboarding conversion rate
-- Problem: https://xomdata.com/practice/hard-funnel-001
-- Solved: 2026-09-03

WITH steps AS (
    SELECT 
        'signup' AS step,
        1 AS orders
    UNION ALL 
    SELECT 
        'verify_email',
        2
    UNION ALL
    SELECT
        'first_login',
        3 
    UNION ALL
    SELECT
        'first_purchase',
        4
)

SELECT
    s.step,
    COUNT(DISTINCT e.user_id) n_users,
    COALESCE(ROUND(
        COUNT(DISTINCT e.user_id)*100.0/(SELECT COUNT(user_id) FROM events WHERE event_name = 'signup')
    ,2),0) conversion_pct 
FROM steps s 
LEFT JOIN events e 
ON s.step = e.event_name 
GROUP BY s.step
ORDER BY s.orders
