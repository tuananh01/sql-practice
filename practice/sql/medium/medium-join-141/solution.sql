-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-08-23

SELECT
    f.faculty_name,
    d.full_name doctor_name ,
    COUNT(m.id) visit_count,
    ROUND(AVG(m.visit_fee),0) avg_exam_fee,
    SUM(m.visit_fee) total_exam_fee,
    RANK() OVER(ORDER BY SUM(m.visit_fee) DESC) overall_rank,
    DENSE_RANK() OVER(PARTITION BY f.faculty_name ORDER BY SUM(m.visit_fee) DESC)  rank_in_faculty 
FROM doctors d 
JOIN faculties f 
ON d.faculty_id = f.id  
JOIN medical_visits m 
ON d.id = m.doctor_id
GROUP BY 1, 2
ORDER BY total_exam_fee DESC, d.full_name
LIMIT 15
