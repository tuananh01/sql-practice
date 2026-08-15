-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-08-15

SELECT
    *,
    FIRST_VALUE(movie_name) OVER(PARTITION BY genres ORDER BY rank_in_genre) 
    AS top_movie_in_genre 
FROM (
    SELECT
        m.movie_name,
        m.genres,
        COUNT(s.id) showtime_count, 
        ROUND(AVG(s.ticket_price),0) avg_ticket_price,
        DENSE_RANK() OVER(PARTITION BY genres ORDER BY ROUND(AVG(s.ticket_price),0) DESC) 
            AS rank_in_genre
    FROM movies m 
    JOIN showtimes s 
    ON m.id = s.movie_id
    GROUP BY 1, 2
)T
ORDER BY genres, rank_in_genre, movie_name
