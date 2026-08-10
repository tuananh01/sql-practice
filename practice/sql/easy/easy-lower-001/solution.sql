-- Xom Data · Normalizing emails before matching
-- Problem: https://xomdata.com/practice/easy-lower-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT 
    email,
    LOWER(email) normalized_email 
FROM subscribers
