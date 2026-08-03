-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-08-03

SELECT 
    vehicle_type,
    capacity_tons,
    shipment_count,
    size_class,
    delivered,
    ROUND(delivered*100.0/shipment_count,2) AS delivery_rate,
    RANK() OVER(PARTITION BY size_class ORDER BY ROUND(delivered*100.0/shipment_count,2) DESC) rank_in_size
FROM (
    SELECT
    t.vehicle_type,
    t.capacity_tons,
    COUNT(s.id) shipment_count,
    CASE WHEN t.capacity_tons >= 10 THEN 'Large Truck'
         WHEN t.capacity_tons >= 5 AND t.capacity_tons < 10 THEN 'Medium Truck'
         ELSE 'Small Truck'
    END size_class,
    SUM(CASE WHEN d.results = 'success' THEN 1 ELSE 0 END) delivered
    FROM trucks t
    JOIN shipments s
    ON t.id = s.truck_id
    JOIN deliveries d
    ON s.id = d.shipment_id
    GROUP BY t.vehicle_type, t.capacity_tons
)T
ORDER BY rank_in_size, size_class, vehicle_type
