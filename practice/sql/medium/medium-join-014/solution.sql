-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-08-14

SELECT 
    *,
    LAG(warehouse_name) OVER(ORDER BY activity_rank) prev_warehouse 
FROM (
    SELECT
    w.warehouse_name,
    COUNT(s.id) import_count,
    COUNT(DISTINCT p.id) distinct_product_count,
    COUNT(DISTINCT s.suppliers) distinct_supplier_count,
    MAX(import_date) last_import_date,
    RANK() OVER(ORDER BY COUNT(s.id) DESC) activity_rank 
FROM stock_imports s 
JOIN warehouses w 
ON s.warehouse_id = w.id 
JOIN products p 
ON p.id = s.product_id
GROUP BY 1
)T
ORDER BY activity_rank, warehouse_name
