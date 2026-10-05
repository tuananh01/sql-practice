-- Xom Data · Tỷ lệ thất thoát khách theo từng tháng
-- Problem: https://xomdata.com/practice/hard-churn-003
-- Solved: 2026-10-05

WITH cohort AS (
    SELECT
        customer_id,
        strftime('%Y-%m', order_date) AS month,
        strftime('%Y', order_date) * 12 + strftime('%m', order_date) abs_month
    FROM orders
  
)
SELECT 
    *,
    ROUND(churned_customers*100.0/active_customers,2) churn_rate_pct 
FROM (
    SELECT 
        c1.month,
        COUNT(DISTINCT c1.customer_id) active_customers,
        SUM(CASE WHEN c2.customer_id IS NULL THEN 1 ELSE 0 END) churned_customers 
    FROM cohort c1
    LEFT JOIN cohort c2
    ON c1.customer_id = c2.customer_id 
    AND c1.abs_month + 1 = c2.abs_month 
    WHERE c1.month != (SELECT strftime('%Y-%m', MAX(order_date)) FROM orders) 
    GROUP BY 1
)T
ORDER BY month
