-- Xom Data · Optimal product selection within a weight limit (0/1 knapsack)
-- Problem: https://xomdata.com/practice/nightmare-knapsack-001
-- Solved: 2026-10-08

WITH RECURSIVE 
inventory AS (
    -- 1. Identify the depth of the recursion tree
    SELECT COALESCE(MAX(id), 0) AS max_id 
    FROM items
),
knapsack(current_id, current_weight, current_value, selected_items, binary_path) AS (
    -- 2. Base Case: The empty warehouse before considering any items
    SELECT 
        0, 
        0, 
        0, 
        CAST(NULL AS TEXT), 
        CAST('' AS TEXT)
    
    UNION ALL
    
    -- 3. Branch A: Do NOT pick the current item
    SELECT 
        k.current_id + 1,
        k.current_weight,
        k.current_value,
        k.selected_items,
        '0' || k.binary_path -- Prepend '0' to map the tie-breaker
    FROM knapsack k
    WHERE k.current_id < (SELECT max_id FROM inventory)
    
    UNION ALL
    
    -- 4. Branch B: DO pick the current item
    SELECT 
        k.current_id + 1,
        k.current_weight + i.weight,
        k.current_value + i.value,
        CASE 
            WHEN k.selected_items IS NULL THEN i.name 
            ELSE k.selected_items || ', ' || i.name 
        END,
        '1' || k.binary_path -- Prepend '1' to map the tie-breaker
    FROM knapsack k
    JOIN items i ON i.id = k.current_id + 1
    -- Prune the timeline immediately if picking this item exceeds capacity
    WHERE k.current_id < (SELECT max_id FROM inventory)
      AND k.current_weight + i.weight <= (SELECT capacity FROM constraints)
)
-- 5. Extract the winning combination
SELECT 
    current_value AS best_value,
    current_weight AS used_weight,
    COALESCE(selected_items, '') AS selected_items
FROM knapsack
WHERE current_id = (SELECT max_id FROM inventory)
ORDER BY 
    current_value DESC, 
    binary_path ASC
LIMIT 1;
