-- Xom Data · Products in a price range
-- Problem: https://xomdata.com/practice/easy-between-001
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    product_name,
    price
FROM products 
WHERE price BETWEEN 200 AND 500
