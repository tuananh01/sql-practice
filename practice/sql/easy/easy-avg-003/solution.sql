-- Xom Data · Average score in Math
-- Problem: https://xomdata.com/practice/easy-avg-003
-- Solved: 2026-08-07

SELECT 
    AVG(score) avg_score 
FROM exam_scores
WHERE subject = 'Math'
