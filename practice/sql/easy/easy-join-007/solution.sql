-- Xom Data · Deal count per client
-- Problem: https://xomdata.com/practice/easy-join-007
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    c.client_name,
    COUNT(d.id) num_deals 
FROM deals d
JOIN clients c 
ON d.client_id = c.id 
GROUP BY 1
ORDER BY num_deals DESC, 1
