-- Xom Data · Cumulative revenue and cumulative % of the period total
-- Problem: https://xomdata.com/practice/expert-final-win-008
-- Solved: 2026-08-30

WITH period_revenue AS (
    SELECT
    *,
    SUM(period_revenue) OVER(ORDER BY period) running_total,
    (SELECT SUM(revenue) FROM sales) grand_total
FROM (
    SELECT
        period,
        SUM(revenue) period_revenue
    FROM sales 
    GROUP BY period
)T
)

SELECT
    *,
    ROUND(running_total*100.0/grand_total,1) cumulative_pct 
FROM period_revenue
ORDER BY period
