-- Xom Data · Line totals from the price list
-- Problem: https://xomdata.com/practice/easy-join-003
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    p.product_name,
    s.quantity,
    (s.quantity * p.price) line_total
FROM sale_items s
JOIN products p
ON p.id = s.product_id
