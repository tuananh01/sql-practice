-- Xom Data · Minimum coins to make the target amount (unlimited denominations)
-- Problem: https://xomdata.com/practice/nightmare-coinchange-001
-- Solved: 2026-09-10

WITH RECURSIVE max_target AS (
    -- Find the ceiling so the recursion knows exactly when to stop
    SELECT MAX(amount) AS max_amt FROM target
),
change_combinations AS (
    -- 1. Anchor: 0 amount takes 0 coins
    SELECT 0 AS current_amount, 0 AS coin_count
    
    UNION
    
    -- 2. Recursion: Add one coin of any denomination to the current amount
    SELECT 
        c.current_amount + v.value, 
        c.coin_count + 1
    FROM change_combinations c
    CROSS JOIN coins v
    CROSS JOIN max_target m
    WHERE c.current_amount + v.value <= m.max_amt
)
-- 3. Find the minimum coins for the specific target
SELECT 
    t.amount AS target,
    COALESCE(MIN(c.coin_count), -1) AS min_coins
FROM target t
LEFT JOIN change_combinations c 
    ON t.amount = c.current_amount
GROUP BY 
    t.amount;
