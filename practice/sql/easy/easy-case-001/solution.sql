-- Xom Data · Safety training results
-- Problem: https://xomdata.com/practice/easy-case-001
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT 
    trainee_name,
    score,
    CASE WHEN score >= 70 THEN 'Pass'
         ELSE 'Fail'
    END result
FROM trainees
