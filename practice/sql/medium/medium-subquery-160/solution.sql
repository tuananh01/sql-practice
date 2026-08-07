-- Xom Data · Low-activity users
-- Problem: https://xomdata.com/practice/medium-subquery-160
-- Solved: 2026-08-06

-- SELECT
--     user_name,
--     order_count,
--     total_value,
--     avg_order_value,
--     CASE WHEN total_value IS NULL THEN 'Inactive'
--          WHEN total_value < (SELECT AVG(value) avg_value FROM orders) THEN 'Low'
--          ELSE 'Normal'
--     END tier,
--     RANK() OVER(ORDER BY order_count) activity_rank,
--     ROUND((PERCENT_RANK() OVER(ORDER BY COALESCE(total_value, 0))) * 100.0, 2) 
--         AS pct_above_peers
-- FROM (
--     SELECT
--     u.user_name,
--     COUNT(o.id) order_count,
--     SUM(o.value) total_value,
--     AVG(o.value) avg_order_value 
-- FROM users u
-- LEFT JOIN  orders o 
-- ON o.user_id = u.id 
-- GROUP BY u.user_name
-- HAVING COUNT(o.id) = 0 
-- OR SUM(o.value) < (SELECT AVG(value) avg_value FROM orders) 
-- )T
-- ORDER BY activity_rank, user_name


WITH UserTotals AS (
    -- Step 1: Calculate the total value for EVERY user
    SELECT
        u.user_name,
        COUNT(o.id) AS order_count,
        SUM(o.value) AS total_value,
        AVG(o.value) AS avg_order_value 
    FROM users u
    LEFT JOIN orders o 
        ON o.user_id = u.id 
    GROUP BY u.user_name
)
-- Step 3: Window functions automatically calculate ONLY against the filtered rows
SELECT
    user_name,
    order_count,
    total_value,
    avg_order_value,
    CASE 
        WHEN total_value IS NULL THEN 'Inactive'
        ELSE 'Low'
    END AS tier,
    RANK() OVER(ORDER BY COALESCE(total_value, 0)) AS activity_rank,
    ROUND((PERCENT_RANK() OVER(ORDER BY COALESCE(total_value, 0))) * 100.0, 2) AS pct_above_peers
FROM UserTotals
-- Step 2: Filter for Inactive and Low users first
WHERE total_value IS NULL 
   OR total_value < (SELECT AVG(COALESCE(total_value, 0)) FROM UserTotals)
ORDER BY activity_rank, user_name;
