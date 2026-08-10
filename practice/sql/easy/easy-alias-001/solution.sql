-- Xom Data · Line total for each item
-- Problem: https://xomdata.com/practice/easy-alias-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    shipment_code,
    product,
    (quantity * unit_price) line_revenue 
FROM shipment_items
