-- Xom Data · Top three sellers per category
-- Problem: https://xomdata.com/practice/medium-topn-002
-- Solved: 2026-10-09

-- Write your SQL here
SELECT 
    category,
    product_name,
    units_sold
FROM (
SELECT 
    category,
    product_name,
    units_sold,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY units_sold DESC, product_name) rnk
FROM menu_sales 
)T
WHERE rnk IN (1, 2, 3)
ORDER BY category, units_sold DESC, product_name
