-- Query 2: Multi-Warehouse Inventory Valuation
SELECT 
    w.warehouse_code,
    w.city,
    COUNT(DISTINCT i.product_id) AS total_sku_count,
    SUM(i.quantity_on_hand) AS total_units_in_stock,
    SUM(i.quantity_on_hand * p.unit_price) AS total_inventory_valuation
FROM inventory i
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
JOIN products p ON i.product_id = p.product_id
GROUP BY w.warehouse_id, w.warehouse_code, w.city
ORDER BY total_inventory_valuation DESC;
