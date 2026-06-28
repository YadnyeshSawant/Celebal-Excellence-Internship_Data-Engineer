use week2_assignment;

-- 2: Explore table (schema, sample data).
DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;
DESCRIBE order_items;

SELECT * FROM customers LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM order_items LIMIT 10;


-- 3: Apply WHERE filters (region, category, date, sales)
SELECT * FROM customers WHERE state='Maharashtra';
SELECT * FROM products WHERE category='Electronics';
SELECT * FROM orders WHERE order_date BETWEEN '2024-08-01' AND '2024-08-31';
SELECT * FROM orders WHERE total_amount>1000;
SELECT * FROM customers WHERE is_premium=TRUE;


-- 4: Use GROUP BY for aggregations (sales, quantity, averages)
SELECT status, SUM(total_amount) AS Total_Sales FROM orders GROUP BY status;
SELECT product_id, SUM(quantity) AS Total_Quantity FROM order_items GROUP BY product_id;
SELECT AVG(total_amount) AS Average_Order_Value FROM orders;
SELECT customer_id, SUM(total_amount) AS Total_Sales FROM orders GROUP BY customer_id;
SELECT category, COUNT(*) AS Total_Products FROM products GROUP BY category;


-- 5: Sort and limit results (top products, top categories).
SELECT * FROM products ORDER BY unit_price DESC LIMIT 5;
SELECT * FROM orders ORDER BY total_amount DESC LIMIT 5;
SELECT customer_id, SUM(total_amount) AS Total_Spent FROM orders GROUP BY customer_id ORDER BY Total_Spent DESC LIMIT 5;
SELECT category, COUNT(*) AS Total_Products FROM products GROUP BY category ORDER BY Total_Products DESC;


-- 6: Solve use cases (monthly trends, top customers, duplicates).
SELECT YEAR(order_date) AS Year, MONTH(order_date) AS Month, SUM(total_amount) AS Monthly_Sales FROM orders GROUP BY YEAR(order_date), MONTH(order_date) ORDER BY Year, Month;
SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS Customer_Name, SUM(o.total_amount) AS Total_Spent FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id, Customer_Name ORDER BY Total_Spent DESC LIMIT 5;
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS Total_Quantity_Sold FROM products p JOIN order_items oi ON p.product_id=oi.product_id GROUP BY p.product_id, p.product_name ORDER BY Total_Quantity_Sold DESC;
SELECT email, COUNT(*) AS Duplicate_Count FROM customers GROUP BY email HAVING COUNT(*)>1;
SELECT order_id, COUNT(product_id) AS Number_Of_Products FROM order_items GROUP BY order_id HAVING COUNT(product_id)>1;


-- TASK 7: Validate results (row counts, data quality).
SELECT COUNT(*) AS Total_Customers FROM customers;
SELECT COUNT(*) AS Total_Products FROM products;
SELECT COUNT(*) AS Total_Orders FROM orders;
SELECT COUNT(*) AS Total_Order_Items FROM order_items;
SELECT * FROM customers WHERE email IS NULL;
SELECT * FROM products WHERE stock_qty<0;
SELECT * FROM orders WHERE total_amount<0;
SELECT oi.* FROM order_items oi LEFT JOIN orders o ON oi.order_id=o.order_id WHERE o.order_id IS NULL;
SELECT oi.* FROM order_items oi LEFT JOIN products p ON oi.product_id=p.product_id WHERE p.product_id IS NULL;
SELECT product_id, COUNT(*) AS Duplicate_Count FROM products GROUP BY product_id HAVING COUNT(*)>1;