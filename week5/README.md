# Celebal Excellence Internship Data Engineer

## Week 5 Assignment: Apache Spark Fundamentals and Data Processing

---

### Problem Statement
This assignment requires demonstrating a foundational understanding of Apache Spark's core concepts and its advantages over traditional MapReduce. The task involves applying the PySpark DataFrame API to perform a series of common data cleaning, transformation, and aggregation operations on a given dataset.

### Objective
To understand the key features of Apache Spark, including its in-memory computing capabilities and immutable DataFrames. The goal is to gain hands-on experience with the PySpark API to perform essential data engineering tasks such as filtering, aggregation, handling duplicates and nulls, and building a multi-step data processing pipeline.

### Step-by-Step Implementation
The assignment was completed by answering a series of theoretical and practical questions using PySpark on the Superstore dataset.

1.  **Task 1 – Spark Core Concepts (Q1-Q2, Q7, Q9, Q11, Q14)**
    *   Explained the limitations of MapReduce (high disk I/O, slower performance) and why Spark's in-memory processing is superior for iterative algorithms.
    *   Described the immutability of DataFrames and how it ensures predictable transformations.
    *   Explained the importance of handling nulls before aggregation and the risks of using `inferSchema=true` with messy data.
    *   Defined the "Shuffle" process as a wide transformation that occurs during grouping operations.

2.  **Task 2 – DataFrame Transformations & Actions (Q3-Q6, Q8, Q10, Q12-Q13)**
    *   Demonstrated removing duplicate rows based on specific columns using `.dropDuplicates()`.
    *   Showcased filtering, grouping (`.groupBy()`), and aggregation (`.agg()`) to calculate average sales for a specific region.
    *   Explained and used `.na.drop()` and `.na.fill()` for handling null values.
    *   Wrote queries to filter data based on multiple conditions.
    *   Revised a column's data type using `.withColumn()` and casting, and renamed it.
    *   Used `.agg()` to compute multiple statistics (min, max, mean) in a single pass.

3.  **Task 3 – Mini-Project: Processing Pipeline (Q15)**
    *   Constructed a complete, multi-step data processing pipeline in PySpark.
    *   The pipeline sequentially filtered out duplicate records, filled null values in the price column with 0, and grouped the data by `store_id` (or `Region` in the provided solution) to calculate total revenue.

### Outputs
*   [`week5_Assignment.pdf`](/week5/week5_Assignment.pdf): The final report document containing detailed answers, PySpark code snippets, and output screenshots for all 15 questions.
*   [`week5_Assignment.ipynb`](/week5/week5.ipynb): The Jupyter Notebook containing all the PySpark code, transformations, and outputs for the assignment.
