-- Xom Data · Còn quay lại trong tuần kế tiếp không
-- Problem: https://xomdata.com/practice/hard-retention-003
-- Solved: 2026-09-27

WITH absolute_weeks AS (
    -- 1. Calculate the continuous absolute week for every order
    SELECT 
        customer_id,
        CAST((julianday(order_date) - julianday('2024-01-01')) / 7 AS INTEGER) + 1 AS week
    FROM orders
),
cohort_assignment AS (
    -- 2. Lock in the first purchase week for each customer
    SELECT 
        customer_id,
        MIN(week) AS cohort_week
    FROM absolute_weeks
    GROUP BY customer_id
)

-- 3. Join the history back to the cohorts and count distinct hits
SELECT 
    c.cohort_week,
    COUNT(DISTINCT c.customer_id) AS cohort_size,
    COUNT(DISTINCT CASE WHEN w.week = c.cohort_week + 1 THEN c.customer_id END) AS retained_next_week
FROM cohort_assignment c
LEFT JOIN absolute_weeks w 
    ON c.customer_id = w.customer_id
GROUP BY c.cohort_week
ORDER BY c.cohort_week ASC;
