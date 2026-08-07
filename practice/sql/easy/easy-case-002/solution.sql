-- Xom Data · Sizing parcels by weight
-- Problem: https://xomdata.com/practice/easy-case-002
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT 
    parcel_code,
    weight_kg,
    CASE WHEN weight_kg < 5 THEN 'Small'
         WHEN weight_kg BETWEEN 5 AND 20 THEN 'Medium'
         ELSE 'Large'
    END size_label 
FROM parcels
