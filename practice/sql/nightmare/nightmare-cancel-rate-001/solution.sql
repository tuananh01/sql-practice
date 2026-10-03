-- Xom Data · Daily trip cancellation rate (unbanned users/drivers only)
-- Problem: https://xomdata.com/practice/nightmare-cancel-rate-001
-- Solved: 2026-10-03

SELECT
    t.request_at AS Day,
    ROUND (
        SUM(CASE WHEN t.status LIKE 'cancelled%' THEN 1 ELSE 0 END)*1.0/COUNT(t.id)
    ,2) Cancellation_Rate 
    
FROM Trips t 
LEFT JOIN Users u1 
ON t.client_id = u1.users_id
LEFT JOIN Users u2
ON t.driver_id = u2.users_id
WHERE t.request_at::date BETWEEN '2024-01-01'::date AND '2024-01-03'::date
AND u1.banned != 'Yes'AND u2.banned != 'Yes'
GROUP BY 1
ORDER BY t.request_at
