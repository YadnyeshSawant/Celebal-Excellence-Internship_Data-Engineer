CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

INSERT INTO customers
SELECT
    customer_id,
    MAX(customer_name),
    MAX(segment)
FROM superstore_raw
GROUP BY customer_id;

CREATE TABLE products (
    product_id VARCHAR(30) PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255)
);

INSERT INTO products
SELECT
    product_id,
    MAX(category),
    MAX(sub_category),
    MAX(product_name)
FROM superstore_raw
GROUP BY product_id;


CREATE TABLE orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),

    customer_id VARCHAR(20),
    product_id VARCHAR(30),

    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,4),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO orders
SELECT
    row_id,
    order_id,
    STR_TO_DATE(order_date, '%m/%d/%Y'),
    STR_TO_DATE(ship_date, '%m/%d/%Y'),
    ship_mode,
    customer_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
FROM superstore_raw;


SELECT COUNT(*) AS raw_records FROM superstore_raw;

SELECT COUNT(*) AS customers FROM customers;

SELECT COUNT(*) AS products FROM products;

SELECT COUNT(*) AS orders FROM orders;