# Celebal Excellence Internship Data Engineer

## Week 1 Assignment: Basic Data Exploration and Cleaning using Pandas

### Problem Statement
Perform basic data exploration and cleaning tasks using the Pandas library to get familiar with Python basics and data handling.

### Objective
Learn Python basics and perform basic data exploration and cleaning tasks using the Pandas library.

### Dataset
* **Source:** [https://www.kaggle.com/datasets/anvitkumar/shopping-dataset](https://www.kaggle.com/datasets/anvitkumar/shopping-dataset)
* **Input File:** `Combined_dataset.csv`
* **Output File:** `Combined_dataset_cleaned.csv`

### Step-by-Step Implementation
The `Week1_Assignment.ipynb` notebook covers the following pipeline:

1. **Load the Dataset:** Read the CSV dataset (`Combined_dataset.csv`) into a Pandas DataFrame.
2. **Explore Data:** Used methods like `.head()`, `.tail()`, `.shape`, and `.info()` to analyze the dataset's structure, features, and datatypes.
3. **Handle Missing Values:** 
   - Replaced missing categorical/text values (e.g., `what_customers_said`, `seller_name`, `videos`) with `'Unknown'`.
   - Handled nulls in numeric fields like `discount` by filling them with `0`.
   - Cleaned the `final_price` column by stripping string/currency characters and parsing it to a standard numeric format.
4. **Perform Basic Operations:** 
   - Filtered out rows to only include items where `ratings_count > 0` (used as a proxy for quantity).
   - Sliced the DataFrame to retain only relevant columns: `product_id`, `title`, `product_description`, `final_price`, and `ratings_count`.
5. **Remove Duplicates:** Used `.drop_duplicates()` to strip out redundant rows and ensure data integrity.
6. **Create a Derived Column:** Added a new column named `total_amount`, calculated as `final_price * ratings_count`.
7. **Save Cleaned Data:** Exported the finalized, cleaned dataset as a new CSV file (`Combined_dataset_cleaned.csv`).

### Outputs
* `Week1_Assignment.ipynb`: The primary Jupyter Notebook containing the Python code and logic.
* `Combined_dataset_cleaned.csv`: The finalized dataset.