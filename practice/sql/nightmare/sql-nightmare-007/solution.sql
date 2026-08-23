-- Xom Data · Inventory value using FIFO
-- Problem: https://xomdata.com/practice/sql-nightmare-007
-- Solved: 2026-08-23


WITH Demand AS (
    -- Safely sum all demand, defaulting to 0 if the table is empty
    SELECT COALESCE(SUM(demand_qty), 0) AS total_demand
    FROM sales_demand
),
RunningInventory AS (
    SELECT 
        batch_id,
        batch_date,
        quantity,
        unit_cost,
        -- Break ties using batch_id
        SUM(quantity) OVER(ORDER BY batch_date, batch_id) AS running_qty,
        (SELECT total_demand FROM Demand) AS total_demand
    FROM inventory
)
SELECT 
    batch_id,
    batch_date,
    -- LEAST() returns the smallest value from a list of two or more expressions.
    -- LEAST() automatically handles partial vs completely untouched batches
    LEAST(quantity, running_qty - total_demand) AS remaining_qty,
    unit_cost,
    LEAST(quantity, running_qty - total_demand) * unit_cost AS remaining_value
FROM RunningInventory
-- Filter out batches that were completely consumed
WHERE running_qty > total_demand
ORDER BY batch_date, batch_id
