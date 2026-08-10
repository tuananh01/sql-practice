-- Xom Data · Users who never took a ride
-- Problem: https://xomdata.com/practice/easy-leftjoin-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT 
    u.user_name,
    u.joined_date
FROM users u 
LEFT JOIN  rides r
ON r.user_id = u.id 
WHERE r.id IS NULL
