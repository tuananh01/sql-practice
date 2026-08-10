-- Xom Data · Booking count per branch
-- Problem: https://xomdata.com/practice/easy-leftjoin-003
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    br.branch_name,
    COALESCE(COUNT(bo.id),0) num_bookings 
FROM branches br 
LEFT JOIN bookings bo 
ON br.id = bo.branch_id 
GROUP BY 1
ORDER BY 1
