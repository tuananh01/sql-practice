-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-08-14

WITH post_stats AS (
    SELECT
    u.full_name,
    p.post_type,
    p.post_date,
    (p.like_count + p.share_count + p.comment_count) total_interactions, 
    RANK() OVER(ORDER BY (p.like_count + p.share_count + p.comment_count) DESC) overall_rank
FROM posts p
JOIN users u
ON p.user_id = u.id 
)

SELECT 
    *,
    ROW_NUMBER() OVER(PARTITION BY full_name ORDER BY total_interactions DESC, post_date)
        AS rank_in_author,
    ROUND (
        total_interactions*100.0/(SELECT MAX(total_interactions) FROM post_stats)
    ,2) pct_of_top 
FROM post_stats
ORDER BY overall_rank, full_name, rank_in_author 
LIMIT 10
