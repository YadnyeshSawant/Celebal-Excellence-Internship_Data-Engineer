# Week 2 Assignment: SQL Fundamentals and Database Management

## Problem Statement
Perform a series of SQL queries on a relational database schema to practice data retrieval, filtering, aggregation, and advanced SQL concepts. The tasks are designed to test understanding of database structure, data integrity, and complex query writing.

## Objective
To gain proficiency in SQL by writing queries to explore a database, perform data manipulation, and solve business-related use cases. This includes working with constraints, joins, aggregations, and transactions.

## Database Schema
The assignment uses a relational database with four main tables:
*   `customers`: Stores customer details like name, email, and location.
*   `products`: Contains product information, including category, price, and stock quantity.
*   `orders`: Records order details such as date, status, and total amount.
*   `order_items`: A junction table linking products to orders, detailing quantity and price for each item in an order.
## ER Diagram
<img width="572" height="603" alt="image" src="https://github.com/user-attachments/assets/9e9bc06b-1e63-47f8-836c-7d6a1f612b77" />


## Step-by-Step Implementation
The SQL queries are organized into logical sections to cover a wide range of database operations:

1.  **SQL Basics:**
    *   Used `SELECT *` to retrieve all data from tables.
    *   Selected specific columns to limit the data returned.
    *   Used `DISTINCT` to find unique values.
    *   Identified Primary Keys and `UNIQUE` constraints.

2.  **Filtering & Optimization:**
    *   Applied `WHERE` clauses to filter data based on various conditions (e.g., status, category, date ranges).
    *   Combined conditions using `AND` and `<>`.
    *   Analyzed the use of indexes (`idx_orders_date`) to optimize query performance for date-based filtering.
    *   Rewrote a non-SARGable query to make it index-friendly.

3.  **Aggregation:**
    *   Used aggregate functions like `COUNT()`, `SUM()`, `AVG()`, `MAX()`, and `MIN()`.
    *   Grouped data using `GROUP BY` to perform calculations on subsets of data (e.g., sales per category).
    *   Filtered grouped data using the `HAVING` clause.

4.  **Joins & Relationships:**
    *   Combined data from multiple tables using `INNER JOIN` and `LEFT JOIN`.
    *   Queried across three tables to create comprehensive reports.
    *   Explained the differences between `LEFT`, `RIGHT`, and `FULL OUTER JOIN`.
    *   Identified Foreign Key relationships and their importance for data integrity.

5.  **Advanced Concepts:**
    *   Used `CASE` statements to create conditional logic within queries for data classification (e.g., price tiers).
    *   Applied `CASE` within an aggregate function for conditional counting.
    *   Explained the principles of `ACID` (Atomicity, Consistency, Isolation, Durability).
    *   Wrote a `TRANSACTION` block to perform multiple database operations atomically, ensuring that all changes either succeed or fail together.

## Outputs
*  [`week2_Assignment.pdf`](/week2/week2_Assignment.pdf): A Word document containing all SQL queries, their outputs, and detailed answers to the assignment questions.
