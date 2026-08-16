-- Xom Data · Investor trade summary
-- Problem: https://xomdata.com/practice/medium-agg-137
-- Solved: 2026-08-16

-- Summarize buy/sell totals per investor
WITH investors_stat AS (
  SELECT
    i.full_name,
    i.segment,
    COUNT(t.id) total_trades,
    SUM(CASE WHEN t.side = 'buy' THEN amount ELSE 0 END) total_bought,
    SUM(CASE WHEN t.side = 'sell' THEN amount ELSE 0 END) total_sold

  FROM investors i
  JOIN trades t 
  ON t.investor_id = i.id
  GROUP BY 1, 2
)


  SELECT
    *,
    (total_bought - total_sold) net_position,
    CASE WHEN total_bought > total_sold THEN 'Bull'
        WHEN total_sold > total_bought THEN 'Bear'
        ELSE 'Neutral'
    END stance,
    DENSE_RANK() OVER(PARTITION BY segment ORDER BY (total_bought + total_sold) DESC) 
      AS rank_in_segment 
FROM investors_stat
ORDER BY (total_bought + total_sold) DESC, full_name
