-- Xom Data · Highest-revenue month across the chain
-- Problem: https://xomdata.com/practice/easy-max-001
-- Solved: 2026-07-24

SELECT
    MAX(monthly_revenue) max_revenue
FROM stores
