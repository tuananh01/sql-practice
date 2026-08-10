-- Xom Data · Total spend per member
-- Problem: https://xomdata.com/practice/easy-leftjoin-002
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    m.member_name,
    COALESCE(SUM(b.amount), 0) total_spent 
FROM members m 
LEFT JOIN bills b 
ON m.id = b.member_id 
GROUP BY member_name
ORDER BY 1
