-- Xom Data · Suppliers that deliver late frequently
-- Problem: https://xomdata.com/practice/medium-having-162
-- Solved: 2026-08-13

WITH SupplierStats AS (
    SELECT
        s.supplier_name,
        s.material_type,
        COUNT(p.id) AS purchase_count,
        SUM(p.total_value) AS total_purchase_value,
        -- Calculate accurate Julian date differences (e.g.: 2 May  - 30 April)
        -- normal strftime will return negative values
        AVG(julianday(p.actual_receipt) - julianday(p.expected_receipt)) AS avg_late_days,
        SUM(CASE WHEN julianday(p.actual_receipt) <= julianday(p.expected_receipt) THEN 1 ELSE 0 END) AS on_time_count
    FROM suppliers s
    JOIN purchase_orders p 
        ON s.id = p.supplier_id 
    GROUP BY s.id, s.supplier_name, s.material_type
)
SELECT 
    supplier_name,
    material_type,
    purchase_count,
    total_purchase_value,
    ROUND(avg_late_days, 2) AS avg_late_days,
    ROUND((on_time_count * 100.0) / purchase_count, 2) AS on_time_rate,
    RANK() OVER(ORDER BY avg_late_days DESC) AS late_rank,
    NTILE(4) OVER(ORDER BY avg_late_days DESC) AS risk_tier
FROM SupplierStats
WHERE purchase_count >= 3 AND avg_late_days > 0 
ORDER BY late_rank, supplier_name;
