-- Xom Data · Revenue from delivered orders
-- Problem: https://xomdata.com/practice/easy-sum-001
-- Solved: 2026-07-31

SELECT
    SUM(total_amount) total_revenue 
FROM orders 
WHERE status = 'Delivered'
