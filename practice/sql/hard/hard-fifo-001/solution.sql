-- Xom Data · Running inventory balance over time
-- Problem: https://xomdata.com/practice/hard-fifo-001
-- Solved: 2026-09-05

SELECT 
    sku,
    occurred_at,
    type,
    quantity,
    SUM(CASE WHEN type = 'OUT' THEN -(quantity) ELSE quantity END) 
        OVER(PARTITION BY sku ORDER BY sku, occurred_at, id) running_balance 

FROM inventory_movements
