import sqlite3
import sys
from pathlib import Path
from datetime import datetime


# ============================================================
# Configuration
# ============================================================

BASE_DIR = Path(__file__).resolve().parent.parent

DATABASE_PATH = (
    BASE_DIR
    / "database"
    / "ecommerce.db"
)


# ============================================================
# Test Helpers
# ============================================================

def create_test_database():

    connection = sqlite3.connect(":memory:")

    connection.execute(
        "PRAGMA foreign_keys = ON"
    )

    connection.executescript("""
        CREATE TABLE customers (
            customer_id TEXT PRIMARY KEY,
            customer_name TEXT NOT NULL,
            email TEXT
        );

        CREATE TABLE products (
            product_id TEXT PRIMARY KEY,
            product_name TEXT NOT NULL,
            cost_price REAL
        );

        CREATE TABLE orders (
            order_id TEXT PRIMARY KEY,
            customer_id TEXT,
            order_date TEXT NOT NULL,
            status TEXT,

            FOREIGN KEY (customer_id)
                REFERENCES customers(customer_id)
        );

        CREATE TABLE order_items (
            item_id TEXT PRIMARY KEY,
            order_id TEXT NOT NULL,
            product_id TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            unit_price REAL NOT NULL,
            discount_percent REAL NOT NULL,

            FOREIGN KEY (order_id)
                REFERENCES orders(order_id),

            FOREIGN KEY (product_id)
                REFERENCES products(product_id),

            CHECK (discount_percent >= 0),
            CHECK (discount_percent <= 100)
        );
    """)

    return connection


# ============================================================
# Test 1
# Zero Revenue Date
# ============================================================

def test_zero_revenue_date():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_001',
                'Test Customer',
                'test@example.com'
            )
        """)

        connection.execute("""
            INSERT INTO products
            VALUES (
                'PROD_TEST_001',
                'Test Product',
                100
            )
        """)

        connection.execute("""
            INSERT INTO orders
            VALUES (
                'ORD_TEST_001',
                'CUST_TEST_001',
                '2026-01-01 10:00:00',
                'CANCELLED'
            )
        """)

        connection.commit()

        result = connection.execute("""
            SELECT
                COALESCE(
                    SUM(
                        oi.quantity
                        * oi.unit_price
                        * (
                            1 -
                            oi.discount_percent / 100.0
                        )
                    ),
                    0
                )
            FROM orders o

            LEFT JOIN order_items oi
                ON o.order_id = oi.order_id

            WHERE DATE(o.order_date)
                  = '2026-01-01'
        """).fetchone()[0]

        assert result == 0

        print(
            "PASS: Zero-revenue date handled correctly"
        )

    finally:

        connection.close()


# ============================================================
# Test 2
# Negative Quantity / Return
# ============================================================

def test_negative_quantity():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_002',
                'Return Customer',
                'return@example.com'
            )
        """)

        connection.execute("""
            INSERT INTO products
            VALUES (
                'PROD_TEST_002',
                'Return Product',
                100
            )
        """)

        connection.execute("""
            INSERT INTO orders
            VALUES (
                'ORD_TEST_002',
                'CUST_TEST_002',
                '2026-01-02 10:00:00',
                'RETURNED'
            )
        """)

        connection.execute("""
            INSERT INTO order_items
            VALUES (
                'ITEM_TEST_002',
                'ORD_TEST_002',
                'PROD_TEST_002',
                -2,
                100,
                0
            )
        """)

        connection.commit()

        result = connection.execute("""
            SELECT quantity
            FROM order_items
            WHERE item_id = 'ITEM_TEST_002'
        """).fetchone()[0]

        assert result == -2

        print(
            "PASS: Negative quantity preserved as return"
        )

    finally:

        connection.close()


# ============================================================
# Test 3
# Invalid Customer Reference
# ============================================================

def test_invalid_customer_reference():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_003',
                'Valid Customer',
                'valid@example.com'
            )
        """)

        connection.commit()

        try:

            connection.execute("""
                INSERT INTO orders
                VALUES (
                    'ORD_TEST_003',
                    'CUSTOMER_DOES_NOT_EXIST',
                    '2026-01-03 10:00:00',
                    'PENDING'
                )
            """)

            connection.commit()

            raise AssertionError(
                "Invalid customer reference was accepted"
            )

        except sqlite3.IntegrityError:

            print(
                "PASS: Invalid customer reference rejected"
            )

    finally:

        connection.close()


# ============================================================
# Test 4
# Duplicate Customer ID
# ============================================================

def test_duplicate_customer_id():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_004',
                'First Customer',
                'first@example.com'
            )
        """)

        connection.commit()

        try:

            connection.execute("""
                INSERT INTO customers
                VALUES (
                    'CUST_TEST_004',
                    'Duplicate Customer',
                    'duplicate@example.com'
                )
            """)

            connection.commit()

            raise AssertionError(
                "Duplicate customer ID was accepted"
            )

        except sqlite3.IntegrityError:

            print(
                "PASS: Duplicate customer ID rejected"
            )

    finally:

        connection.close()


# ============================================================
# Test 5
# Duplicate Order ID
# ============================================================

