-- Xom Data · Median employee revenue per department
-- Problem: https://xomdata.com/practice/expert-final-win-010
-- Solved: 2026-09-05

SELECT 
    departments,
    COUNT(DISTINCT employees) employee_count,
    ROUND(AVG(revenue),0) avg_revenue,
  
        percentile_cont(0.5) WITHIN GROUP (ORDER BY revenue) AS median_revenue 
FROM sales 
GROUP BY 1
ORDER BY departments
