/*
 1.Create the `AddCustomerAndOrder` procedure, which accepts parameters for customer details and order information.
The procedure should:

	Insert the customer data into the `customers` table.
	Retrieve the new customer ID.
	Insert the order data into the `orders` table, calculating the total amount based on the product price and quantity.
	Insert order item details into the `order_items` table.
	Commit the changes if successful or roll back in case of errors.

2.Call the Stored Procedure

	Call the stored procedure to test its functionality with both valid and invalid data.
	Call the `AddCustomerAndOrder` procedure with valid customer and product data.
	Call the procedure with an invalid product ID to test how the procedure handles errors.
 */

-- 1. Create the AddCustomerAndOrder procedure
DELIMITER //

CREATE PROCEDURE AddCustomerAndOrder(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(15),
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_customer_id INT;
    DECLARE v_order_id INT;
    DECLARE v_product_price DECIMAL(10, 2);
    DECLARE v_total_amount DECIMAL(10, 2);
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error occurred. Transaction rolled back.';
    END;

    START TRANSACTION;

    -- Insert the customer data into the `customers` table.
    INSERT INTO customers (first_name, last_name, email, phone_number)
    VALUES (p_first_name, p_last_name, p_email, p_phone_number);

    SET v_customer_id = LAST_INSERT_ID();

    -- Get product price
    SELECT price INTO v_product_price
    FROM products
    WHERE product_id = p_product_id;

    IF v_product_price IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid product ID';
    END IF;

    -- Calculate total amount
    SET v_total_amount = v_product_price * p_quantity;

    -- Insert order data
    INSERT INTO orders (customer_id, order_date, total_amount)
    VALUES (v_customer_id, CURDATE(), v_total_amount);

    SET v_order_id = LAST_INSERT_ID();

    -- Insert order item
    INSERT INTO order_items (order_id, product_id, quantity, price)
    VALUES (v_order_id, p_product_id, p_quantity, v_product_price);

    COMMIT;

    SELECT 'Order placed successfully' AS result;
END //

DELIMITER ;

-- 2. Call the Stored Procedure

-- Call with valid data
CALL AddCustomerAndOrder('Jan', 'Nowak', 'jan.nowak@example.com', '123-456-7890', 1, 2);

-- Call with invalid product ID
CALL AddCustomerAndOrder('Anna', 'Kowalska', 'anna.kowalska@example.com', '987-654-3210', 9999, 1);
