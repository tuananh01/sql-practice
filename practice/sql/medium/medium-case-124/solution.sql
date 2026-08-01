-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-08-01

SELECT
    st.full_name,
    st.student_code,
    ROUND(AVG(sc.final_score),2) avg_score,
    CASE WHEN AVG(sc.final_score) >= 9 THEN 'Excellent'
         WHEN AVG(sc.final_score) >= 8 AND AVG(sc.final_score) < 9 THEN 'Good'
         WHEN AVG(sc.final_score) >= 7 AND AVG(sc.final_score) < 8 THEN 'Fair'
         WHEN AVG(sc.final_score) >= 5 AND AVG(sc.final_score) < 7 THEN 'Average'
         ELSE 'Poor'
    END grade,
    DENSE_RANK() OVER(ORDER BY AVG(sc.final_score) DESC) AS class_rank
FROM scores sc
JOIN students st  
ON sc.student_id = st.id
GROUP BY st.full_name, student_code
LIMIT 20
