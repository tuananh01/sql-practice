-- Xom Data · Revenue split by new vs returning customers
-- Problem: https://xomdata.com/practice/sql-nightmare-006
-- Solved: 2026-08-22

WITH UserStats AS (
    -- 1. Get monthly totals and peek at the user's past and future
    SELECT 
        user_id,
        month,
        SUM(revenue) AS monthly_rev,
        MIN(month) OVER(PARTITION BY user_id) AS first_month,
        LEAD(month) OVER(PARTITION BY user_id ORDER BY month) AS next_buy_month
    FROM sales
    GROUP BY user_id, month
),
RevenueSplit AS (
    -- 2. Classify New vs Returning revenue for the current month
    SELECT 
        month,
        SUM(CASE WHEN month = first_month THEN monthly_rev ELSE 0 END) AS new_revenue,
        SUM(CASE WHEN month > first_month THEN monthly_rev ELSE 0 END) AS returning_revenue
    FROM UserStats
    GROUP BY month
),
ChurnSplit AS (
    -- 3. Project churn forward to the immediate next month
    SELECT 
        to_char((month || '-01')::date + interval '1 month', 'YYYY-MM') AS target_month,
        SUM(monthly_rev) AS churned_revenue
    FROM UserStats
    WHERE next_buy_month IS DISTINCT FROM to_char((month || '-01')::date + interval '1 month', 'YYYY-MM')
    --IS DISTINCT FROM: Treat NULL as a concrete value that can be compared
    GROUP BY 1
)
-- 4. Bring it all together
SELECT 
    r.month,
    r.new_revenue,
    r.returning_revenue,
    COALESCE(c.churned_revenue, 0) AS churned_revenue
FROM RevenueSplit r
LEFT JOIN ChurnSplit c 
    ON r.month = c.target_month
ORDER BY r.month;
