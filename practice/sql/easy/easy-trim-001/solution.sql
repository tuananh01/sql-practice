-- Xom Data · Cleaning whitespace in the lead list
-- Problem: https://xomdata.com/practice/easy-trim-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    full_name,
    TRIM(full_name) clean_name,
    phone 
FROM leads
