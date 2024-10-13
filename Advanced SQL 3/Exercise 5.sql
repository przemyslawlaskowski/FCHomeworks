/*
 1.Create an event that archives orders older than 1 year from the orders table to an archived_orders table every month. The archived_orders table should have the same structure as the orders table.
Steps:

	Create the archived_orders table with the same schema as the orders table.
	Write an event to move records older than 1 year from the orders table to the archived_orders table.
	Schedule the event to run monthly.
 */


-- 1. Create the archived_orders table
CREATE TABLE archived_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    archived_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create the archiving procedure
DELIMITER //

CREATE PROCEDURE ArchiveOldOrders()
BEGIN
    INSERT INTO archived_orders (order_id, customer_id, order_date, total_amount)
    SELECT order_id, customer_id, order_date, total_amount
    FROM orders
    WHERE order_date < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

    DELETE FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM archived_orders
    );
END //

DELIMITER ;

-- 3. Create and schedule the event
SET GLOBAL event_scheduler = ON;

DELIMITER //

CREATE EVENT archive_old_orders
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    CALL ArchiveOldOrders();
END //

DELIMITER ;

SHOW EVENTS;

/*
2.Create an event that updates the stock_quantity in the products table after an order is completed. The event should reduce the stock quantity based on the items in the order.
Steps:

       Create an event that triggers after a new order is inserted into the orders table.
       For each order item in the order_items table, reduce the stock_quantity in the products table accordingly.
       Ensure the event handles cases where stock might be insufficient.
*/

-- Enable the global event scheduler
SET GLOBAL event_scheduler = ON;

-- Create a procedure to update stock after an order
DELIMITER //

CREATE PROCEDURE UpdateStockAfterOrder(IN new_order_id INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE item_product_id INT;
    DECLARE item_quantity INT;
    DECLARE current_stock INT;
    
    -- Cursor for order items
    DECLARE cur CURSOR FOR 
        SELECT product_id, quantity 
        FROM order_items 
        WHERE order_id = new_order_id;
    
    -- Handler for end of data
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    -- Loop through order items
    read_loop: LOOP
        FETCH cur INTO item_product_id, item_quantity;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Check and update stock
        SELECT stock_quantity INTO current_stock
        FROM products
        WHERE product_id = item_product_id;
        
        IF current_stock >= item_quantity THEN
            UPDATE products
            SET stock_quantity = stock_quantity - item_quantity
            WHERE product_id = item_product_id;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for the product';
        END IF;
    END LOOP;
    
    CLOSE cur;
END //

-- Create a trigger to call the procedure after a new order
CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    CALL UpdateStockAfterOrder(NEW.order_id);
END //

DELIMITER ;

SHOW TRIGGERS;

/*
3.Create an event that checks the stock_quantity in the products table and sends an email notification if the stock for any product falls below a certain threshold (e.g., 10 units).
Steps:

	Create a stored procedure to check stock levels and print message.
	Schedule the event to run daily to review stock levels.
	Ensure the procedure includes error handling for printing failures.
*/

-- Create a table to store stock notifications
CREATE TABLE IF NOT EXISTS stock_notifications (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    product_name VARCHAR(100), 
    stock_quantity INT,   
    notification_date DATE 
);

-- Create a procedure to check stock levels
DELIMITER //

CREATE PROCEDURE CheckLowStock()
BEGIN
    -- Insert information about low stock products into the notifications table
    INSERT INTO stock_notifications (product_name, stock_quantity, notification_date)
    SELECT product_name, stock_quantity, CURDATE()
    FROM products
    WHERE stock_quantity < 10;

    -- Display notifications for today's date
    SELECT * FROM stock_notifications
    WHERE notification_date = CURDATE();
END //

DELIMITER ;

-- Create an event to check stock levels daily
CREATE EVENT IF NOT EXISTS daily_stock_check
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
    CALL CheckLowStock();

-- Enable the event scheduler
SET GLOBAL event_scheduler = ON;


SHOW EVENTS;

