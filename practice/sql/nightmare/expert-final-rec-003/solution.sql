-- Xom Data · Raw material cost of finished goods (multi-level BoM)
-- Problem: https://xomdata.com/practice/expert-final-rec-003
-- Solved: 2026-08-27


WITH RECURSIVE bom AS (
    -- 1. Base Case: Find the finished products and their immediate ingredients
    SELECT 
        p.id AS product_id,
        p.name,
        i.material_id,
        i.quantity AS converted_qty
    FROM products p
    JOIN ingredients i ON p.id = i.product_id
    WHERE p.id NOT IN (SELECT material_id FROM ingredients)
    
    UNION ALL
    
    -- 2. Recursive Step: Traverse down the hierarchy and multiply the quantities
    SELECT 
        b.product_id,
        b.name,
        i.material_id,
        b.converted_qty * i.quantity AS converted_qty
    FROM bom b
    JOIN ingredients i ON b.material_id = i.product_id
)

-- 3. Bring it together: Filter for leaf nodes and calculate the final cost
SELECT 
    b.product_id,
    b.name,
    SUM(b.converted_qty * p.selling_price) AS total_cost
FROM bom b
JOIN products p ON b.material_id = p.id
WHERE b.material_id NOT IN (SELECT product_id FROM ingredients) -- Ensures leaf-level only
GROUP BY 1, 2
ORDER BY 1;
