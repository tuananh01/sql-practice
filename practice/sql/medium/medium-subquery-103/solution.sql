-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-08-18

SELECT
    product_name,
    category,
    price,
    (price - avg_price) diff_from_avg,
    ROUND (
        (price - avg_price)*100.0/avg_price
    ,2) pct_above 
FROM (
    SELECT
        product_name,
        category,
        price,
        AVG(price) OVER(PARTITION BY category) avg_price
    FROM products 
)T
WHERE price > avg_price
ORDER BY pct_above DESC, product_name
