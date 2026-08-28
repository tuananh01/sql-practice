-- Xom Data · Multi-level profit margin analysis
-- Problem: https://xomdata.com/practice/hard-multicte-001
-- Solved: 2026-08-28



WITH profit_info AS (
    SELECT 
    *,
    MAX(profit) OVER(PARTITION BY category) AS top_profit
FROM (
     SELECT
    p.category,
    p.name product_name,
    COALESCE(SUM(o.quantity * o.price),0) revenue,
    COALESCE(SUM(o.quantity * p.unit_cost),0) cost,
    COALESCE(SUM((o.quantity * o.price) - (o.quantity * p.unit_cost)),0) profit
FROM products p 
LEFT JOIN orders o 
ON p.id = o.product_id 
GROUP BY 1,2 
)T
)

SELECT
    category,
    product_name,
    revenue,
    cost,
    profit,
    ROUND((profit*100.0/revenue),2) margin_pct,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY profit DESC) rank_in_cat,
    ROUND(profit*100.0/top_profit,2) pct_of_top_in_cat 
FROM profit_info
ORDER BY category, rank_in_cat, product_name
