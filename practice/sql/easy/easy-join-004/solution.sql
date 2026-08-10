-- Xom Data · Today's showtimes in time order
-- Problem: https://xomdata.com/practice/easy-join-004
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT 
    s.start_time,
    m.title,
    s.screen
FROM showtimes s 
JOIN movies m 
ON s.movie_id = m.id 
ORDER BY 1, 2
