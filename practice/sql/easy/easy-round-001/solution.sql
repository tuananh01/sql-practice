-- Xom Data · Display rates for the app
-- Problem: https://xomdata.com/practice/easy-round-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    currency_pair,
    ROUND(raw_rate, 2) display_rate 
FROM fx_rates
