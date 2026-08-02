-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-08-02

WITH summary AS (
    SELECT
    'Complaint' type,
    COUNT(id) quantity
FROM complaints 
WHERE status = 'Pending'
UNION ALL
SELECT
    'Cancelled Order',
    COUNT(id)
FROM orders 
WHERE status = 'Cancelled'
UNION ALL 
SELECT 
    'Out of Stock Product',
    COUNT(id)
FROM products 
WHERE status = 'Out of Stock'
ORDER BY type
)

SELECT
    type,
    quantity,
    pct_of_total,
    rank_pos,
    ROUND(SUM(pct_raw) OVER(ORDER BY pct_of_total DESC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) cumulative_pct 
FROM (
    SELECT
    type,
    quantity,
    quantity*100.0/SUM(quantity) OVER() pct_raw,
    ROUND(quantity*100.0/SUM(quantity) OVER(),2) pct_of_total,
    RANK() OVER(ORDER BY quantity DESC) rank_pos

FROM summary
)T
ORDER BY rank_pos, type
