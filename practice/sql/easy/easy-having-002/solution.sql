-- Xom Data · Customers reaching the loyalty milestone
-- Problem: https://xomdata.com/practice/easy-having-002
-- Solved: 2026-08-07

-- Viết SQL của bạn ở đây
SELECT
    customer_name,
    SUM(amount) total_spent 
FROM purchases
GROUP BY 1
HAVING SUM(amount) >= 5000000
ORDER BY total_spent DESC, 1
