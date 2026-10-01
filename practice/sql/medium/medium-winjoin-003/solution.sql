-- Xom Data · Each aisle's best seller
-- Problem: https://xomdata.com/practice/medium-winjoin-003
-- Solved: 2026-10-01

-- W8rite your SQL here
SELECT 
    category_name,
    product_name,
    units_sold
    
FROM (
    SELECT 
    c.category_name,
    p.product_name,
    p.units_sold,
    ROW_NUMBER() OVER(PARTITION BY c.category_name ORDER BY p.product_name) alphabet
FROM products p
LEFT JOIN categories c 
ON p.category_id = c.id 
WHERE (p.category_id, p.units_sold) IN (
    SELECT
        category_id,
        MAX(units_sold) 
    FROM products
    GROUP BY 1
)
)t 
WHERE alphabet = 1
