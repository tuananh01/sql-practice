-- Xom Data · Branch code from the invoice number
-- Problem: https://xomdata.com/practice/easy-substr-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    invoice_code,
    LEFT(invoice_code, 3) branch_code 
FROM invoices
