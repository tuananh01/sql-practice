-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-08-24

SELECT
    *,
    RANK() OVER(PARTITION BY destination_name ORDER BY avg_price DESC) rank_in_destination 
FROM (
    SELECT
    h.hotel_name,
    h.star_class,
    d.destination_name,
    COUNT(r.id) room_count,
    MIN(r.nightly_rate) min_price,
    MAX(r.nightly_rate) max_price,
    ROUND(AVG(r.nightly_rate),0) avg_price,
    (MAX(r.nightly_rate) - MIN(r.nightly_rate)) price_spread
FROM hotels h 
JOIN destinations d 
ON h.destination_id = d.id 
JOIN hotel_rooms r 
ON r.hotel_id = h.id 
GROUP BY 1,2,3
)T
WHERE room_count >= 2