def test_duplicate_order_id():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_005',
                'Order Customer',
                'order@example.com'
            )
        """)

        connection.execute("""
            INSERT INTO orders
            VALUES (
                'ORD_TEST_005',
                'CUST_TEST_005',
                '2026-01-05 10:00:00',
                'PENDING'
            )
        """)

        connection.commit()

        try:

            connection.execute("""
                INSERT INTO orders
                VALUES (
                    'ORD_TEST_005',
                    'CUST_TEST_005',
                    '2026-01-06 10:00:00',
                    'DELIVERED'
                )
            """)

            connection.commit()

            raise AssertionError(
                "Duplicate order ID was accepted"
            )

        except sqlite3.IntegrityError:

            print(
                "PASS: Duplicate order ID rejected"
            )

    finally:

        connection.close()


# ============================================================
# Test 6
# Date Validation
# ============================================================

def test_invalid_date():

    invalid_date = "2026-99-99"

    try:

        datetime.strptime(
            invalid_date,
            "%Y-%m-%d"
        )

        raise AssertionError(
            "Invalid date was accepted"
        )

    except ValueError:

        print(
            "PASS: Invalid date rejected"
        )


# ============================================================
# Test 7
# Order ID in order_items not in orders
# ============================================================

def test_order_items_invalid_order_reference():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_007',
                'Test Customer 7',
                'test7@example.com'
            )
        """)

        connection.execute("""
            INSERT INTO products
            VALUES (
                'PROD_TEST_007',
                'Test Product 7',
                100
            )
        """)

        connection.commit()

        # Attempt to insert an order item referencing a non-existent order ID
        try:

            connection.execute("""
                INSERT INTO order_items
                VALUES (
                    'ITEM_TEST_007',
                    'ORD_DOES_NOT_EXIST',
                    'PROD_TEST_007',
                    1,
                    100,
                    0
                )
            """)

            connection.commit()

            raise AssertionError(
                "Invalid order reference in order_items was accepted"
            )

        except sqlite3.IntegrityError:

            print(
                "PASS: Invalid order reference in order_items rejected"
            )

    finally:

        connection.close()


# ============================================================
# Test 8
# discount_percent > 100
# ============================================================

def test_invalid_discount_percent():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_008',
                'Test Customer 8',
                'test8@example.com'
            )
        """)

        connection.execute("""
            INSERT INTO products
            VALUES (
                'PROD_TEST_008',
                'Test Product 8',
                100
            )
        """)

        connection.execute("""
            INSERT INTO orders
            VALUES (
                'ORD_TEST_008',
                'CUST_TEST_008',
                '2026-01-08 10:00:00',
                'PENDING'
            )
        """)

        connection.commit()

        # Attempt to insert an order item with discount_percent > 100
        try:

            connection.execute("""
                INSERT INTO order_items
                VALUES (
                    'ITEM_TEST_008',
                    'ORD_TEST_008',
                    'PROD_TEST_008',
                    1,
                    100,
                    150
                )
            """)

            connection.commit()

            raise AssertionError(
                "Discount percent > 100 was accepted"
            )

        except sqlite3.IntegrityError:

            print(
                "PASS: Discount percent > 100 rejected"
            )

    finally:

        connection.close()


# ============================================================
# Test 9
# quantity is 0
# ============================================================

def test_zero_quantity():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_009',
                'Test Customer 9',
                'test9@example.com'
            )
        """)

        connection.execute("""
            INSERT INTO products
            VALUES (
                'PROD_TEST_009',
                'Test Product 9',
                100
            )
        """)

        connection.execute("""
            INSERT INTO orders
            VALUES (
                'ORD_TEST_009',
                'CUST_TEST_009',
                '2026-01-09 10:00:00',
                'PENDING'
            )
        """)

        # Insert order item with quantity = 0
        connection.execute("""
            INSERT INTO order_items
            VALUES (
                'ITEM_TEST_009',
                'ORD_TEST_009',
                'PROD_TEST_009',
                0,
                100,
                0
            )
        """)

        connection.commit()

        # Verify it was inserted successfully
        result = connection.execute("""
            SELECT quantity
            FROM order_items
            WHERE item_id = 'ITEM_TEST_009'
        """).fetchone()[0]

        assert result == 0

        print(
            "PASS: Quantity of 0 processed successfully"
        )

    finally:

        connection.close()


# ============================================================
# Test 10
# order_date in the future
# ============================================================

def test_future_order_date():

    connection = create_test_database()

    try:

        connection.execute("""
            INSERT INTO customers
            VALUES (
                'CUST_TEST_010',
                'Test Customer 10',
                'test10@example.com'
            )
        """)

        future_date = "2099-12-31 23:59:59"

        connection.execute(f"""
            INSERT INTO orders
            VALUES (
                'ORD_TEST_010',
                'CUST_TEST_010',
                '{future_date}',
                'PENDING'
            )
        """)

        connection.commit()

        # Validate that database can store it, but custom scripts can alert on future date
        result = connection.execute("""
            SELECT order_date
            FROM orders
            WHERE order_id = 'ORD_TEST_010'
        """).fetchone()[0]

        assert result == future_date

        print(
            "PASS: Future order date stored (requires reporting constraints)"
        )

    finally:

        connection.close()


# ============================================================
# Run Tests
# ============================================================

def main():

    print("=" * 70)
    print("EDGE CASE TESTS")
    print("=" * 70)

    tests = [
        test_zero_revenue_date,
        test_negative_quantity,
        test_invalid_customer_reference,
        test_duplicate_customer_id,
        test_duplicate_order_id,
        test_invalid_date,
        test_order_items_invalid_order_reference,
        test_invalid_discount_percent,
        test_zero_quantity,
        test_future_order_date
    ]

    passed = 0
    failed = 0

    for test in tests:

        try:

            test()
            passed += 1

        except Exception as error:

            failed += 1

            print(
                f"FAIL: {test.__name__}"
            )

            print(
                f"      {error}"
            )

    print()
    print("=" * 70)
    print("TEST SUMMARY")
    print("=" * 70)

    print(
        f"Passed : {passed}"
    )

    print(
        f"Failed : {failed}"
    )

    if failed > 0:

        sys.exit(1)

    print()
    print("All edge-case tests passed.")


if __name__ == "__main__":
    main()