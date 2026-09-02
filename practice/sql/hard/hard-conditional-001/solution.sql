-- Xom Data · Cumulative revenue from successful transactions only
-- Problem: https://xomdata.com/practice/hard-conditional-001
-- Solved: 2026-09-02

SELECT
    date,
    status,
    amount,
    SUM(CASE WHEN status = 'success' THEN amount ELSE 0 END) OVER(ORDER BY date, status, id)  
        AS running_success_total 
FROM transactions 
ORDER BY date, status, id
