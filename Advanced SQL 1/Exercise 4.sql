-- 1. Create the Sales table with appropriate columns and constraints
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    SaleDate DATE NOT NULL,
    QuantitySold INT CHECK (QuantitySold > 0),
    PricePerUnit DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_ProductSales FOREIGN KEY (ProductID) REFERENCES Produkty(ProduktID)
);


-- 2. Insert sample data into the Sales table
INSERT INTO Sales (ProductID, SaleDate, QuantitySold, PricePerUnit) 
VALUES
(1, '2024-01-01', 5, 2500.00),
(2, '2024-01-02', 3, 1500.00),
(3, '2024-01-03', 10, 200.00),
(1, '2024-01-04', 2, 2500.00),
(2, '2024-01-05', 1, 1500.00), 
(3, '2024-01-06', 5, 200.00); 


-- 3. Display a ranking of products based on total sales in descending order
SELECT 
    p.Nazwa AS ProductName,
    SUM(s.QuantitySold * s.PricePerUnit) AS TotalSales
FROM 
    Sales s
JOIN 
    Produkty p ON s.ProductID = p.ProduktID
GROUP BY 
    p.ProduktID
ORDER BY 
    TotalSales DESC;

   
-- 4. Display sales data along with the sales difference between the current and previous transaction
SELECT 
    s1.SaleID, 
    s1.ProductID, 
    s1.SaleDate, 
    s1.QuantitySold, 
    s1.PricePerUnit, 
    (s1.QuantitySold * s1.PricePerUnit) AS TotalSaleAmount,
    (s1.QuantitySold * s1.PricePerUnit) - 
    (COALESCE((s2.QuantitySold * s2.PricePerUnit), 0)) AS SalesDifference
FROM 
    Sales s1
LEFT JOIN 
    Sales s2 
ON 
    s1.ProductID = s2.ProductID 
    AND s1.SaleDate > s2.SaleDate
    AND NOT EXISTS (SELECT 1 
                    FROM Sales s3 
                    WHERE s3.ProductID = s1.ProductID 
                    AND s3.SaleDate > s2.SaleDate 
                    AND s3.SaleDate < s1.SaleDate)
ORDER BY 
    s1.ProductID, s1.SaleDate;


   
-- 5. Calulate the average monthly sales for each product
SELECT 
    ProductID, 
    YEAR(SaleDate) AS Year, 
    MONTH(SaleDate) AS Month, 
    AVG(QuantitySold * PricePerUnit) AS AverageMonthlySales
FROM 
    Sales
GROUP BY 
    ProductID, Year, Month;

   
-- 6. Write an SQL query that will find the best sales day for each product, i.e., the day with the highest sales value
SELECT 
    ProductID, 
    SaleDate, 
    MAX(QuantitySold * PricePerUnit) AS HighestSales
FROM 
    Sales
GROUP BY 
    ProductID, SaleDate
ORDER BY 
    HighestSales DESC;

   
-- 7. Calculate the cumulative sum of sales for each product to see how total sales change over time
SELECT 
    SaleID, 
    ProductID, 
    SaleDate, 
    (QuantitySold * PricePerUnit) AS TotalSaleAmount,
    SUM(QuantitySold * PricePerUnit) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS CumulativeSales
FROM 
    Sales
ORDER BY 
    ProductID, SaleDate;

   
-- 8. Find the products that had the largest and smallest differences in sales between consecutive transactions
WITH SalesDifferences AS (
    SELECT 
        s1.ProductID, 
        s1.SaleDate, 
        (s1.QuantitySold * s1.PricePerUnit) AS TotalSaleAmount,
        (s1.QuantitySold * s1.PricePerUnit) - 
        COALESCE(s2.QuantitySold * s2.PricePerUnit, 0) AS SalesDifference
    FROM 
        Sales s1
    LEFT JOIN 
        Sales s2 
        ON s1.ProductID = s2.ProductID 
        AND s1.SaleDate > s2.SaleDate
        AND NOT EXISTS (SELECT 1 
                        FROM Sales s3 
                        WHERE s3.ProductID = s1.ProductID 
                        AND s3.SaleDate > s2.SaleDate 
                        AND s3.SaleDate < s1.SaleDate)
)
SELECT 
    ProductID, 
    MAX(SalesDifference) AS LargestSalesDifference,
    MIN(SalesDifference) AS SmallestSalesDifference
FROM 
    SalesDifferences
GROUP BY 
    ProductID;

