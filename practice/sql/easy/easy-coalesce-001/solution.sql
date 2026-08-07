-- Xom Data · Display names on profile pages
-- Problem: https://xomdata.com/practice/easy-coalesce-001
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT 
    real_name,
    nickname,
    COALESCE(nickname, real_name) display_name 
FROM profiles
