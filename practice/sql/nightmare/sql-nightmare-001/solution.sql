-- Xom Data · Longest consecutive login streak
-- Problem: https://xomdata.com/practice/sql-nightmare-001
-- Solved: 2026-08-18

WITH islands AS (
    SELECT
        *,
        formatted_date - ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY formatted_date)
            AS group_id
    FROM (
        SELECT
            user_id,
            login_date,
            substr(login_date , 9, 2) || '-' || 
            substr(login_date, 6, 2) || '-' || 
            substr(login_date, 1, 4) formatted_date
        FROM logins 
    )T
)

SELECT 
    user_id,
    MAX(streak) max_streak
FROM (
    SELECT 
        user_id,
        COUNT(group_id) streak 
    FROM islands 
    GROUP BY user_id, group_id 
)t
GROUP BY 1
ORDER BY user_id
