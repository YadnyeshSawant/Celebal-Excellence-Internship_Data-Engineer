# Celebal Excellence Internship Data Engineer

## Week 2 Assignment: SQL Fundamentals and Database Management

This week's assignment was completed in two parts, assigned through different channels: **Task 1** from the LMS Portal, and **Task 2 — "E-Commerce Sales Database"** from the detailed assignment document shared by the mentor.

---

## Task 1: SQL-Based Data Analysis Using Filtering, Aggregation, and Basic Business Queries

### Problem Statement
SQL-based data analysis using filtering, aggregation, and basic business queries.

### Objective
Analyze sales data using SQL with filtering, aggregation, and business queries.

### Step-by-Step Implementation
1.  **Load Dataset:** Loaded the dataset into a SQL database.
2.  **Explore Table:** Viewed the table schema and sample data using `DESCRIBE`.
3.  **Apply WHERE Filters:** Filtered data based on region, category, order date, and sales.
4.  **Use GROUP BY for Aggregations:** Calculated total sales, total quantity, and average sales.
5.  **Sort and Limit Results:** Identified top products and top categories using `ORDER BY` and `LIMIT`.
6.  **Solve Use Cases:** Analyzed monthly sales trends, identified top customers, and detected duplicates.
7.  **Validate Results:** Checked row counts and performed basic data quality checks.

### Outputs
*   SQL Script / Notebook
*   Query Results
*   Brief Insights

---

## Task 2: E-Commerce Sales Database (Q1–Q27)

### Problem Statement
You are a Junior Data Analyst at ShopEase, a mid-sized e-commerce company that sells electronics, clothing, and home products across India. The management team wants to understand sales patterns, customer behavior, and product performance to make better business decisions. You have been given access to the company's relational database containing information about customers, products, orders, and order details, and are tasked with writing SQL queries to extract meaningful insights from this data — while also demonstrating understanding of database structure, data integrity, and complex query writing.

### Objective
To gain proficiency in SQL by writing queries to explore a database, perform data manipulation, and solve business-related use cases. This includes working with constraints, joins, aggregations, and transactions.

### Database Schema
The assignment uses a relational database with four main tables:
*   `customers`: Stores customer details like name, email, and location.
*   `products`: Contains product information, including category, price, and stock quantity.
*   `orders`: Records order details such as date, status, and total amount.
*   `order_items`: A junction table linking products to orders, detailing quantity and price for each item in an order.

**Entity Relationships:**
*   `customers` ──(1:N)── `orders`
*   `orders` ──(1:N)── `order_items`
*   `products` ──(1:N)── `order_items`

### ER Diagram
<img width="572" height="603" alt="image" src="https://github.com/user-attachments/assets/9e9bc06b-1e63-47f8-836c-7d6a1f612b77" />

### Step-by-Step Implementation
The SQL queries are organized into five graded sections covering a wide range of database operations:

1.  **Section A — SQL Basics:**
    *   Used `SELECT *` to retrieve all data from tables.
    *   Selected specific columns to limit the data returned.
    *   Used `DISTINCT` to find unique values.
    *   Identified Primary Keys and `UNIQUE` constraints.

2.  **Section B — Filtering & Optimization:**
    *   Applied `WHERE` clauses to filter data based on various conditions (e.g., status, category, date ranges).
    *   Combined conditions using `AND` and `<>`.
    *   Analyzed the use of indexes (`idx_orders_date`) to optimize query performance for date-based filtering.
    *   Rewrote a non-SARGable query to make it index-friendly.

3.  **Section C — Aggregation:**
    *   Used aggregate functions like `COUNT()`, `SUM()`, `AVG()`, `MAX()`, and `MIN()`.
    *   Grouped data using `GROUP BY` to perform calculations on subsets of data (e.g., sales per category).
    *   Filtered grouped data using the `HAVING` clause.

4.  **Section D — Joins & Relationships:**
    *   Combined data from multiple tables using `INNER JOIN` and `LEFT JOIN`.
    *   Queried across three tables to create comprehensive reports.
    *   Explained the differences between `LEFT`, `RIGHT`, and `FULL OUTER JOIN`.
    *   Identified Foreign Key relationships and their importance for data integrity.

5.  **Section E — Advanced Concepts:**
    *   Used `CASE` statements to create conditional logic within queries for data classification (e.g., price tiers).
    *   Applied `CASE` within an aggregate function for conditional counting.
    *   Explained the principles of `ACID` (Atomicity, Consistency, Isolation, Durability).
    *   Wrote a `TRANSACTION` block to perform multiple database operations atomically, ensuring that all changes either succeed or fail together.

### Outputs
*  [`week2_Assignment.pdf`](/week2/week2_Assignment.pdf): A pdf document containing all SQL queries (Task 1 and Task 2), their outputs, and detailed answers to the assignment questions. Converted from the original Word file with screenshots, as suggested in the Saturday's 27-06-2026 meeting.