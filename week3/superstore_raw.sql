use week3_assignment;

CREATE TABLE superstore_raw (
    row_id INT,
    order_id VARCHAR(30),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),

    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),

    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(20),

    product_id VARCHAR(30),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),

    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,4)
);


LOAD DATA LOCAL INFILE 'C:/Users/yadny/Downloads/Sample - Superstore.csv/Sample - Superstore.csv'
INTO TABLE superstore_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
);

-- SELECT
--     COUNT(*) AS total_rows,
--     COUNT(sales) AS sales_not_null,
--     MIN(sales) AS min_sales,
--     MAX(sales) AS max_sales
-- FROM superstore_raw;

-- | total_rows | sales_not_null | min_sales | max_sales |
-- | ---------- | -------------: | --------: | --------: |
-- | 9994       |           9994 |      0.44 |  22638.48 |
