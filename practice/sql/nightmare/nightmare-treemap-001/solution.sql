-- Xom Data · Treemap layout: split a 1000×1000 canvas by value ratio
-- Problem: https://xomdata.com/practice/nightmare-treemap-001
-- Solved: 2026-09-19

WITH node_stats AS (
    -- 1. Pre-calculate the proportional ratios and running offsets for every node
    SELECT 
        c.id,
        c.name,
        c.parent_id,
        -- The node's own proportion of its parent's area
        c.value / p.value AS ratio,
        -- The accumulated proportion of all siblings that came before it
        (SUM(c.value) OVER(
            PARTITION BY c.parent_id 
            ORDER BY c.value DESC, c.id ASC 
        ) - c.value) / p.value AS prev_ratio
    FROM categories c
    LEFT JOIN categories p 
        ON c.parent_id = p.id
),
layout AS (
    -- 2. Anchor: The root node occupies the entire 1000x1000 canvas
    SELECT
        id,
        name,
        0.0 AS x,
        0.0 AS y,
        1000.0 AS w,
        1000.0 AS h,
        0 AS depth
    FROM categories
    WHERE parent_id IS NULL

    UNION ALL 

    -- 3. Recursion: Slice and dice based on depth
    SELECT
        n.id,
        n.name,
        -- X Axis: Shift starting point only on even depths (horizontal split)
        CASE WHEN l.depth % 2 = 0 THEN l.x + (l.w * n.prev_ratio) ELSE l.x END AS x,
        -- Y Axis: Shift starting point only on odd depths (vertical split)
        CASE WHEN l.depth % 2 = 1 THEN l.y + (l.h * n.prev_ratio) ELSE l.y END AS y,
        -- Width: Shrink proportional to value on even depths
        CASE WHEN l.depth % 2 = 0 THEN l.w * n.ratio ELSE l.w END AS w,
        -- Height: Shrink proportional to value on odd depths
        CASE WHEN l.depth % 2 = 1 THEN l.h * n.ratio ELSE l.h END AS h,
        l.depth + 1
    FROM node_stats n 
    JOIN layout l 
        ON n.parent_id = l.id 
)
-- 4. Final output: Round to 2 decimals and sort
SELECT 
    id,
    name,
    ROUND(x, 2) AS x,
    ROUND(y, 2) AS y,
    ROUND(w, 2) AS w,
    ROUND(h, 2) AS h
FROM layout
ORDER BY id ASC;
