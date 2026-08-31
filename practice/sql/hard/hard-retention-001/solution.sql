-- Xom Data · D7 and D30 retention rate
-- Problem: https://xomdata.com/practice/hard-retention-001
-- Solved: 2026-08-31

SELECT 
    total_users,
    d7_retained,
    CASE WHEN total_users = 0 THEN 0.0 
         ELSE ROUND(d7_retained * 100.0 / total_users, 2) 
    END AS d7_rate,
    d30_retained,
    CASE WHEN total_users = 0 THEN 0.0 
         ELSE ROUND(d30_retained * 100.0 / total_users, 2) 
    END AS d30_rate
FROM (
    SELECT
        COUNT(DISTINCT s.user_id) AS total_users,
        
        COUNT(DISTINCT CASE 
            WHEN julianday(a.active_date) - julianday(s.signup_date) BETWEEN 1 AND 7 
            THEN s.user_id 
        END) AS d7_retained, 
        
        COUNT(DISTINCT CASE 
            WHEN julianday(a.active_date) - julianday(s.signup_date) BETWEEN 1 AND 30 
            THEN s.user_id 
        END) AS d30_retained 
        
    FROM signups s 
    LEFT JOIN activity a 
    ON s.user_id = a.user_id
) T
