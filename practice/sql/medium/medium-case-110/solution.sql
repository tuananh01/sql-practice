-- Xom Data · Classify products by sales velocity
-- Problem: https://xomdata.com/practice/medium-case-110
-- Solved: 2026-07-31

SELECT
    p.name,
    p.categories,
    t.quantity total_sold,
    CASE WHEN t.quantity >= 100 THEN 'Best Seller'
         WHEN t.quantity >= 50 AND t.quantity < 100 THEN 'Average'
         ELSE 'Slow Mover'
    END classification,
    DENSE_RANK() OVER(PARTITION BY p.categories ORDER BY t.quantity DESC)
        AS rank_in_cat,
    ROUND(t.quantity*1.0 / SUM(t.quantity) OVER(PARTITION BY p.categories)*100,2) 
        AS pct_of_cat_total 
FROM products p
LEFT JOIN (SELECT 
                product_id, 
                SUM(quantity) quantity 
                FROM transactions
                GROUP BY product_id) AS t
ON p.id = t.product_id
ORDER BY p.categories, rank_in_cat, p.name
