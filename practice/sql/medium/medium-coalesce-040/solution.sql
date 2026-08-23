-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-08-23

WITH genre_info AS (
    SELECT
    g.genre_name,
    COUNT(b.id) book_count,
    ROUND(
        COALESCE(AVG(b.price),0)
     ,2) avg_price,
    COALESCE(MIN(b.price),0)  min_price,
    COALESCE(MAX(b.price), 0) max_price 
FROM genres g
LEFT JOIN books b
ON b.genre_id = g.id  
GROUP BY g.genre_name
)

SELECT
    *,
    (max_price - min_price) price_range, 
    RANK() OVER(ORDER BY book_count DESC) coverage_rank,
    NTILE(3) OVER(ORDER BY book_count DESC, genre_name) library_focus 
FROM genre_info
ORDER BY coverage_rank, genre_name
