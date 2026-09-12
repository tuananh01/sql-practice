-- Xom Data · Three-level sales totals: detail, by region, company-wide
-- Problem: https://xomdata.com/practice/expert-final-mix-009
-- Solved: 2026-09-12


WITH null_holder AS (
    SELECT
        region,
        NULL AS room
    FROM sales 
    GROUP BY 1
),
null_room AS (
    SELECT
        id, 
        region,
        room
    FROM sales 
    UNION ALL
    SELECT
        0, 
        *
    FROM null_holder

), region_room AS (
    SELECT
        n.region,
        n.room,
        SUM(s.revenue) total_sales 
    FROM null_room n
    LEFT JOIN sales s 
    ON s.id = n.id
    GROUP BY 1, 2
    ORDER BY n.region, n.room NULLS LAST
)

SELECT 
   region,
   room,
   CASE WHEN total_sales IS NULL 
        THEN SUM(total_sales) OVER(PARTITION BY region ORDER BY region ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        ELSE total_sales
   END AS total_sales
FROM region_room 

UNION ALL 

SELECT 
    NULL,
    NULL,
    (SELECT SUM(total_sales) FROM region_room)
