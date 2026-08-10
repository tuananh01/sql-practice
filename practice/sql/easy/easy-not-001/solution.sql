-- Xom Data · Devices ready for dispatch
-- Problem: https://xomdata.com/practice/easy-not-001
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    device_code,
    status
FROM devices
WHERE status != 'Maintenance'
