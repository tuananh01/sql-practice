-- Xom Data · Merge overlapping bookings into continuous ranges
-- Problem: https://xomdata.com/practice/nightmare-interval-merge-001
-- Solved: 2026-09-15

WITH running_ends AS (
    -- 1. Track the maximum end time seen so far for each room
    SELECT 
        id,
        room_id,
        start_at,
        end_at,
        MAX(end_at) OVER(
            PARTITION BY room_id 
            ORDER BY start_at, end_at 
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS prev_max_end
    FROM bookings
),
islands AS (
    -- 2. Create a unique ID for each continuous block
    SELECT 
        *,
        SUM(CASE WHEN prev_max_end IS NULL OR start_at > prev_max_end THEN 1 ELSE 0 END) OVER(
            PARTITION BY room_id 
            ORDER BY start_at, end_at
        ) AS island_id
    FROM running_ends
)

-- 3. Aggregate the continuous blocks
SELECT 
    room_id,
    MIN(start_at) AS merged_start,
    MAX(end_at) AS merged_end,
    COUNT(id) AS n_bookings,
    CAST((strftime('%s', MAX(end_at)) - strftime('%s', MIN(start_at))) / 60 AS INTEGER) AS duration_min
FROM islands
GROUP BY 
    room_id, 
    island_id
ORDER BY 
    room_id, 
    merged_start;
