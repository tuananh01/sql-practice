-- Xom Data · Ticket statuses guests can read
-- Problem: https://xomdata.com/practice/easy-join-005
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    t.ticket_code,
    s.status_name
FROM tickets t 
JOIN statuses s 
ON t.status_code = s.code
