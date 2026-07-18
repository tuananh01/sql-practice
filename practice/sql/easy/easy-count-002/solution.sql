-- Xom Data · Number of delivered orders
-- Problem: https://xomdata.com/practice/easy-count-002
-- Solved: 2026-07-18

SELECT 
    COUNT(id) order_count 
FROM orders
WHERE status = 'Delivered'
