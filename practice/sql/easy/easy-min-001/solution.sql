-- Xom Data · Cheapest domestic fare
-- Problem: https://xomdata.com/practice/easy-min-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT 
    MIN(price) lowest_price 
FROM flights
WHERE route_type  = 'Domestic'
