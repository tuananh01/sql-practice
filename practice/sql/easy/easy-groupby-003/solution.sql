-- Xom Data · Average score per class
-- Problem: https://xomdata.com/practice/easy-groupby-003
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    class_name,
    ROUND(AVG(score),2) avg_score 
FROM scores 
GROUP BY class_name
