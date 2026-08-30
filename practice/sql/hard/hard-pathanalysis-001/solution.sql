-- Xom Data · Most common 3-step user path
-- Problem: https://xomdata.com/practice/hard-pathanalysis-001
-- Solved: 2026-08-30

WITH path_sequences AS (
    SELECT 
        user_id,
        page || ' > ' || 
        LEAD(page, 1) OVER(PARTITION BY user_id ORDER BY viewed_at) || ' > ' || 
        LEAD(page, 2) OVER(PARTITION BY user_id ORDER BY viewed_at) AS path,
        LEAD(page, 2) OVER(PARTITION BY user_id ORDER BY viewed_at) AS page_3
    FROM page_views
)
SELECT 
    path,
    COUNT(DISTINCT user_id) AS n_users
FROM path_sequences
-- This safely filters out the final two page views of any user's session, 
-- which cannot mathematically form a 3-page sequence.
WHERE page_3 IS NOT NULL 
GROUP BY path
ORDER BY n_users DESC, path ASC
LIMIT 10
