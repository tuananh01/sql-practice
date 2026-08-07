-- Xom Data · Countries our students come from
-- Problem: https://xomdata.com/practice/easy-distinct-008
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT 
    COUNT(DISTINCT country) num_countries 
FROM students
