-- 1. Create a Materialized View Summarizing Total Sales by Month for Each Product
CREATE MATERIALIZED VIEW MonthlySalesSummary AS
SELECT
    p.ProduktID,
    p.Nazwa AS ProductName,
    DATE_FORMAT(z.DataZamowienia, '%Y-%m') AS SalesMonth,
    SUM(sz.Ilosc * sz.Cena) AS TotalSales
FROM
    Produkty p
JOIN
    SzczegolyZamowienia sz ON p.ProduktID = sz.ProduktID
JOIN
    Zamowienia z ON sz.ZamowienieID = z.ZamowienieID
GROUP BY
    p.ProduktID, p.Nazwa, DATE_FORMAT(z.DataZamowienia, '%Y-%m');


-- 2. Create a Materialized View to List the Top Customers Based on Total Spending
CREATE MATERIALIZED VIEW TopCustomers AS
SELECT
    k.KlientID,
    k.Imie,
    k.Nazwisko,
    SUM(sz.Ilosc * sz.Cena) AS TotalSpent
FROM
    Klienci k
JOIN
    Zamowienia z ON k.KlientID = z.KlientID
JOIN
    SzczegolyZamowienia sz ON z.ZamowienieID = sz.ZamowienieID
GROUP BY
    k.KlientID, k.Imie, k.Nazwisko
ORDER BY
    TotalSpent DESC;

-- 3. Create a script to refresh the Materialized View MonthlySalesSummary periodically
CREATE EVENT RefreshMonthlySalesSummary
ON SCHEDULE EVERY 1 DAY
DO
    REFRESH MATERIALIZED VIEW MonthlySalesSummary;


-- 4. Compare the performance of queries using TopCustomers vs querying base tables directly

EEXPLAIN
SELECT * FROM TopCustomers WHERE TotalSpent > 1000;

EXPLAIN
SELECT
    k.KlientID,
    k.Imie,
    k.Nazwisko,
    SUM(sz.Ilosc * sz.Cena) AS TotalSpent
FROM
    Klienci k
JOIN
    Zamowienia z ON k.KlientID = z.KlientID
JOIN
    SzczegolyZamowienia sz ON z.ZamowienieID = sz.ZamowienieID
GROUP BY
    k.KlientID, k.Imie, k.Nazwisko
HAVING
    TotalSpent > 1000;


-- 5. Create a Materialized View Summarizing Current Stock Levels for Each Product
CREATE MATERIALIZED VIEW ProductStockSummary AS
SELECT
    p.ProduktID,
    p.Nazwa,
    p.IloscNaStanie
    
FROM
    Produkty p
