-- Xom Data · Normalize codes for label printing
-- Problem: https://xomdata.com/practice/easy-string-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    sku,
    UPPER(sku) label_code 
FROM inventory
