# Celebal Excellence Internship Data Engineer

## Week 3 Assignment: Advanced SQL with Subqueries, CTEs, and Window Functions

---

### Problem Statement
Use Subqueries, CTEs, and Window Functions to analyze sales data from the Superstore dataset.

### Objective
Analyze sales data using SQL by applying Subqueries, CTEs, and Window Functions to solve business queries.

### Step-by-Step Implementation
The assignment was executed in a structured manner, covering data setup, querying, and a final mini-project.

1.  **Data Setup:**
    *   Loaded the Superstore dataset into a raw table (`superstore_raw`).
    *   Normalized the data by creating and populating three distinct tables: `customers`, `products`, and `orders`.
    *   Established relationships using Primary and Foreign Keys.

2.  **Perform Required Queries:**
    *   **Subqueries:** Used to find orders with sales greater than the average and to identify the highest sales order for each customer.
    *   **Common Table Expressions (CTEs):** Applied to calculate total sales per customer and find customers with above-average total sales.
    *   **Window Functions:**
        *   Used `RANK()` to rank customers based on total sales.
        *   Used `ROW_NUMBER()` with `PARTITION BY` to assign sequential numbers to orders within each customer's history.

3.  **Final Combined Query:**
    *   A comprehensive query was built combining `JOIN`, `CTE`, and a `Window Function` to display a ranked list of customers by total sales.

4.  **Mini Project: Customer Sales Insights:**
    *   Answered key business questions by identifying:
        *   Top 5 and bottom 5 customers by sales.
        *   Customers who made only a single order.
        *   Customers with above-average sales.
        *   The highest order value for each customer.

### Outputs
*   [`Create_Insert.sql`](/week3/Create_Insert.sql): SQL script for table creation and data insertion.
*   [`Task.sql`](/week3/Task.sql): SQL script containing all the analysis queries.
*   [`week3_Assignment.pdf`](/week3/week3_Assignment.pdf): The final report document with all queries, outputs, and insights.