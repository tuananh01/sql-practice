-- Xom Data · Portfolio profit/loss
-- Problem: https://xomdata.com/practice/medium-casewhen-047
-- Solved: 2026-08-03

SELECT
    stock_code,
    stock_quantity,
    avg_cost_price,
    current_price,
    profit_loss,
    profit_pct,
    CASE WHEN profit_pct > 10 THEN 'Strong Gain'
         WHEN profit_pct > 0 AND profit_pct <= 10 THEN 'Mild Gain'
         WHEN profit_pct = 0 THEN 'Break Even'
         WHEN profit_pct > (-10) AND profit_pct < 0 THEN 'Mild Loss'
         ELSE 'Strong Loss'
    END status,
    RANK() OVER(ORDER BY profit_pct DESC) rank_by_pct,
    SUM(invested) OVER(ORDER BY profit_pct DESC, stock_code) cumulative_invested 
FROM (
    SELECT
    s.stock_code,
    c.stock_quantity,
    c.avg_cost_price,
    s.current_price,
    (s.current_price-c.avg_cost_price)*c.stock_quantity AS profit_loss,
    ROUND((s.current_price - c.avg_cost_price)/c.avg_cost_price*100.0,2) profit_pct,
    c.avg_cost_price*c.stock_quantity AS invested
FROM stocks s
JOIN categories c 
ON s.id = c.stock_id
)T
ORDER BY rank_by_pct, stock_code
