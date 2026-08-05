-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-08-05

SELECT
    subject_name,
    credits,
    student_count,
    avg_score,
    pass_rate,
    RANK() OVER(ORDER BY avg_score DESC) rank_by_avg,
    NTILE(4) OVER(ORDER BY avg_score DESC, subject_name) difficulty_quartile 
FROM (
    SELECT
    s.subject_name,
    s.credits,
    COUNT(g.subject_id) student_count,
    ROUND(AVG(g.final_score),2) avg_score,
    ROUND(
        SUM(CASE WHEN g.final_score >= 5 THEN 1 ELSE 0 END)*100.0/COUNT(g.subject_id)
    ,2) pass_rate
    FROM subjects s
    JOIN grades g   
    ON s.id = g.subject_id 
    GROUP BY s.subject_name, s.credits
)t
ORDER BY rank_by_avg, subject_name
