/* Create transactions and use savepoints to handle potential errors in database operations.
    - Start a transaction.
    - Insert a new customer into the `customers` table.
    - Set a savepoint before attempting to add an order.
    - Try to add an order and an order item for a non-existent product.
    - If the operation of adding the order item encounters an error (e.g., the product does not exist), roll back the changes to the savepoint. Otherwise, commit the transaction.
*/
-- Start a transaction
START TRANSACTION;

-- Insert a new customer into the customers table
INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES ('Marek', 'Kowalski', 'marek.kowalski@example.com', '321-123-4567');

-- Set a savepoint before attempting to add an order
SAVEPOINT before_order;

-- Try to add an order for a non-existent product
BEGIN
    -- Insert a new order for the customer
    INSERT INTO orders (customer_id, order_date, total_amount)
    VALUES (LAST_INSERT_ID(), CURDATE(), 1299.98);
    
    -- Attempt to insert an order item for a non-existent product (e.g., product_id = 999)
    INSERT INTO order_items (order_id, product_id, quantity, price)
    VALUES (LAST_INSERT_ID(), 999, 1, 1299.98);
    
    -- If successful, commit the transaction
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    
        ROLLBACK TO SAVEPOINT before_order;

END;
