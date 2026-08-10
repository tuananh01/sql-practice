-- Xom Data · Parcels bound for Da Nang
-- Problem: https://xomdata.com/practice/easy-join-002
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT 
    p.tracking_code,
    r.recipient_name
FROM parcels p  
JOIN recipients r 
ON p.recipient_id  = r.id
WHERE r.city = 'Da Nang'
