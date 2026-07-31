-- Xom Data · Total balance across the bank
-- Problem: https://xomdata.com/practice/easy-sum-003
-- Solved: 2026-07-31

SELECT
    SUM(balance) total_balance 
FROM accounts
