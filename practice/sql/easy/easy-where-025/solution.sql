-- Xom Data · Heavy shipments
-- Problem: https://xomdata.com/practice/easy-where-025
-- Solved: 2026-07-31

SELECT
    waybill_code,
    weight_kg,
    shipping_fee
FROM shipments
WHERE weight_kg > 3
ORDER BY weight_kg DESC
