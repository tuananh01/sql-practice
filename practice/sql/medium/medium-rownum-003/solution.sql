-- Xom Data · Visit number within each day
-- Problem: https://xomdata.com/practice/medium-rownum-003
-- Solved: 2026-10-13

-- Write your SQL here
SELECT 
    checkin_date,
    ROW_NUMBER() OVER(PARTITION BY checkin_date ORDER BY checkin_time, member_name) visit_no,
    member_name,
    checkin_time 
FROM checkins
ORDER BY checkin_date, visit_no
