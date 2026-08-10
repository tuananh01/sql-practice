-- Xom Data · Article URLs from headlines
-- Problem: https://xomdata.com/practice/easy-replace-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    title,
    REPLACE(title, ' ', '-') url_slug 
FROM articles
