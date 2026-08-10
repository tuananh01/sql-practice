-- Xom Data · Books about data
-- Problem: https://xomdata.com/practice/easy-like-003
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    title,
    author 
FROM books 
WHERE LOWER(title) LIKE '%data%'
