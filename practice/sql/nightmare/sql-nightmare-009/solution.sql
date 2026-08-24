-- Xom Data · Conversion rate through a 4-step purchase funnel
-- Problem: https://xomdata.com/practice/sql-nightmare-009
-- Solved: 2026-08-24

WITH purchase_funnel AS (
    SELECT
        'visit' AS step,
        1 AS order
    UNION ALL 
    SELECT
        'cart',
        2  
    UNION ALL
    SELECT
        'checkout',
        3 
    UNION ALL 
    SELECT
        'payment',
        4
), 
funnel_info AS (
    SELECT 
    event,
    COUNT(user_id) users,
    ROUND(
        COUNT(user_id)*100.0/(SELECT COUNT(DISTINCT user_id) FROM funnel_events)
    ,2) pct_of_total
FROM funnel_events
GROUP BY event
)

SELECT 
    step,
    users,
    pct_of_total,
    ROUND(
        (users*100.0/prev_step)
    ,2) pct_of_prev 
FROM (
    SELECT
    p.order,
    p.step,
    f.users,
    pct_of_total,
    LAG(f.users) OVER(ORDER BY p.order) prev_step
FROM purchase_funnel p
LEFT JOIN funnel_info f
ON p.step = f.event
ORDER BY p.order
)T
