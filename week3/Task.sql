-- Write and execute SQL queries for each of the following:
-- 1. Find all orders where sales are greater than the average sales. (Subquery)
SELECT *
FROM orders
WHERE sales >
(
    SELECT AVG(sales)
    FROM orders
);

-- 2. Find the highest sales order for each customer. (Subquery)
SELECT
    o.customer_id,
    c.customer_name,
    o.order_id,
    o.sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.sales =
(
    SELECT MAX(sales)
    FROM orders
    WHERE customer_id = o.customer_id
);

-- 3. Calculate total sales for each customer. (CTE)

WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT
    cs.customer_id,
    c.customer_name,
    cs.total_sales
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
ORDER BY total_sales DESC;

-- 4. Find customers whose total sales are above average. (CTE + Subquery)
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT
    cs.customer_id,
    c.customer_name,
    cs.total_sales
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
)
ORDER BY total_sales DESC;

-- 5. Rank all customers based on total sales. (Window Function)
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT
    cs.customer_id,
    c.customer_name,
    cs.total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id;

-- 6. Assign row numbers to each order within a customer. (Window Function + PARTITION BY)
SELECT
    customer_id,
    order_id,
    order_date,
    sales,
    ROW_NUMBER() OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number
FROM orders;

-- 7. Display top 3 customers based on total sales. (Window Function)
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT *
FROM
(
    SELECT
        cs.customer_id,
        c.customer_name,
        cs.total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales cs
    JOIN customers c
    ON cs.customer_id = c.customer_id
) ranked_customers
WHERE sales_rank <= 3;


-- Write one final query that shows:
-- •	Customer Name 
-- •	Total Sales 
-- •	Rank
-- (Use JOIN + CTE + Window Function together)
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT
    c.customer_name AS "Customer Name",
    cs.total_sales AS "Total Sales",
    RANK() OVER (ORDER BY cs.total_sales DESC) AS "Rank"
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
ORDER BY "Rank";


-- Mini Project: Customer Sales Insights
-- Answer the following using SQL:
-- 1. Who are the top 5 customers?
SELECT
    c.customer_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- 2. Who are the bottom 5 customers?
SELECT
    c.customer_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales ASC
LIMIT 5;

-- 3. Which customers made only one order?
SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT o.order_id) = 1;

-- 4. Which customers have above-average sales?
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT
    c.customer_name,
    cs.total_sales
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
WHERE cs.total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
)
ORDER BY cs.total_sales DESC;

-- 5. What is the highest order value per customer?
WITH order_totals AS
(
    SELECT
        customer_id,
        order_id,
        SUM(sales) AS order_value
    FROM orders
    GROUP BY customer_id, order_id
)

SELECT
    c.customer_name,
    MAX(ot.order_value) AS highest_order_value
FROM order_totals ot
JOIN customers c
ON ot.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY highest_order_value DESC;