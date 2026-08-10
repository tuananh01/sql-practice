-- Xom Data · Records with a contact number
-- Problem: https://xomdata.com/practice/easy-isnull-003
-- Solved: 2026-08-09

-- Viết SQL của bạn ở đây
SELECT
    patient_name,
    phone 
FROM patients
WHERE phone IS NOT NULL
