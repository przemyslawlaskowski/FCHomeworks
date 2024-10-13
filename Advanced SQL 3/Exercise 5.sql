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
