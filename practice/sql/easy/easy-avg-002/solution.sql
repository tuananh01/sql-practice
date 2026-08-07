-- Xom Data · The cafe's average rating
-- Problem: https://xomdata.com/practice/easy-avg-002
-- Solved: 2026-08-07

SELECT
    ROUND(AVG(rating),2) avg_rating
FROM reviews
