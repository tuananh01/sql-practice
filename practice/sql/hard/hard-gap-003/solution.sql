-- Xom Data · Dự đoán ngày khách ghé tiếp theo
-- Problem: https://xomdata.com/practice/hard-gap-003
-- Solved: 2026-09-24

WITH gap AS (
    SELECT 
        customer_id,
        MAX(order_date) OVER(PARTITION BY customer_id) last_order_date,
        julianday(LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date, order_id))
            - julianday(order_date) AS gap_days
    FROM orders 
)

    SELECT 
        customer_id,
        last_order_date,
        CAST(AVG(gap_days) AS INT) avg_gap_days,
        DATE(julianday(last_order_date) + CAST(AVG(gap_days) AS INT), 'julianday')
        predicted_next_date  
    FROM gap
    WHERE gap_days IS NOT NULL    
    GROUP BY customer_id



-- SELECT 
--     DATE('2024-03-02', '+30 days')
