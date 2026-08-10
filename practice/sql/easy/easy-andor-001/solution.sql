-- Xom Data · Apartments matching the client's criteria
-- Problem: https://xomdata.com/practice/easy-andor-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    listing_code,
    district,
    monthly_rent
FROM apartments
WHERE district IN ('Binh Thanh', 'District 3') 
AND monthly_rent <= 9000000
