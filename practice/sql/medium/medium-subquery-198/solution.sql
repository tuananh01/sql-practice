-- Xom Data · Top 10 most-borrowed books
-- Problem: https://xomdata.com/practice/medium-subquery-198
-- Solved: 2026-08-26

WITH book_cnt AS (
    SELECT
        book_id,
        COUNT(id) borrow_count
    FROM book_loans
    GROUP BY book_id
)

SELECT
    *,
    (borrow_count + pending_reservation) engagement,
    DENSE_RANK() OVER(ORDER BY  (borrow_count + pending_reservation) DESC) overall_rank,
    RANK() OVER(PARTITION BY genre_name ORDER BY (borrow_count + pending_reservation) DESC)
        AS rank_in_genre 
FROM (
    SELECT 
    b.title,
    a.full_name authors,
    p.publisher_name,
    g.genre_name,
    bl.borrow_count,
    SUM(CASE WHEN r.status = 'ready_pickup' THEN 1 ELSE 0 END) pending_reservation
FROM books b 
JOIN authors a 
ON b.author_id = a.id 
LEFT JOIN publishers p
ON b.publisher_id = p.id 
LEFT JOIN genres g 
ON b.genre_id = g.id 
LEFT JOIN book_cnt bl 
ON b.id = bl.book_id
LEFT JOIN reservations r 
ON b.id = r.book_id
GROUP BY 1, 2, 3, 4, 5
)t
ORDER BY overall_rank, title
LIMIT 10
