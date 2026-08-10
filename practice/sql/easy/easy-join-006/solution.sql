-- Xom Data · Customers who ever bought skincare
-- Problem: https://xomdata.com/practice/easy-join-006
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT DISTINCT
    c.customer_name 
FROM purchases p 
JOIN customers c
ON p.customer_id = c.id 
WHERE category = 'Skincare'
