-- 1. Create a Materialized View Summarizing Total Sales by Month for Each Product
CREATE MATERIALIZED VIEW MonthlySalesSummary AS
SELECT 
    ProductID,
    DATE_FORMAT(SaleDate, '%Y-%m') AS SalesMonth,
    SUM(QuantitySold * PricePerUnit) AS TotalSales
FROM 
    Sales
GROUP BY 
    ProductID, DATE_FORMAT(SaleDate, '%Y-%m');

-- 2. Create a Materialized View to List the Top Customers Based on Total Spending
CREATE MATERIALIZED VIEW TopCustomers AS
SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CustomerName
ORDER BY 
    TotalSpent DESC;

-- 3. Create a script to refresh the Materialized View MonthlySalesSummary periodically
CREATE EVENT RefreshMonthlySalesSummary
ON SCHEDULE EVERY 1 DAY
DO
    REFRESH MATERIALIZED VIEW MonthlySalesSummary;

-- 4. Compare the performance of queries using TopCustomers vs querying base tables directly

EXPLAIN 
SELECT * FROM TopCustomers WHERE TotalSpent > 1000;


EXPLAIN 
SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    TotalSpent > 1000;

-- 5. Create a Materialized View Summarizing Current Stock Levels for Each Product
CREATE MATERIALIZED VIEW ProductStockSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.IloscNaStanie AS CurrentStock
FROM 
    Products p;
