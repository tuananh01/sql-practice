-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-08-15

SELECT 
    *,
    SUM(subjects_taught) OVER(ORDER BY workload_rank, full_name) cumulative_subjects 
FROM (
    SELECT
    l.full_name,
    l.academic_degree,
    COUNT(s.id) subjects_taught,
    RANK() OVER(ORDER BY COUNT(s.id) DESC) workload_rank
FROM lecturers l
LEFT JOIN subjects s 
ON l.id = s.lecturer_id
GROUP BY 1, 2
)T
