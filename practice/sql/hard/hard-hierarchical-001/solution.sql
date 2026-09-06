-- Xom Data · Total sales by org branch
-- Problem: https://xomdata.com/practice/hard-hierarchical-001
-- Solved: 2026-09-06


WITH RECURSIVE hierarchy AS (
    -- 1. Anchor Member: Every agent starts as the "root" of their own branch
    SELECT 
        id AS root_id, 
        id AS subordinate_id, 
        direct_sales
    FROM agents
    
    UNION ALL
    
    -- 2. Recursive Member: Find all subordinates under the current branch
    SELECT 
        h.root_id, 
        a.id AS subordinate_id, 
        a.direct_sales
    FROM hierarchy h
    JOIN agents a 
    ON a.manager_id = h.subordinate_id
)


SELECT 
    a.id AS agent_id,
    a.name AS agent_name,
    a.direct_sales,
    SUM(h.direct_sales) AS team_total
FROM agents a
JOIN hierarchy h 
ON a.id = h.root_id
GROUP BY a.id, a.name, a.direct_sales
ORDER BY team_total DESC, agent_id;
