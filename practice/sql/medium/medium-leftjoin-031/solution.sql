-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-08-16

SELECT
    c.full_name,
    c.email,
    c.application_date,
    ROW_NUMBER() OVER(ORDER BY c.application_date, c.full_name) queue_position,
    ROUND (
        (PERCENT_RANK() OVER(ORDER BY c.application_date))*100  
    ,2) older_than_pct

FROM candidates c 
LEFT JOIN interviews i 
ON c.id = i.candidate_id 
WHERE i.id IS NULL
