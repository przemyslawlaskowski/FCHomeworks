-- 1. Create a new database named ecommerce
CREATE DATABASE ecommerce;

USE ecommerce;

-- 2. Create the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15)
);

-- Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Create the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the order_items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. Insert sample data into the customers, products, orders, and order_items tables
START TRANSACTION;

INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES 
('Jan', 'Kowalski', 'jan.kowalski@example.com', '123-456-7890'),
('Anna', 'Nowak', 'anna.nowak@example.com', '098-765-4321'),
('Piotr', 'Wiśniewski', 'piotr.wisniewski@example.com', '456-123-7890'),
('Katarzyna', 'Wójcik', 'katarzyna.wojcik@example.com', '321-654-9870'),
('Tomasz', 'Lewandowski', 'tomasz.lewandowski@example.com', '789-012-3456');


INSERT INTO products (product_name, price, stock_quantity)
VALUES 
('Laptop', 999.99, 10),
('Smartfon', 699.99, 25),
('Słuchawki', 199.99, 50);


INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, '2024-09-29', 1699.97);


INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 999.99),
(1, 2, 1, 699.99);

-- 4. Commit the transaction
COMMIT;
