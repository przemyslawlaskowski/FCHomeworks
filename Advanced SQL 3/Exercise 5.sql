/*
1.Create a trigger that updates the `total_amount` in the `orders` table whenever a new row is inserted into the `order_items` table.
2.Create a trigger that checks the `stock_quantity` in the `products` table before inserting a new row into the `order_items` table. If there is insufficient stock, raise an error.
3.Create a trigger that logs the actions performed on the `orders` table into an `audit_log` table, recording the type of action (INSERT, UPDATE, DELETE) and the timestamp.
 */


-- Create audit_log table
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    record_id INT NOT NULL,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1. Trigger to update total_amount in orders table
DELIMITER //

CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT SUM(quantity * price)
        FROM order_items
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END;
//


-- 2. Trigger to check stock quantity before inserting into order_items
CREATE TRIGGER before_order_item_insert
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE stock INT;
    
    SELECT stock_quantity INTO stock
    FROM products
    WHERE product_id = NEW.product_id;
    
    IF stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product';
    END IF;
END;
//


-- 3. Trigger to log actions on orders table
CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action_type, record_id)
    VALUES ('orders', 'INSERT', NEW.order_id);
END;
//

CREATE TRIGGER after_order_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action_type, record_id)
    VALUES ('orders', 'UPDATE', NEW.order_id);
END;
//

CREATE TRIGGER after_order_delete
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action_type, record_id)
    VALUES ('orders', 'DELETE', OLD.order_id);
END;
//

DELIMITER ;
