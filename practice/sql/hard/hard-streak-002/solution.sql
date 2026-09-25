-- Xom Data · Ai đang giữ phong độ đến tận hôm nay
-- Problem: https://xomdata.com/practice/hard-streak-002
-- Solved: 2026-09-25

WITH monthly_activity AS (
    -- 1. Flatten the data (1 row per active month) and calculate the absolute month integer
    SELECT DISTINCT
        customer_id,
        strftime('%Y-%m', order_date) AS active_month,
        (CAST(strftime('%Y', order_date) AS INTEGER) * 12) + 
         CAST(strftime('%m', order_date) AS INTEGER) AS abs_month
    FROM orders
),
islands AS (
    -- 2. Build the islands using the absolute month integer
    SELECT 
        customer_id,
        active_month,
        abs_month - ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY abs_month) AS island_id
    FROM monthly_activity
),
current_streak_islands AS (
    -- 3. Isolate only the specific island IDs that contain the current month (2024-06)
    SELECT customer_id, island_id
    FROM islands
    WHERE active_month = '2024-06'
)
-- 4. Count the length of those specific islands and sort
SELECT 
    i.customer_id,
    COUNT(i.active_month) AS current_streak
FROM islands i
JOIN current_streak_islands c 
    ON i.customer_id = c.customer_id 
    AND i.island_id = c.island_id
GROUP BY i.customer_id, i.island_id
ORDER BY current_streak DESC, i.customer_id ASC
