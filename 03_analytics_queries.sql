-- Query 3: Supplier Lead Time & Delivery Performance Analysis
SELECT 
    s.supplier_name,
    COUNT(po.po_id) AS total_orders_placed,
    AVG(po.expected_delivery_date - po.order_date) AS avg_lead_time_days,
    COUNT(CASE WHEN po.po_status = 'DELIVERED' THEN 1 END) AS fulfilled_orders,
    COUNT(CASE WHEN po.po_status = 'CANCELLED' THEN 1 END) AS cancelled_orders
FROM suppliers s
LEFT JOIN purchase_orders po ON s.supplier_id = po.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_orders_placed DESC;
