-- Xom Data · Top 10 highest-profit dishes
-- Problem: https://xomdata.com/practice/medium-agg-147
-- Solved: 2026-09-29


SELECT 
    *,
    ROUND(profit*100.0/revenue,2) margin_pct,
    RANK() OVER(ORDER BY profit DESC) rank_by_profit,
    RANK() OVER(ORDER BY ROUND(profit*100.0/revenue,2) DESC) rank_by_margin 
FROM (
    SELECT 
    d.dish_name,
    c.category_name,
    SUM(o1.quantity) total_sold,
    SUM(o1.quantity * o1.unit_price) AS revenue,
    SUM(o1.quantity * (o1.unit_price-d.cost_price)) AS profit
FROM order_items o1 
LEFT JOIN dishes d 
ON o1.dish_id = d.id 
LEFT JOIN categories c 
ON c.id = d.category_id
JOIN orders o2
ON o1.order_id = o2.id
WHERE o2.status = 'Completed'
GROUP BY 1, 2
 
)T
ORDER BY profit DESC, dish_name
LIMIT 10
