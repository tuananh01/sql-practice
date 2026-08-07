-- Xom Data · Categories full enough for the homepage
-- Problem: https://xomdata.com/practice/easy-having-001
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT 
    category,
    COUNT(id) num_products 
FROM products
GROUP BY 1
HAVING COUNT(id) >= 3
ORDER BY 1
