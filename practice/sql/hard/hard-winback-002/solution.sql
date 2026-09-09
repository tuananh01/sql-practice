-- Xom Data · Đếm những sự trở lại mỗi tháng
-- Problem: https://xomdata.com/practice/hard-winback-002
-- Solved: 2026-09-09

WITH monthly_activity AS (
    -- 1. Get distinct active months per user and flatten the calendar into integers
    SELECT DISTINCT
        customer_id,
        strftime('%Y-%m', order_date) AS month_str,
        (CAST(strftime('%Y', order_date) AS INTEGER) * 12) + 
         CAST(strftime('%m', order_date) AS INTEGER) AS abs_month
    FROM orders
),
lagged_activity AS (
    -- 2. Fetch the exact previous active month for that specific user
    SELECT
        customer_id,
        month_str,
        abs_month,
        LAG(abs_month) OVER(PARTITION BY customer_id ORDER BY abs_month) AS prev_abs_month
    FROM monthly_activity
)
-- 3. Filter for gaps of 3 or more months (which equals 2 full months of silence)
SELECT
    month_str AS month,
    COUNT(customer_id) AS resurrected_customers
FROM lagged_activity
WHERE abs_month - prev_abs_month >= 3
GROUP BY month_str
ORDER BY month_str;
