-- Xom Data · Tickets still valid
-- Problem: https://xomdata.com/practice/easy-count-010
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    COUNT(id) valid_tickets 
FROM tickets 
WHERE status = 'Valid'
