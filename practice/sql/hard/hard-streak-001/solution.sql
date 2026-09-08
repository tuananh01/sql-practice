-- Xom Data · Chuỗi tháng ghé đều dài nhất
-- Problem: https://xomdata.com/practice/hard-streak-001
-- Solved: 2026-09-08

WITH monthly_data AS (
    SELECT
        customer_id,
        order_date,
        -- Convert date to a continuous integer (e.g., Year 2024, Month 1 = 24289)
        (CAST(strftime('%Y', order_date) AS INTEGER) * 12) + 
         CAST(strftime('%m', order_date) AS INTEGER) AS absolute_month
    FROM orders
    -- If you are tracking streaks for multiple users, ensure you partition here
),
islands AS (
    SELECT
        customer_id, 
        order_date,
        -- Subtracting the row number groups consecutive months into a single "island_id"
        absolute_month - ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) 
            AS island_id
    FROM monthly_data
)

SELECT
    customer_id,
    MAX(longest_streak) longest_streak
FROM (
    SELECT 
        customer_id,
        COUNT(customer_id) longest_streak
    FROM islands
    GROUP BY island_id, customer_id
)
GROUP BY customer_id
ORDER BY longest_streak DESC, customer_id
