-- Query 1: Stock Status & Automated Reorder Alerts
SELECT 
    w.warehouse_code,
    w.city,
    p.sku,
    p.product_name,
    i.quantity_on_hand,
    i.reorder_level,
    CASE 
        WHEN i.quantity_on_hand <= i.reorder_level THEN '🔴 REORDER REQUIRED'
        ELSE '🟢 Stock Healthy'
    END AS stock_status
FROM inventory i
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
JOIN products p ON i.product_id = p.product_id
ORDER BY stock_status DESC, i.quantity_on_hand ASC;
