-- Xom Data · Highest and lowest score in the cohort
-- Problem: https://xomdata.com/practice/easy-minmax-001
-- Solved: 2026-07-25

SELECT
    MAX(avg_score) max_score,
    MIN(avg_score) min_score
FROM students
