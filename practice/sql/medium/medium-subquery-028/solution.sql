-- Xom Data · Students above the subject average
-- Problem: https://xomdata.com/practice/medium-subquery-028
-- Solved: 2026-08-18

SELECT
    *,
    (final_score -  subject_avg) diff_from_avg 
FROM (
    SELECT
    st.full_name,
    su.subject_name,
    g.final_score,
    ROUND (
        AVG(final_score) OVER(PARTITION BY su.subject_name) 
    , 2) subject_avg 
FROM students st 
JOIN grades g 
ON st.id = g.student_id 
JOIN subjects su 
ON su.id = g.subject_id
GROUP BY 1, 2, 3
)T
WHERE final_score > subject_avg
ORDER BY diff_from_avg DESC, full_name
