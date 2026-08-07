-- Xom Data · Names printed on staff badges
-- Problem: https://xomdata.com/practice/easy-concat-001
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    first_name,
    last_name,
    first_name|| ' ' ||last_name AS badge_name
FROM staff
