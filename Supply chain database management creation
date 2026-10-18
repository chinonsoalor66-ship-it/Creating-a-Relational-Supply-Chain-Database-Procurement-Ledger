### Relational Schema Summary
1. **`suppliers`**: Primary vendor records, contact details, and location details.
2. **`warehouses`**: Storage facilities, location data, and square footage capacity.
3. **`products`**: Item catalog containing SKUs, categories, and unit price baselines.
4. **`inventory`**: Junction table linking products to warehouses, tracking `quantity_on_hand` and `reorder_level`.
5. **`purchase_orders`**: Procurement transaction headers tracking statuses and order timelines.
6. **`purchase_order_items`**: Granular line items linking individual ordered items and agreed unit costs to purchase orders.

---

## 📊 SQL Analytics & Business Operational Impact

The project includes three core analytical queries designed for operational reporting:

### 1. Stock Status & Automated Reorder Alerts
Flags inventory levels per warehouse and triggers operational alerts when stock drops to or below safety reorder thresholds.
* **SQL Highlights:** `INNER JOIN`, Conditional `CASE WHEN` logic.

```sql
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

2. Multi-Warehouse Financial Valuation
Calculates physical stock volumes and overall monetary valuation across global warehouse facilities.

SQL Highlights: Multi-table JOIN, SUM(), COUNT(), GROUP BY, TO_CHAR() currency formatting.

-- Query 2: Multi-Warehouse Financial Valuation
SELECT 
    w.warehouse_code,
    w.city,
    COUNT(i.product_id) AS distinct_products_stored,
    SUM(i.quantity_on_hand) AS total_units_in_stock,
    TO_CHAR(SUM(i.quantity_on_hand * p.unit_price), 'FM$999,999.00') AS total_inventory_value
FROM inventory i
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
JOIN products p ON i.product_id = p.product_id
GROUP BY w.warehouse_code, w.city
ORDER BY SUM(i.quantity_on_hand * p.unit_price) DESC;

3. Procurement Pipeline & Order Cost Analysis
Aggregates line items across open purchase orders to calculate overall financial commitments across global suppliers.

SQL Highlights: Multi-table line-item aggregation, dynamic cost calculation.

-- Query 3: Procurement Pipeline & Order Cost Analysis
SELECT 
    po.po_id,
    s.supplier_name,
    po.status,
    po.order_date,
    po.expected_delivery_date,
    SUM(poi.quantity_ordered * poi.unit_cost) AS total_po_cost
FROM purchase_orders po
JOIN suppliers s ON po.supplier_id = s.supplier_id
JOIN purchase_order_items poi ON po.po_id = poi.po_id
GROUP BY po.po_id, s.supplier_name, po.status, po.order_date, po.expected_delivery_date
ORDER BY po.order_date DESC;

In conclusion, this project successfully bridges relational database engineering and operational supply chain analytics by constructing a fully normalized 3NF PostgreSQL database from scratch. 
By integrating multi-warehouse inventory valuation, automated reorder thresholds, and procurement pipeline tracking, 
the system provides vital operational visibility and robust data infrastructure for enterprise supply chain management.
