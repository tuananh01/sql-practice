-- Xom Data · Total shipping fees collected
-- Problem: https://xomdata.com/practice/easy-sum-004
-- Solved: 2026-07-31

SELECT
    SUM(shipping_fee) total_fee 
FROM shipments
